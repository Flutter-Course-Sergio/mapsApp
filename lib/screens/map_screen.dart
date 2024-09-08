import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/blocs.dart';
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
        builder: (context, state) {
          if (state.lastKnowLocation == null) {
            return const Center(
              child: Text('Espere por favor...'),
            );
          }

          return SingleChildScrollView(
            child: Stack(
              children: [
                MapView(initialLocation: state.lastKnowLocation!),
              ],
            ),
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          CustomFloatingActionButton(
            icon: Icons.my_location_outlined,
            onPressed: () {
              final mapBloc = BlocProvider.of<MapBloc>(context);
              final userLocation = locationBloc.state.lastKnowLocation;
              if (userLocation != null) mapBloc.moveCamera(userLocation);
            },
          )
        ],
      ),
    );
  }
}
