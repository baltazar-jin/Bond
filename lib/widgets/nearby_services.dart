import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';

class NearbyService {
  final String name;
  final String type; // e.g. "police", "fire_station", "hospital"
  final double distanceMeters;

  NearbyService({
    required this.name,
    required this.type,
    required this.distanceMeters,
  });
}

class NearbyServicesList extends StatelessWidget {
  final List<NearbyService> services;

  const NearbyServicesList({super.key, required this.services});

  @override
  Widget build(BuildContext context) {
    if (services.isEmpty) return const SizedBox.shrink();

    return Positioned(
      bottom: 80,
      left: 16,
      right: 16,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: services.map((s) {
            return Column(
              children: [
                ListTile(
                  leading: Icon(
                    _getIcon(s.type),
                    color: _getColor(s.type),
                    size: 28,
                  ),
                  title: Text(
                    s.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                  subtitle: Text(
                    '${(s.distanceMeters / 1609.34).toStringAsFixed(1)} mi',
                    style: const TextStyle(fontSize: 13),
                  ),
                ),
                if (s != services.last)
                  const Divider(height: 1, thickness: 0.6, indent: 16, endIndent: 16),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }

  IconData _getIcon(String type) {
    switch (type) {
      case 'police':
        return Icons.local_police;
      case 'fire_station':
        return Icons.local_fire_department;
      case 'hospital':
        return Icons.local_hospital;
      default:
        return Icons.location_on;
    }
  }

  Color _getColor(String type) {
    switch (type) {
      case 'police':
        return Colors.blue;
      case 'fire_station':
        return Colors.red;
      case 'hospital':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }
}
