import 'package:flutter/material.dart';

class RiskStatusCard extends StatelessWidget {
  final String riskLevel; // e.g. "You are at risk"
  final String weatherCondition; // e.g. "Cloudy"
  final int humidity; // %
  final int temperature; // °C
  final int windSpeed; // km/h
  final bool isOnline;
  final bool isBluetoothOn;
  final int batteryPercent;

  const RiskStatusCard({
    super.key,
    required this.riskLevel,
    required this.weatherCondition,
    required this.humidity,
    required this.temperature,
    required this.windSpeed,
    required this.isOnline,
    required this.isBluetoothOn,
    required this.batteryPercent,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.red.shade100,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Risk Indicator
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              Icon(Icons.cancel, color: Colors.red, size: 20),
              SizedBox(width: 8),
              Text(
                'You are at risk',
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Weather Info
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(Icons.cloud, color: Colors.black54, size: 20),
              const SizedBox(width: 8),
              Text(
                'Weather: $weatherCondition',
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Humidity: $humidity%'),
              Text('Temp: $temperature°C'),
              Text('Wind: $windSpeed km/h'),
            ],
          ),

          const SizedBox(height: 12),

          // Status Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.wifi_off,
                      size: 16,
                      color: isOnline ? Colors.green : Colors.red),
                  const SizedBox(width: 4),
                  Text('Status: ${isOnline ? "Online" : "Offline"}'),
                ],
              ),
              Row(
                children: [
                  Icon(Icons.bluetooth,
                      size: 16,
                      color: isBluetoothOn ? Colors.green : Colors.red),
                  const SizedBox(width: 4),
                  Text('Bluetooth: ${isBluetoothOn ? "Enabled" : "Disabled"}'),
                ],
              ),
              Row(
                children: [
                  const Icon(Icons.battery_full,
                      size: 16, color: Colors.green),
                  const SizedBox(width: 4),
                  Text('Battery: $batteryPercent%'),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
