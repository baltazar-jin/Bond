import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:bond/screens/map_screen.dart';
import 'package:bond/screens/circle_screen.dart';
import 'package:bond/screens/alerts_screen.dart';
import 'package:bond/screens/user_screen.dart';
import 'package:bond/widgets/header.dart';
import 'package:bond/widgets/navbar.dart';
import 'package:bond/widgets/SOS.dart';
import 'package:bond/widgets/user_card.dart';
import 'package:bond/widgets/quickaction.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;
  bool _isNight = false;

  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);

    if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => CircleScreen()),
      );
    } else if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const MapScreen()),
      );
    } else if (index == 3) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => AlertsScreen()),
      );
    } else if (index == 4) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const UserScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF9F3),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppHeader(
                location: 'Apas, Cebu City',
                isNightMode: _isNight,
                onToggle: () => setState(() => _isNight = !_isNight),
              ),
              const SizedBox(height: 24),

              RiskStatusCard(),

              const Row(
                children: [
                  Icon(Icons.flash_on, color: Colors.orange, size: 24),
                  SizedBox(width: 4),
                  Text(
                    'Quick Actions',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              Row(
                children: [
                  Expanded(
                    child: QuickActionButton(
                      icon: Icons.groups,
                      title: 'View Your Circle',
                      subtitle: '1 sent SOS • All safe',
                      backgroundColor: const Color(0xFFFFF2CC),
                      iconColor: Colors.orange,
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => CircleScreen()),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: QuickActionButton(
                      icon: Icons.map,
                      title: 'View Maps',
                      subtitle: 'Circle: Yellow • Nearby help',
                      backgroundColor: const Color(0xFFD9F8E5),
                      iconColor: Colors.green,
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const MapScreen()),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),
              const Row(
                children: [
                  Icon(Icons.warning, color: Colors.orange, size: 24),
                  SizedBox(width: 4),
                  Text(
                    'Send SOS Request',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              const Text(
                'Press the SOS button, your live location will be shared with the nearest help centre and your emergency contacts',
                style: TextStyle(fontSize: 12),
              ),
              const SizedBox(height: 20),

              /// SOS BUTTON (unchanged)
              Center(
                child: SOSButton(
                  onPressed: () {
                    print('SOS pressed');
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Navbar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
