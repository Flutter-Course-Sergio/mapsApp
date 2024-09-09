import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/blocs.dart';
import '../ui/ui.dart';
import '../views/views.dart';
import '../widgets/widgets.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late LocationBloc locationBloc;

  @override
  void initState() {
    super.initState();
    locationBloc = BlocProvider.of<LocationBloc>(context);
    locationBloc.startFollowingUser();
  }

  @override
  void dispose() {
    locationBloc.stopFollowingUser();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<LocationBloc, LocationState>(
        builder: (context, locationState) {
          if (locationState.lastKnowLocation == null) {
            return const Center(
              child: Text('Espere por favor...'),
            );
          }

          return BlocBuilder<MapBloc, MapState>(
            builder: (context, mapState) {
              return MapScrollView(
                locationState: locationState,
                mapState: mapState,
              );
            },
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          BlocBuilder<MapBloc, MapState>(builder: (context, state) {
            return CustomFloatingActionButton(
                icon: state.isFollowingUser
                    ? Icons.directions_run_rounded
                    : Icons.hail_rounded,
                onPressed: () => startFollowingUser(context));
          }),
          CustomFloatingActionButton(
            icon: Icons.my_location_outlined,
            onPressed: () => moveCameraOnPressed(context),
          ),
        ],
      ),
    );
  }

  void moveCameraOnPressed(BuildContext context) {
    final locationBloc = BlocProvider.of<LocationBloc>(context);
    final mapBloc = BlocProvider.of<MapBloc>(context);
    final userLocation = locationBloc.state.lastKnowLocation;
    if (userLocation == null) {
      final snackBar = CustomSnackbar(message: 'No hay ubicación');
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      mapBloc.moveCamera(userLocation);
    }
  }

  void startFollowingUser(BuildContext context) {
    final mapBloc = BlocProvider.of<MapBloc>(context);
    mapBloc.add(OnMapStartFollowingUser());
  }
}

class MapScrollView extends StatelessWidget {
  final LocationState locationState;
  final MapState mapState;

  const MapScrollView({
    super.key,
    required this.locationState,
    required this.mapState,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Stack(
        children: [
          MapView(
              initialLocation: locationState.lastKnowLocation!,
              polylines: mapState.polylines.values.toSet()),
        ],
      ),
    );
  }
}
