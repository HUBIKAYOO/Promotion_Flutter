import 'package:flutter/material.dart';
import 'package:upro/Customer/MyMenu.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.orange,
        scaffoldBackgroundColor: Colors.white,
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.black, fontFamily: 'Sarabun'),
          bodyMedium: TextStyle(color: Colors.black, fontFamily: 'Sarabun'),
        ),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.orange,
        scaffoldBackgroundColor: Colors.black,
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.white, fontFamily: 'Sarabun'),
          bodyMedium: TextStyle(color: Colors.white, fontFamily: 'Sarabun'),
        ),
      ),
      home: MyMenu(), // ใช้งาน ProductList อย่างถูกต้อง
    );
  }
}
