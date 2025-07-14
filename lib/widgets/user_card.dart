import 'package:flutter/material.dart';

class RiskStatusCard extends StatelessWidget {
  const RiskStatusCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: const Color(0xFFFFD6D6),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          /// RISK ALERT HEADER (centered)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.error, color: Colors.red, size: 24),
              SizedBox(width: 8),
              Text(
                'You are at risk',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          /// WEATHER INFO
          Row(
            children: const [
              Icon(Icons.cloud, color: Colors.black54),
              SizedBox(width: 8),
              Text(
                'Weather:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(width: 4),
              Text('Cloudy'),
            ],
          ),
          const SizedBox(height: 10),

          /// WEATHER METRICS IN A HORIZONTAL LIST
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: const [
              _MetricItem(label: 'Humidity', value: '84%'),
              _MetricItem(label: 'Temp', value: '31°C'),
              _MetricItem(label: 'Wind', value: '18 km/h'),
            ],
          ),
          const SizedBox(height: 10),
          const Divider(color: Colors.redAccent, thickness: 0.8),

          /// DEVICE STATUS (HORIZONTAL LIST)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: const [
              _StatusItem(
                icon: Icons.wifi_off,
                label: 'Status: Offline',
                color: Colors.red,
              ),
              _StatusItem(
                icon: Icons.bluetooth,
                label: 'Bluetooth: Enabled',
                color: Colors.green,
              ),
              _StatusItem(
                icon: Icons.battery_full,
                label: 'Battery: 86%',
                color: Colors.green,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _MetricItem extends StatelessWidget {
  final String label;
  final String value;

  const _MetricItem({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(label, style: const TextStyle(fontSize: 12, color: Colors.black54)),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}

class _StatusItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;

  const _StatusItem({
    required this.icon,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 16, color: color),
        const SizedBox(width: 4),
        Text(label, style: const TextStyle(fontSize: 12)),
      ],
    );
  }
}
