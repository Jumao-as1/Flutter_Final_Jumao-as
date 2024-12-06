import 'package:flutter/material.dart';
import 'screens/home_page.dart';
import 'screens/profile_page.dart';
import 'screens/data_page.dart';
import 'screens/map_page.dart';

void main() {
  runApp(DirectorsInfoApp());
}

class DirectorsInfoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Directors Info',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(), // Home Page Route
        '/profile': (context) => ProfilePage(), // Profile Page Route
        '/data': (context) => DataPage(), // Data Page Route
        '/map': (context) => MapPage(), // Map Page Route
      },
    );
  }
}
