// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'map_bloc.dart';

class MapState extends Equatable {
  final bool isMapInitialized;
  final bool isFollowingUser;

  const MapState({this.isMapInitialized = false, this.isFollowingUser = true});

  @override
  List<Object> get props => [isMapInitialized, isFollowingUser];

  MapState copyWith({
    bool? isMapInitialized,
    bool? isFollowingUser,
  }) {
    return MapState(
      isMapInitialized: isMapInitialized ?? this.isMapInitialized,
      isFollowingUser: isFollowingUser ?? this.isFollowingUser,
    );
  }
}
