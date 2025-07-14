import 'package:flutter/material.dart';
import 'package:bond/screens/map_screen.dart';
import 'package:bond/screens/circle_screen.dart';
import 'package:bond/screens/alerts_screen.dart';
import 'package:bond/screens/user_screen.dart';
import 'package:bond/widgets/header.dart';
import 'package:bond/widgets/navbar.dart';
import 'package:bond/widgets/SOS.dart';
import 'package:bond/widgets/user_card.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;
  bool _isNight = false; // track toggle state

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
    // index == 0 (Home) does nothing
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF9F3),
      body: SafeArea(
        child: SingleChildScrollView(
          // only vertical padding so header can go edge-to-edge horizontally
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// ▶️ NEW HEADER
              AppHeader(
                location: 'Apas, Cebu City',
                isNightMode: _isNight,
                onToggle: () => setState(() => _isNight = !_isNight),
              ),
              const SizedBox(height: 20),
              const SizedBox(height: 10),

              /// STATUS CARD 
              RiskStatusCard(
                 riskLevel: 'You are at risk',
                  weatherCondition: 'Cloudy',
                  humidity: 84,
                  temperature: 31,
                  windSpeed: 18,
                  isOnline: false,
                  isBluetoothOn: true,
                  batteryPercent: 86,
              ),
              
              const SizedBox(height: 20),

              /// QUICK ACTIONS 
              const Row(
                children: [
                  Icon(Icons.flash_on, color: Colors.orange, size: 25),
                  SizedBox(width: 4),
                  Text(
                    'Quick Actions',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFF2CC),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      child: Column(
                        children: const [
                          Icon(Icons.groups, color: Colors.orange, size: 25),
                          SizedBox(height: 6),
                          Text(
                            'View Your Circle',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            '5 Members',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFD9F8E5),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      child: Column(
                        children: const [
                          Icon(Icons.map, color: Colors.green, size: 25),
                          SizedBox(height: 4),
                          Text(
                            'View Maps',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            '5 Members',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              /// SOS INSTRUCTIONS (unchanged)
              const Row(
                children: [
                  Icon(Icons.warning, color: Colors.orange, size: 25),
                  SizedBox(width: 6),
                  Text(
                    'Send SOS Request',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              const Text(
                'Press the SOS button, your live location will be shared with the nearest help centre and your emergency contacts',
                style: TextStyle(fontSize: 12),
              ),
              const SizedBox(height: 20),

              /// SOS BUTTON (unchanged)
              Center(
                child: SOSButton(
                  onPressed:(){
                    //handle logic 
                    print('SOS pressed');
                  },
                ),
              ),
            ],
          ),
        ),
      ),

      /// BOTTOM NAVIGATION BAR (unchanged)
      ///
      bottomNavigationBar: Navbar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
