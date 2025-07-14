import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:bond/screens/circle_screen.dart';
import 'package:bond/screens/alerts_screen.dart';
import 'package:bond/screens/dashboard_screen.dart';
import 'package:bond/screens/user_screen.dart';
import 'package:bond/widgets/navbar.dart';
import 'package:bond/widgets/nearby_services.dart';


class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

List<NearbyService> _nearbyServices = [];

LatLngBounds? _lastFetchedBounds;

LatLngBounds _calculateBounds(LatLng center, double delta) {
  return LatLngBounds(
    LatLng(center.latitude - delta, center.longitude - delta),
    LatLng(center.latitude + delta, center.longitude + delta),
  );
}

class _MapScreenState extends State<MapScreen> {
  final List<Marker> _markers = [];
  Marker? _userLocationMarker;
  int _selectedIndex = 2; // ✅ This is the Map tab

  @override
  void initState() {
    super.initState();
    if (_markers.isEmpty) {
      _fetchPOIs();
    }
    _getUserLocation();
  }

  void _onItemTapped(int index) {
    if (_selectedIndex == index) return;
    setState(() => _selectedIndex = index);

    if (index == 0) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const DashboardScreen()),
      );
    } else if (index == 1) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const CircleScreen()),
      );
    } else if (index == 2) {
      // Stay on map
    } else if (index == 3) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => AlertsScreen()),
      );
    } else if (index == 4) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const UserScreen()),
      );
    }
  }

  Future<void> _getUserLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return;

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) return;
    }

    final position = await Geolocator.getCurrentPosition();

    if (!mounted) return;

    setState(() {
      _userLocationMarker = Marker(
        width: 50,
        height: 50,
        point: LatLng(position.latitude, position.longitude),
        child: const Icon(Icons.my_location, color: Colors.blue, size: 30),
      );
    });

    Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 10,
      ),
    ).listen((pos) {
      if (!mounted) return;

      final userLatLng = LatLng(pos.latitude, pos.longitude);

      // ✅ Avoid refetching unless user moved out of previous bounds
      final newBounds = _calculateBounds(userLatLng, 0.01);
      if (_lastFetchedBounds == null || !_lastFetchedBounds!.contains(userLatLng)) {
        _fetchPOIs();
        _lastFetchedBounds = newBounds;
      }

      final Distance distance = Distance();
      final List<NearbyService> policeList = [];
      final List<NearbyService> fireList = [];
      final List<NearbyService> hospitalList = [];

      for (var marker in _markers) {
        final tooltip = marker.child as Tooltip;
        final icon = tooltip.child as Icon;
        final name = tooltip.message ?? 'Unknown';
        final type = icon.icon == Icons.local_police
            ? 'police'
            : icon.icon == Icons.local_fire_department
                ? 'fire_station'
                : icon.icon == Icons.local_hospital
                    ? 'hospital'
                    : 'unknown';

        final dist = distance(userLatLng, marker.point);
        final service = NearbyService(name: name, type: type, distanceMeters: dist);

        if (type == 'police') {
          policeList.add(service);
        } else if (type == 'fire_station') {
          fireList.add(service);
        } else if (type == 'hospital') {
          hospitalList.add(service);
        }
      }

      policeList.sort((a, b) => a.distanceMeters.compareTo(b.distanceMeters));
      fireList.sort((a, b) => a.distanceMeters.compareTo(b.distanceMeters));
      hospitalList.sort((a, b) => a.distanceMeters.compareTo(b.distanceMeters));

      setState(() {
        _userLocationMarker = Marker(
          width: 50,
          height: 50,
          point: userLatLng,
          child: const Icon(Icons.my_location, color: Colors.blue, size: 30),
        );

        _nearbyServices = [
          if (policeList.isNotEmpty) policeList.first,
          if (fireList.isNotEmpty) fireList.first,
          if (hospitalList.isNotEmpty) hospitalList.first,
        ];
      });
    });


    final Distance distance = Distance();
    final userLatLng = LatLng(position.latitude, position.longitude);

    final List<NearbyService> policeList = [];
    final List<NearbyService> fireList = [];
    final List<NearbyService> hospitalList = [];

    for (var marker in _markers) {
      final tooltip = marker.child as Tooltip;
      final icon = tooltip.child as Icon;
      final name = tooltip.message ?? 'Unknown';
      final type = icon.icon == Icons.local_police
          ? 'police'
          : icon.icon == Icons.local_fire_department
              ? 'fire_station'
              : icon.icon == Icons.local_hospital
                  ? 'hospital'
                  : 'unknown';

      final dist = distance(userLatLng, marker.point);
      final service = NearbyService(name: name, type: type, distanceMeters: dist);

      if (type == 'police') {
        policeList.add(service);
      } else if (type == 'fire_station') {
        fireList.add(service);
      } else if (type == 'hospital') {
        hospitalList.add(service);
      }
    }

    // Sort each type and take the closest one
    policeList.sort((a, b) => a.distanceMeters.compareTo(b.distanceMeters));
    fireList.sort((a, b) => a.distanceMeters.compareTo(b.distanceMeters));
    hospitalList.sort((a, b) => a.distanceMeters.compareTo(b.distanceMeters));

    setState(() {
      _nearbyServices = [
        if (policeList.isNotEmpty) policeList.first,
        if (fireList.isNotEmpty) fireList.first,
        if (hospitalList.isNotEmpty) hospitalList.first,
      ];
    });
  }

  Future<void> _fetchPOIs() async {
    const overpassUrl = 'https://overpass-api.de/api/interpreter?data='
        '[out:json];('
        'node["amenity"="police"](10.29,123.85,10.34,123.89);'
        'node["amenity"="fire_station"](10.29,123.85,10.34,123.89);'
        'node["amenity"="hospital"](10.29,123.85,10.34,123.89);'
        ');out;';

    try {
      final response = await http.get(Uri.parse(overpassUrl));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final elements = data['elements'] as List;

        final List<Marker> newMarkers = [];

        for (var element in elements) {
          final lat = element['lat'];
          final lon = element['lon'];
          final type = element['tags']?['amenity'] ?? 'unknown';
          final name = element['tags']?['name'] ?? 'Unnamed';

          IconData icon;
          Color color;

          switch (type) {
            case 'police':
              icon = Icons.local_police;
              color = Colors.blue;
              break;
            case 'fire_station':
              icon = Icons.local_fire_department;
              color = Colors.red;
              break;
            case 'hospital':
              icon = Icons.local_hospital;
              color = Colors.green;
              break;
            default:
              icon = Icons.location_on;
              color = Colors.grey;
          }

          newMarkers.add(
            Marker(
              width: 40,
              height: 40,
              point: LatLng(lat, lon),
              child: Tooltip(
                message: name,
                child: Icon(icon, color: color, size: 30),
              ),
            ),
          );
        }

        if (!mounted) return;
        setState(() {
          _markers.clear();
          _markers.addAll(newMarkers);
        });
      } else {
        debugPrint('Failed to load POIs: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Error fetching POIs: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.yellow.withAlpha(128),
                Colors.orange.withAlpha(128),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: SafeArea(
            bottom: false,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Map',
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(color: Colors.black),
                ),
              ),
            ),
          ),
        ),
      ),

      body: Stack(
        children: [
          FlutterMap(
            options: MapOptions(
              initialCenter: LatLng(10.3157, 123.8854),
              initialZoom: 13,
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.example.bond',
              ),
              MarkerLayer(
                markers: [
                  ..._markers,
                  if (_userLocationMarker != null) _userLocationMarker!,
                ],
              ),
            ],
          ),
          NearbyServicesList(services: _nearbyServices),
        ],
      ),

      bottomNavigationBar: Navbar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
