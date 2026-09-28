import 'package:flutter/material.dart';
import 'views/map_view_screen.dart';

void main() {
  runApp(const IdrisiApp());
}

class IdrisiApp extends StatelessWidget {
  const IdrisiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Al-Idrisi Map Explorer',
      theme: ThemeData.dark(useMaterial3: true).copyWith(
        primaryColor: Colors.amber,
        appBarTheme: const AppBarTheme(backgroundColor: Color(0xFF1E1E1E)),
      ),
      home: const MapViewScreen(),
    );
  }
}