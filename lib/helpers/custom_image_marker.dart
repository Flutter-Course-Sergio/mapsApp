import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart'
    show BitmapDescriptor;

Future<BitmapDescriptor> getAssetImageMarker() async {
  return BitmapDescriptor.asset(
      const ImageConfiguration(
          size: Size(30, 30)),
      'assets/images/custom-pin.png');
}
