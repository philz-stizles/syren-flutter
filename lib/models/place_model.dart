class Place {
  final GeometryModel geometry;
  final String name;
  final String vicinity;

  Place({required this.geometry, required this.name, required this.vicinity});

  factory Place.fromJson(Map<String, dynamic> json) {
    return Place(
      geometry: GeometryModel.fromJson(json['geometry']),
      name: json['formatted_address'],
      vicinity: json['vicinity'],
    );
  }
}

class GeometryModel {
  final LocationModel location;

  GeometryModel({required this.location});

  GeometryModel.fromJson(Map<dynamic, dynamic> parsedJson)
      : location = LocationModel.fromJson(parsedJson['location']);
}

class LocationModel {
  final double lat;
  final double lng;

  LocationModel({required this.lat, required this.lng});

  factory LocationModel.fromJson(Map<dynamic, dynamic> parsedJson) {
    return LocationModel(lat: parsedJson['lat'], lng: parsedJson['lng']);
  }
}
