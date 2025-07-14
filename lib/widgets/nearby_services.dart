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
      left: 10,
      right: 10,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 6,
        child: SizedBox(
          height: 180,
          child: ListView.builder(
            itemCount: services.length,
            itemBuilder: (context, index) {
              final s = services[index];
              return ListTile(
                leading: Icon(
                  s.type == 'police'
                      ? Icons.local_police
                      : s.type == 'fire_station'
                          ? Icons.local_fire_department
                          : Icons.local_hospital,
                  color: s.type == 'police'
                      ? Colors.blue
                      : s.type == 'fire_station'
                          ? Colors.red
                          : Colors.green,
                ),
                title: Text(s.name),
                subtitle: Text('${s.distanceMeters.toStringAsFixed(0)} meters away'),
              );
            },
          ),
        ),
      ),
    );
  }
}
