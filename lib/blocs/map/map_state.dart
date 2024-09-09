// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'map_bloc.dart';

class MapState extends Equatable {
  final bool isMapInitialized;
  final bool isFollowingUser;

  final Map<String, Polyline> polylines;

  const MapState(
      {this.isMapInitialized = false,
      this.isFollowingUser = true,
      Map<String, Polyline>? polylines})
      : polylines = polylines ?? const {};

  @override
  List<Object> get props => [isMapInitialized, isFollowingUser, polylines];

  MapState copyWith(
      {bool? isMapInitialized,
      bool? isFollowingUser,
      Map<String, Polyline>? polylines}) {
    return MapState(
        isMapInitialized: isMapInitialized ?? this.isMapInitialized,
        isFollowingUser: isFollowingUser ?? this.isFollowingUser,
        polylines: polylines ?? this.polylines);
  }
}
