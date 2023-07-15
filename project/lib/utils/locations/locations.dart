import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:json_annotation/json_annotation.dart';

part 'locations.g.dart';

@JsonSerializable()
class LatLng {
  LatLng({
    required this.lat,
    required this.lng,
  });

  factory LatLng.fromJson(Map<String, dynamic> json) => _$LatLngFromJson(json);
  Map<String, dynamic> toJson() => _$LatLngToJson(this);

  final double lat;
  final double lng;
}

@JsonSerializable()
class Region {
  Region({
    required this.coords,
    required this.id,
    required this.name,
    required this.zoom,
  });

  factory Region.fromJson(Map<String, dynamic> json) => _$RegionFromJson(json);
  Map<String, dynamic> toJson() => _$RegionToJson(this);

  final LatLng coords;
  final String id;
  final String name;
  final double zoom;
}

@JsonSerializable()
class Place {
  Place({
    required this.address,
    required this.id,
    required this.lat,
    required this.lng,
    required this.name,
  });

  factory Place.fromJson(Map<String, dynamic> json) => _$PlaceFromJson(json);
  Map<String, dynamic> toJson() => _$PlaceToJson(this);

  final String address;
  final String id;
  final double lat;
  final double lng;
  final String name;
}

@JsonSerializable()
class Locations {
  Locations({
    required this.places,
  });

  factory Locations.fromJson(Map<String, dynamic> json) =>
      _$LocationsFromJson(json);
  Map<String, dynamic> toJson() => _$LocationsToJson(this);

  final List<Place> places;
}

Future<Locations> getFCTplaces(simple) async {
  // Fallback for when the above HTTP request fails.
  if(simple)
    return Locations.fromJson(
      json.decode(
        await rootBundle.loadString('assets/locations/locations_simple.json'),
      ) as Map<String, dynamic>,
    );
  else return Locations.fromJson(
    json.decode(
      await rootBundle.loadString('assets/locations/locations.json'),
    ) as Map<String, dynamic>,
  );
}