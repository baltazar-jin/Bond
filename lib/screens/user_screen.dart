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
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (_) => const DashboardScreen()));
    } else if (index == 1) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => const CircleScreen()));
    } else if (index == 2) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => const MapScreen()));
    } else if (index == 3) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => AlertsScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.yellow.withAlpha(127),
              Colors.orange.withAlpha(127),
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
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(color: Colors.black),
                ),
              ),
            ),
          ),
        ),
      ),
      backgroundColor: const Color(0xFFFFF9F3),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(24, 24, 24, 36),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            /// ✅ USER DETAILS CONTAINER
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                ],
              ),
            ),

            const SizedBox(height: 20),

            /// ✅ APP VERSION CONTAINER (SEPARATE)
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: const Color(0xFFF9F4E7),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Text(
                'App Version: 1.0.0',
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
            ),

            const SizedBox(height: 24),

            /// ✅ BUTTONS
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.edit, color: Colors.white),
                label: const Text(
                  'Change Number',
                  style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
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
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  side: const BorderSide(color: Colors.red),
                ),
              ),
            ),
          ],
        ),
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
