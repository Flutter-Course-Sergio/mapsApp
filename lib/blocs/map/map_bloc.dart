import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

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
    final myRoute = Polyline(
        polylineId: const PolylineId('myRoute'),
        color: Colors.black,
        width: 5,
        startCap: Cap.roundCap,
        endCap: Cap.roundCap,
        points: event.locationHistory);

    final currentPolylines = Map<String, Polyline>.from(state.polylines);
    currentPolylines['myRoute'] = myRoute;

    emit(state.copyWith(polylines: currentPolylines));
  }

  void _toggleShowMyRoute(OnToggleShowRoute event, Emitter emit) {
    emit(state.copyWith(showMyRoute: !state.showMyRoute));
  }

  void moveCamera(LatLng newLocation) {
    final cameraUpdate = CameraUpdate.newLatLng(newLocation);
    _mapController?.animateCamera(cameraUpdate);
  }

  @override
  Future<void> close() {
    locationStateSuscription?.cancel();
    return super.close();
  }
}
