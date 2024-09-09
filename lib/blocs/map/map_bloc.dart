import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../blocs.dart';

part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  final LocationBloc locationBloc;

  GoogleMapController? _mapController;

  MapBloc({required this.locationBloc}) : super(const MapState()) {
    on<OnMapInitializedEvent>(_onInitMap);

    on<OnMapStartFollowingUser>(_onStartFollowingUser);

    on<OnMapStopFollowingUser>(_onStopFollowingUser);

    locationBloc.stream.listen((locationState) {
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

  void moveCamera(LatLng newLocation) {
    final cameraUpdate = CameraUpdate.newLatLng(newLocation);
    _mapController?.animateCamera(cameraUpdate);
  }
}
