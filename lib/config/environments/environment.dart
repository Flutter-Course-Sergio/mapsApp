import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  static initEnvironment() async {
    await dotenv.load(fileName: '.env');
  }

  static String mapboxKey =
      dotenv.env['MAPBOX_KEY'] ?? 'No está configurado el MAPBOX_KEY';
}
