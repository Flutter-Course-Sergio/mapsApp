import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../helpers/helpers.dart';
import '../../models/models.dart';
import '../blocs.dart';

part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  final LocationBloc locationBloc;
  GoogleMapController? _mapController;
  LatLng? mapCenter;

  StreamSubscription<LocationState>? locationStateSuscription;

  MapBloc({required this.locationBloc}) : super(const MapState()) {
    on<OnMapInitializedEvent>(_onInitMap);

    on<OnMapStartFollowingUser>(_onStartFollowingUser);

    on<OnMapStopFollowingUser>(_onStopFollowingUser);

    on<UpdateUserPolylineEvent>(_onUpdatePolylineEvent);

    on<OnToggleShowRoute>(_toggleShowMyRoute);

    on<OnDisplayPolylinesEvent>(_onDrawRoutePolyline);

    locationStateSuscription = locationBloc.stream.listen((locationState) {
      if (locationState.lastKnowLocation != null) {
        add(UpdateUserPolylineEvent(locationState.locationHistory));
      }

      if (!state.isFollowingUser) return;
      if (locationState.lastKnowLocation == null) return;

      moveCamera(locationState.lastKnowLocation!);
    });
  }

  void _onInitMap(OnMapInitializedEvent event, Emitter emit) {
    _mapController = event.controller;
    emit(state.copyWith(isMapInitialized: true));
  }

  void _onStartFollowingUser(OnMapStartFollowingUser event, Emitter emit) {
    emit(state.copyWith(isFollowingUser: true));
    if (locationBloc.state.lastKnowLocation == null) return;
    moveCamera(locationBloc.state.lastKnowLocation!);
  }

  void _onStopFollowingUser(OnMapStopFollowingUser event, Emitter emit) {
    emit(state.copyWith(isFollowingUser: false));
  }

  void _onUpdatePolylineEvent(UpdateUserPolylineEvent event, Emitter emit) {
    final myRoute =
        createPolyline(id: 'myRoute', points: event.locationHistory);

    final currentPolylines = Map<String, Polyline>.from(state.polylines);
    currentPolylines['myRoute'] = myRoute;

    emit(state.copyWith(polylines: currentPolylines));
  }

  void _toggleShowMyRoute(OnToggleShowRoute event, Emitter emit) {
    emit(state.copyWith(showMyRoute: !state.showMyRoute));
  }

  void _onDrawRoutePolyline(OnDisplayPolylinesEvent event, Emitter emit) {
    emit(state.copyWith(polylines: event.polylines, markers: event.markers));
  }

  Future drawRoutePolyline(RouteDestination destination) async {
    final myRoute = createPolyline(id: 'route', points: destination.points);

    double kms = destination.distance / 1000;
    kms = (kms * 100).floorToDouble();
    kms /= 100;

    double tripDuration = (destination.duration / 60).floorToDouble();

    final startCustomMarker =
        await getStartCustomMarker(tripDuration.toInt(), 'Mi ubicación');
    final endCustomMarker = await getEndCustomMarker(kms.toInt(), destination.endPlace.text);

    final startMarker = Marker(
        markerId: const MarkerId('start'),
        anchor: const Offset(0.06, 1),
        position: destination.points.first,
        icon: startCustomMarker);

    final endMarker = Marker(
        markerId: const MarkerId('end'),
        position: destination.points.last,
        icon: endCustomMarker);

    final currentPolylines = Map<String, Polyline>.from(state.polylines);
    currentPolylines['route'] = myRoute;

    final currentMarkers = Map<String, Marker>.from(state.markers);
    currentMarkers['start'] = startMarker;
    currentMarkers['end'] = endMarker;

    add(OnDisplayPolylinesEvent(currentPolylines, currentMarkers));
  }

  void moveCamera(LatLng newLocation) {
    final cameraUpdate = CameraUpdate.newLatLng(newLocation);
    _mapController?.animateCamera(cameraUpdate);
  }

  Polyline createPolyline({required String id, required List<LatLng> points}) {
    return Polyline(
        polylineId: PolylineId(id),
        color: Colors.black,
        width: 5,
        startCap: Cap.roundCap,
        endCap: Cap.roundCap,
        points: points);
  }

  @override
  Future<void> close() {
    locationStateSuscription?.cancel();
    return super.close();
  }
}
