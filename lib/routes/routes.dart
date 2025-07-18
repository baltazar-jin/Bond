import 'package:flutter/material.dart';
import '/screens/dashboard_screen.dart';

// Add other views as needed

final Map<String, WidgetBuilder> appRoutes = {
  '/': (context) => const DashboardScreen(),
  //'/confirmation': (context) => const ConfirmationView(),
  // Add more pages here
};
