import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:upro/Customer/MyMenu.dart';
import 'package:upro/SignIn/Login/Login.dart';
import 'package:upro/SignIn/Login/UserID.dart';
import 'package:upro/SignIn/Permissions.dart';
import 'package:upro/SignIn/personal/personal.dart';
import 'package:upro/store/test1.dart'; 

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserIdProvider()),
        ChangeNotifierProvider(create: (_) => AnotherProvider()),
      ],
      child: MyApp(),
    ),
  );
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
      home: Permissions(), // หน้าหลักเริ่มต้นของแอป
      routes: {
        '/login': (context) => Login(),
        '/permissions': (context) => Permissions(),
        '/personal': (context) => Personal(),
        '/menu': (context) => MyMenu(),
      },
    );
  }
}
