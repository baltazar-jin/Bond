import 'package:flutter/material.dart';
import 'package:bond/widgets/navbar.dart';
import 'package:bond/screens/alerts_screen.dart';
import 'package:bond/screens/dashboard_screen.dart';
import 'package:bond/screens/map_screen.dart';
import 'package:bond/screens/circle_screen.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserProfileViewState();
}

class _UserProfileViewState extends State<UserScreen> {
  int _selectedIndex = 4;

  // MOCK DATA – replace with actual device APIs or ViewModel values
  String phoneNumber = '09078334990';
  String location = 'Apas, Cebu City';
  int batteryPercent = 86;
  String heartRate = '72 bpm';
  bool isBluetoothOn = false;
  bool isNotificationsOn = true;

  void toggleBluetooth() {
    setState(() => isBluetoothOn = !isBluetoothOn);
  }

  void toggleNotifications() {
    setState(() => isNotificationsOn = !isNotificationsOn);
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
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const MapScreen()),
      );
    } else if (index == 3) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => AlertsScreen()),
      );
    }
    // index == 4 (User) – stay on current screen
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Gradient AppBar
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.yellow.withOpacity(0.5),
                Colors.orange.withOpacity(0.5),
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
                  'User Profile',
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
            child: Container(
              margin: const EdgeInsets.only(top: 0),
              padding: const EdgeInsets.all(24),
              child: ListView(
                children: [
                  const Text(
                    'User Details',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  _infoRow(Icons.phone, 'Phone Number', phoneNumber),
                  const SizedBox(height: 12),
                  _infoRow(Icons.location_on, 'Location', location),
                  const SizedBox(height: 12),
                  _infoRow(Icons.battery_full, 'Battery', '$batteryPercent%'),
                  const SizedBox(height: 12),
                  _infoRow(Icons.favorite, 'Heart Rate', heartRate),
                  const SizedBox(height: 12),
                  _infoRow(
                    Icons.bluetooth,
                    'Bluetooth',
                    isBluetoothOn ? 'Enabled' : 'Disabled',
                    trailing: Switch(
                      value: isBluetoothOn,
                      onChanged: (_) => toggleBluetooth(),
                      activeColor: Colors.orange,
                    ),
                  ),
                  const SizedBox(height: 12),
                  _infoRow(
                    Icons.notifications_active,
                    'Notifications',
                    isNotificationsOn ? 'Enabled' : 'Disabled',
                    trailing: Switch(
                      value: isNotificationsOn,
                      onChanged: (_) => toggleNotifications(),
                      activeColor: Colors.orange,
                    ),
                  ),
                  const SizedBox(height: 40),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.edit),
                      label: const Text('Change Number'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.logout, color: Colors.red),
                      label: const Text(
                        'Sign Out',
                        style: TextStyle(color: Colors.red),
                      ),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Colors.red),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                    ),
                  ),
                ],
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

  Widget _infoRow(
    IconData icon,
    String label,
    String value, {
    Widget? trailing,
  }) {
    return Row(
      children: [
        Icon(icon, color: Colors.orange),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(fontSize: 14, color: Colors.grey),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        if (trailing != null) trailing,
      ],
    );
  }
}
