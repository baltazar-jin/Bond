import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_mbtiles/flutter_map_mbtiles.dart';
import 'package:latlong2/latlong.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:bond/widgets/navbar.dart';
import 'package:bond/screens/user_screen.dart';
import 'package:bond/screens/circle_screen.dart';
import 'package:bond/screens/dashboard_screen.dart';
import 'package:bond/screens/alerts_screen.dart';
import 'dart:io';
import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});
  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  MbTilesTileProvider? _offlineProvider;
  bool _online = false;
  int _selectedIndex = 2;

  @override
  void initState() {
    super.initState();
    _initMap();
    Connectivity().onConnectivityChanged.listen(
      (s) => setState(() => _online = s != ConnectivityResult.none),
    );
  }

  Future<void> _initMap() async {
    try {
      // 1. Get app documents directory
      final dir = await getApplicationDocumentsDirectory();
      final mbtilesPath = '${dir.path}/cebu_ph.mbtiles';

      // 2. Check if file exists; if not, copy from assets
      final file = File(mbtilesPath);
      if (!await file.exists()) {
        final data = await rootBundle.load('assets/maps/cebu_ph.mbtiles');
        final bytes = data.buffer.asUint8List();
        await file.writeAsBytes(bytes);
      }

      // 3. Load MBTiles provider
      final provider = MbTilesTileProvider.fromPath(path: mbtilesPath);
      setState(() => _offlineProvider = provider);
    } catch (e) {
      debugPrint('Error loading MBTiles: $e');
    }
  }

  void _onItemTapped(int index) {
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
      // Stay on this screen
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

  @override
  Widget build(BuildContext ctx) {
    if (_offlineProvider == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cebu Disaster Map'),
        backgroundColor: Colors.orange,
      ),
      body: FlutterMap(
        options: const MapOptions(center: LatLng(10.3157, 123.8854), zoom: 12),
        children: [
          TileLayer(tileProvider: _offlineProvider!, minZoom: 10, maxZoom: 16),
          if (_online)
            TileLayer(
              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              userAgentPackageName: 'com.example.bond',
            ),
        ],
      ),
      bottomNavigationBar: Navbar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
