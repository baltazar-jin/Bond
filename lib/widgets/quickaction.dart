import 'package:flutter/material.dart';

class QuickActionButton extends StatelessWidget {
  final Color backgroundColor;
  final IconData icon;
  final Color iconColor;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const QuickActionButton({
    super.key,
    required this.backgroundColor,
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: iconColor, size: 32),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 12,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class QuickActionMockupDemo extends StatefulWidget {
  const QuickActionMockupDemo({super.key});

  @override
  State<QuickActionMockupDemo> createState() => _QuickActionMockupDemoState();
}

class _QuickActionMockupDemoState extends State<QuickActionMockupDemo> {
  bool _isBleActive = false;

  void _toggleBle() {
    setState(() {
      _isBleActive = !_isBleActive;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          _isBleActive ? 'Started Mesh BLE' : 'Stopped Mesh BLE',
        ),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 130, // Ensures layout renders correctly
      child: Row(
        children: [
          Expanded(
            child: QuickActionButton(
              icon:
                  _isBleActive ? Icons.handshake : Icons.handshake_outlined,
              title: _isBleActive ? 'Stop Mesh BLE' : 'Start Mesh BLE',
              subtitle: _isBleActive
                  ? 'Scanning & Advertising'
                  : 'Tap to start mesh',
              backgroundColor: const Color(0xFFE1F3FF),
              iconColor: Colors.blue,
              onTap: _toggleBle,
            ),
          ),
        ],
      ),
    );
  }
}
