part of 'map_bloc.dart';

sealed class MapEvent extends Equatable {
  const MapEvent();

  @override
  List<Object> get props => [];
}

class OnMapInitializedEvent extends MapEvent {
  final GoogleMapController controller;

  const OnMapInitializedEvent(this.controller);
}

class OnMapStartFollowingUser extends MapEvent {}

class OnMapStopFollowingUser extends MapEvent {}

class UpdateUserPolylineEvent extends MapEvent {
  final List<LatLng> locationHistory;
  const UpdateUserPolylineEvent(this.locationHistory);
}

class OnToggleShowRoute extends MapEvent {}
