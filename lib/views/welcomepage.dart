import 'package:flutter/material.dart';
import 'package:bond_v2/widgets/btm_navbar.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          //display a welcome message
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: Text(
              'Welcome to Bond!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
        ],
      ),

      bottomNavigationBar: BottomNavBarWidget(
        currentIndex: 0,
        onTap: (index) {
          // Handle navigation tap
        },
      ),
    );
  }
}