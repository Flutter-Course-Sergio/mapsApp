// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'map_bloc.dart';

class MapState extends Equatable {
  final bool isMapInitialized;
  final bool followUser;

  const MapState({this.isMapInitialized = false, this.followUser = true});

  @override
  List<Object> get props => [isMapInitialized, followUser];

  MapState copyWith({
    bool? isMapInitialized,
    bool? followUser,
  }) {
    return MapState(
      isMapInitialized: isMapInitialized ?? this.isMapInitialized,
      followUser: followUser ?? this.followUser,
    );
  }
}
