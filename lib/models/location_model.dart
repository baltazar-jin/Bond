class LocationModel {
  final String name;
  final String
  type; // “hospital”, “evacuation_center”, “police”, “fire_station”
  final double lat, lng;
  final String address;

  LocationModel({
    required this.name,
    required this.type,
    required this.lat,
    required this.lng,
    required this.address,
  });

  factory LocationModel.fromJson(Map<String, dynamic> j) => LocationModel(
    name: j['name'],
    type: j['type'],
    lat: (j['lat'] as num).toDouble(),
    lng: (j['lng'] as num).toDouble(),
    address: j['address'],
  );
}
