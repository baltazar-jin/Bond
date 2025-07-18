import 'package:flutter/material.dart';
import 'package:bond/widgets/navbar.dart';
import 'package:bond/screens/alerts_screen.dart';
import 'package:bond/screens/dashboard_screen.dart';
import 'package:bond/screens/map_screen.dart';
import 'package:bond/screens/user_screen.dart';

class CircleScreen extends StatefulWidget {
  const CircleScreen({super.key});

  @override
  State<CircleScreen> createState() => _CircleScreenState();
}

class _CircleScreenState extends State<CircleScreen> {
  int _selectedIndex = 1;

  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);
    if (index == 0) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const DashboardScreen()),
      );
    } else if (index == 2) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const MapScreen()),
      );
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

  final List<Map<String, dynamic>> friends = [
    {
      'name': 'Eric Smith',
      'phone': '09228634690',
      'status': 'EMERGENCY',
      'location': 'Apas, Cebu City',
      'lastSeen': '6h ago',
      'battery': '100%',
      'heartRate': '85 bpm',
    },
  ];

  final List<Map<String, dynamic>> familyMembers = [
    {
      'name': 'Sarah Johnson',
      'phone': '09078334990',
      'status': 'EMERGENCY',
      'location': 'Apas, Cebu City',
      'lastSeen': '6h ago',
      'battery': '100%',
      'heartRate': '72 bpm',
    },
    {
      'name': 'Micheal Johnson',
      'phone': '09279364590',
      'status': 'SAFE',
      'location': 'Apas, Cebu City',
      'lastSeen': '20m ago',
      'battery': '100%',
      'heartRate': '91 bpm',
    },
    {
      'name': 'Emma Johnson',
      'phone': '09279364590',
      'status': 'SAFE',
      'location': 'Apas, Cebu City',
      'lastSeen': '20m ago',
      'battery': '100%',
      'heartRate': '64 bpm',
    },
  ];

  Color _statusColor(String status) {
    switch (status) {
      case 'EMERGENCY':
        return Colors.red;
      case 'SAFE':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  Widget _circleCard(Map<String, dynamic> person) {
    final statusColor = _statusColor(person['status']);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF9F3),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: person['status'] == 'EMERGENCY'
              ? Colors.red.shade200
              : Colors.grey.shade300,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Name and Status
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  person['name'],
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: statusColor,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    person['status'],
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),

            /// Phone and Battery
            Row(
              children: [
                const Icon(Icons.phone, size: 14, color: Colors.orange),
                const SizedBox(width: 4),
                Text(person['phone'], style: const TextStyle(fontSize: 13)),
                const Spacer(),
                const Icon(Icons.battery_full, size: 14, color: Colors.green),
                const SizedBox(width: 4),
                Text(person['battery'], style: const TextStyle(fontSize: 13)),
              ],
            ),
            const SizedBox(height: 2),

            /// Location and Last seen
            Row(
              children: [
                const Icon(Icons.location_on, size: 14, color: Colors.orange),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    person['location'],
                    style: const TextStyle(fontSize: 13),
                  ),
                ),
                const Icon(Icons.access_time, size: 14, color: Colors.grey),
                const SizedBox(width: 4),
                Text(person['lastSeen'], style: const TextStyle(fontSize: 13)),
              ],
            ),

            const SizedBox(height: 2),

             Row(
              children: [
                const Icon(Icons.favorite, size: 14, color: Colors.orange),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    person['heartRate'],
                    style: const TextStyle(fontSize: 13),
                  ),
                ),
                const SizedBox(width: 4),
                Text('View on Map', style: const TextStyle(fontSize: 13, color: Colors.orange, decoration: TextDecoration.underline)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _groupSection(String title, List<Map<String, dynamic>> group) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 14),
        Text(
          title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 6),
        ...group.map(_circleCard),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFCF8),

      // Gradient Header
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
                  'Your Circle',
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(color: Colors.black),
                ),
              ),
            ),
          ),
        ),
      ),

      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 20, 16, 40),
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton.icon(
              onPressed: () {
                // TODO: Add member logic
              },
              icon: const Icon(Icons.person_add, size: 16),
              label: const Text('Add'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                foregroundColor: Colors.white,
                elevation: 0,
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 10,
                ),
              ),
            ),
          ),
          _groupSection('Friends', friends),
          _groupSection('Family Members', familyMembers),
        ],
      ),

      bottomNavigationBar: Navbar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
