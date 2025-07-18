import 'package:flutter/material.dart';
import 'routes/routes.dart';

class BondApp extends StatelessWidget {
  const BondApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bond',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orangeAccent),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: appRoutes,
    );
  }
}
