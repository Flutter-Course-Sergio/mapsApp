import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../blocs/blocs.dart';
import '../themes/themes.dart';

class MapView extends StatelessWidget {
  final LatLng initialLocation;

  const MapView({super.key, required this.initialLocation});

  @override
  Widget build(BuildContext context) {
    final mapBloc = BlocProvider.of<MapBloc>(context);

    final size = MediaQuery.of(context).size;

    final CameraPosition initialCameraPosition =
        CameraPosition(target: initialLocation, zoom: 15);

    return SizedBox(
        width: size.width,
        height: size.height,
        child: GoogleMap(
          initialCameraPosition: initialCameraPosition,
          myLocationEnabled: true,
          zoomControlsEnabled: false,
          myLocationButtonEnabled: false,
          style: jsonEncode(uberMapTheme),
          onMapCreated: (controller) =>
              mapBloc.add(OnMapInitializedEvent(controller)),
        ));
  }
}
