import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class RiskStatusCard extends StatefulWidget {
  const RiskStatusCard({super.key});

  @override
  State<RiskStatusCard> createState() => _RiskStatusCardState();
}

class _RiskStatusCardState extends State<RiskStatusCard> {
  String _status = "Loading...";
  Color _statusColor = Colors.grey;
  Timer? _refreshTimer;

  double? _tempC;
  double? _humidity;
  double? _windKph;

  Future<void> fetchFloodRisk() async {
    try {
      final url = Uri.parse("http://192.168.8.232:5000/predict-transition");

      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: json.encode({
          "temp_c": 29,
          "humidity": 88,
          "precip_mm": 15,
          "wind_kph": 10,
        }),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final probs = Map<String, dynamic>.from(data["probabilities"]);
        final weather = data["weather"];

        String status;
        Color color;

        if (probs["escalating"] > probs["decreasing"] &&
            probs["escalating"] > probs["stable"]) {
          status = "Yellow";
          color = Colors.amber;
        } else if (probs["decreasing"] > probs["escalating"] &&
            probs["decreasing"] > probs["stable"]) {
          status = "Green";
          color = Colors.green;
        } else {
          status = "Red";
          color = Colors.red;
        }

        if (!mounted) return;
        setState(() {
          _status = status;
          _statusColor = color;
          _tempC = weather["temp_c"]?.toDouble();
          _humidity = weather["humidity"]?.toDouble();
          _windKph = weather["wind_kph"]?.toDouble();
        });
      } else {
        throw Exception("Server error: ${response.statusCode}");
      }
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _status = "Error";
        _statusColor = Colors.grey;
        _tempC = null;
        _humidity = null;
        _windKph = null;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    Future.microtask(() => fetchFloodRisk());
    _refreshTimer = Timer.periodic(const Duration(hours: 1), (timer) {
      fetchFloodRisk();
    });
  }

  @override
  void dispose() {
    _refreshTimer?.cancel();
    super.dispose();
  }

  String getStatusLabel(String status) {
    switch (status) {
      case "Green":
        return "You are Safe";
      case "Yellow":
        return "Be Alert";
      case "Red":
        return "Danger";
      default:
        return status;
    }
  }

  IconData getStatusIcon(String status) {
    switch (status) {
      case "Green":
        return Icons.check_circle;
      case "Yellow":
        return Icons.warning;
      case "Red":
        return Icons.dangerous;
      default:
        return Icons.help_outline;
    }
  }

  @override
   Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: _statusColor.withOpacity(0.2),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(getStatusIcon(_status), color: _statusColor, size: 24),
              const SizedBox(width: 8),
              Text(
                getStatusLabel(_status),
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: _statusColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: const [
              Icon(Icons.cloud, color: Colors.black54),
              SizedBox(width: 8),
              Text(
                'Weather:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _MetricItem(label: 'Humidity', value: _humidity != null ? '${_humidity!.toStringAsFixed(0)}%' : '--'),
              _MetricItem(label: 'Temp', value: _tempC != null ? '${_tempC!.toStringAsFixed(1)}°C' : '--'),
              _MetricItem(label: 'Wind', value: _windKph != null ? '${_windKph!.toStringAsFixed(1)} km/h' : '--'),
            ],
          ),

          const SizedBox(height: 10),
          const Divider(color: Colors.black26),

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
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(label, style: const TextStyle(fontSize: 12, color: Colors.black54)),
        const SizedBox(height: 4),
        Text(value, style: const TextStyle(fontWeight: FontWeight.w600)),
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
