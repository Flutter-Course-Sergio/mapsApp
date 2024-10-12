import 'dart:convert';

class PlacesResponse {
  final String type;
  final List<String> query;
  final List<Feature> features;
  final String attribution;

  PlacesResponse({
    required this.type,
    required this.query,
    required this.features,
    required this.attribution,
  });

  factory PlacesResponse.fromRawJson(String str) =>
      PlacesResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PlacesResponse.fromJson(Map<String, dynamic> json) => PlacesResponse(
        type: json["type"],
        query: List<String>.from(json["query"].map((x) => x)),
        features: List<Feature>.from(
            json["features"].map((x) => Feature.fromJson(x))),
        attribution: json["attribution"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "query": List<dynamic>.from(query.map((x) => x)),
        "features": List<dynamic>.from(features.map((x) => x.toJson())),
        "attribution": attribution,
      };
}

class Feature {
  final String id;
  final String type;
  final List<String> placeType;

  final Properties properties;
  final String textEs;
  final Language? languageEs;
  final String placeNameEs;
  final String text;
  final Language? language;
  final String placeName;
  final String? matchingText;
  final String? matchingPlaceName;
  final List<double> center;
  final Geometry geometry;
  final List<Context> context;

  Feature({
    required this.id,
    required this.type,
    required this.placeType,
    required this.properties,
    required this.textEs,
    required this.languageEs,
    required this.placeNameEs,
    required this.text,
    required this.language,
    required this.placeName,
    required this.matchingText,
    required this.matchingPlaceName,
    required this.center,
    required this.geometry,
    required this.context,
  });

  factory Feature.fromRawJson(String str) => Feature.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Feature.fromJson(Map<String, dynamic> json) => Feature(
        id: json["id"],
        type: json["type"],
        placeType: List<String>.from(json["place_type"].map((x) => x)),
        properties: Properties.fromJson(json["properties"]),
        textEs: json["text_es"],
        languageEs: languageValues.map[json["language_es"]],
        placeNameEs: json["place_name_es"],
        text: json["text"],
        language: languageValues.map[json["language"]],
        placeName: json["place_name"],
        matchingText: json["matching_text"],
        matchingPlaceName: json["matching_place_name"],
        center: List<double>.from(json["center"].map((x) => x?.toDouble())),
        geometry: Geometry.fromJson(json["geometry"]),
        context:
            List<Context>.from(json["context"].map((x) => Context.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "place_type": List<dynamic>.from(placeType.map((x) => x)),
        "properties": properties.toJson(),
        "text_es": textEs,
        "language_es": languageValues.reverse[languageEs],
        "place_name_es": placeNameEs,
        "text": text,
        "language": languageValues.reverse[language],
        "place_name": placeName,
        "matching_text": matchingText,
        "matching_place_name": matchingPlaceName,
        "center": List<dynamic>.from(center.map((x) => x)),
        "geometry": geometry.toJson(),
        "context": List<dynamic>.from(context.map((x) => x.toJson()))
      };

  @override
  String toString() => 'Feature: $text';
}

class Context {
  final String id;
  final String mapboxId;
  final String textEs;
  final String text;
  final String? wikidata;
  final Language? languageEs;
  final Language? language;
  final String? shortCode;

  Context({
    required this.id,
    required this.mapboxId,
    required this.textEs,
    required this.text,
    required this.wikidata,
    required this.languageEs,
    required this.language,
    required this.shortCode,
  });

  factory Context.fromRawJson(String str) => Context.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Context.fromJson(Map<String, dynamic> json) => Context(
        id: json["id"],
        mapboxId: json["mapbox_id"],
        textEs: json["text_es"],
        text: json["text"],
        wikidata: json["wikidata"],
        languageEs: languageValues.map[json["language_es"]],
        language: languageValues.map[json["language"]],
        shortCode: json["short_code"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "mapbox_id": mapboxId,
        "text_es": textEs,
        "text": text,
        "wikidata": wikidata,
        "language_es": languageValues.reverse[languageEs],
        "language": languageValues.reverse[language],
        "short_code": shortCode,
      };
}

enum Language { EN, ES, FR }

final languageValues =
    EnumValues({"en": Language.EN, "es": Language.ES, "fr": Language.FR});

class Geometry {
  final String type;
  final List<double> coordinates;

  Geometry({
    required this.type,
    required this.coordinates,
  });

  factory Geometry.fromRawJson(String str) =>
      Geometry.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Geometry.fromJson(Map<String, dynamic> json) => Geometry(
        type: json["type"],
        coordinates:
            List<double>.from(json["coordinates"].map((x) => x?.toDouble())),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "coordinates": List<dynamic>.from(coordinates.map((x) => x)),
      };
}

class Properties {
  final String? wikidata;
  final String? category;
  final bool? landmark;
  final String? address;
  final String? foursquare;
  final String? maki;
  final String? mapboxId;

  Properties({
    required this.wikidata,
    required this.category,
    required this.landmark,
    required this.address,
    required this.foursquare,
    required this.maki,
    required this.mapboxId,
  });

  factory Properties.fromRawJson(String str) =>
      Properties.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Properties.fromJson(Map<String, dynamic> json) => Properties(
        wikidata: json["wikidata"],
        category: json["category"],
        landmark: json["landmark"],
        address: json["address"],
        foursquare: json["foursquare"],
        maki: json["maki"],
        mapboxId: json["mapbox_id"],
      );

  Map<String, dynamic> toJson() => {
        "wikidata": wikidata,
        "category": category,
        "landmark": landmark,
        "address": address,
        "foursquare": foursquare,
        "maki": maki,
        "mapbox_id": mapboxId,
      };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap ??= map.map((k, v) => MapEntry(v, k));
    return reverseMap!;
  }
}
