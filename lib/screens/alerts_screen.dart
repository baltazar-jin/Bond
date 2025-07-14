import 'package:flutter/material.dart';
import 'package:bond/widgets/navbar.dart';
import 'package:bond/screens/circle_screen.dart';
import 'package:bond/screens/map_screen.dart';
import 'package:bond/screens/user_screen.dart';
import 'package:bond/screens/dashboard_screen.dart';

class AlertsScreen extends StatefulWidget {
  const AlertsScreen({super.key});

  @override
  State<AlertsScreen> createState() => _AlertsScreenState();
}

class _AlertsScreenState extends State<AlertsScreen> {
  int _selectedIndex = 3;

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
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const MapScreen()),
      );
    } else if (index == 4) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const UserScreen()),
      );
    }
    // index == 3 is current screen
  }

  final List<Map<String, String>> _alerts = [
    {
      'severity': 'red',
      'title': 'Flash Flood Warning',
      'message': 'Avoid low-lying areas, Seek higher ground immediately.',
      'time': '2 min ago',
    },
    {
      'severity': 'red',
      'title': 'Typhoon Signal #3',
      'message':
          'Prepare emergency food and supplies. Evacuation centers now open, check evacuation centers near you.',
      'time': '2 min ago',
    },
    {
      'severity': 'yellow',
      'title': 'Continuous Rainfall Detected',
      'message':
          'Landslide-prone areas under watch. Prepare emergency food and supplies. Evacuation centers now open.',
      'time': '1 hour ago',
    },
    {
      'severity': 'green',
      'title': 'Normal Heart Beat',
      'message': 'Normal heart beat detected, normal condition',
      'time': '3 hours ago',
    },
  ];

  Color _dotColor(String severity) {
    switch (severity) {
      case 'red':
        return Colors.red;
      case 'yellow':
        return Colors.amber;
      default:
        return Colors.green;
    }
  }

  Widget _alertItem(Map<String, String> alert, bool isLast) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      color: _dotColor(alert['severity']!),
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      alert['title']!,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  Text(
                    alert['time']!,
                    style: const TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Text(alert['message']!, style: const TextStyle(fontSize: 13)),
            ],
          ),
        ),
        if (!isLast)
          Divider(height: 1, color: Colors.grey.shade300, thickness: 1),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Gradient Header (custom)
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.yellow.withAlpha((0.5 * 255).toInt()),
                Colors.orange.withAlpha((0.5 * 255).toInt()),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Emergency Alerts',
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(color: Colors.black),
                ),
              ),
            ),
          ),
        ),
      ),
      backgroundColor: const Color(0xFFFFF9F3),
      body: Column(
  children: [
    Expanded(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                children: [
                  Icon(Icons.error_outline, color: Colors.orange, size: 22),
                  SizedBox(width: 6),
                  Text(
                    'Recent Alerts',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    for (int i = 0; i < _alerts.length; i++)
                      _alertItem(_alerts[i], i == _alerts.length - 1),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              const Row(
                children: [
                  Icon(Icons.tips_and_updates, color: Colors.deepOrange, size: 22),
                  SizedBox(width: 6),
                  Text(
                    'Preparedness Tips',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              ..._buildPreparednessTips(),
            ],
          ),
        ),
      ),
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

List<Widget> _buildPreparednessTips() {
  return [
    _tipItem(
      'Emergency Kit Essentials',
      'Review your family emergency plan. Know where to meet and who to contact',
      'HIGH',
      Colors.red,
      const Color.fromRGBO(248, 91, 91, 0.3),
    ),
    _tipItem(
      'Weather Monitoring',
      'Stay informed about weather conditions and emergency alerts',
      'MEDIUM',
      Colors.orange,
      const Color.fromRGBO(255, 128, 1, 0.3),
    ),
    _tipItem(
      'Review Family',
      'Review your family emergency plan. Know where to meet and who to contact',
      'LOW',
      const Color.fromARGB(255, 200, 180, 0),
      const Color.fromRGBO(247, 227, 41, 0.3),
    ),
  ];
}

Widget _tipItem(
  String title,
  String description,
  String level,
  Color textColor,
  Color bgColor,
) {
  return Container(
    margin: const EdgeInsets.only(bottom: 8),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                description,
                style: const TextStyle(fontSize: 12, color: Colors.black87),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            level,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
        ),
      ],
    ),
  );
}
