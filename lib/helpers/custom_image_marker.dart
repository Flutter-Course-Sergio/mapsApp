import 'dart:ui' as ui;

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart'
    show BitmapDescriptor;

Future<BitmapDescriptor> getAssetImageMarker() async {
  return BitmapDescriptor.asset(const ImageConfiguration(size: Size(30, 30)),
      'assets/images/custom-pin.png');
}

Future<BitmapDescriptor> getNetworkImageMarker() async {
  final resp = await Dio().get(
      'https://cdn4.iconfinder.com/data/icons/small-n-flat/24/map-marker-512.png',
      options: Options(responseType: ResponseType.bytes));

  final imageCodec = await ui.instantiateImageCodec(resp.data,
      targetHeight: 40, targetWidth: 40);
  final frame = await imageCodec.getNextFrame();
  final data = await frame.image.toByteData(format: ui.ImageByteFormat.png);

  if (data == null) return await getAssetImageMarker();

  return BitmapDescriptor.bytes(data.buffer.asUint8List());
}
