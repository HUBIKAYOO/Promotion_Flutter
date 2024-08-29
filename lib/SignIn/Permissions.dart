import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:upro/Customer/MyMenu.dart';
import 'package:upro/IP.dart';
import 'package:upro/SignIn/Login/Login.dart';
import 'package:upro/SignIn/Login/UserID.dart';
import 'package:upro/SignIn/personal/personal.dart';

class Permissions extends StatefulWidget {
  Permissions({super.key});

  @override
  State<Permissions> createState() => _PermissionsState();
}

class _PermissionsState extends State<Permissions> {
  Future<String?> fetchUserIdByEmailOrPhone(
      {String? email, String? phoneNumber}) async {
    try {
      final response = await http.post(
        Uri.parse("http://$IP/check-user"),
        body: jsonEncode({
          if (email != null) 'email': email,
          if (phoneNumber != null) 'phone_number': phoneNumber,
        }),
        headers: {"Content-Type": "application/json"},
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        String userId = data['user_id'].toString(); // แปลงเป็น String
        // เก็บค่า user_id ลงใน UserIdProvider
        Provider.of<UserIdProvider>(context, listen: false).setUserId(userId);
        return userId;
      } else if (response.statusCode == 404) {
        return null; // ไม่พบผู้ใช้
      } else {
        throw Exception('Failed to fetch user data');
      }
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final user = FirebaseAuth.instance.currentUser;
            if (user != null) {
              return FutureBuilder<String?>(
                future: fetchUserIdByEmailOrPhone(
                  email: user.email,
                  phoneNumber: user.phoneNumber,
                ),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasData && snapshot.data != null) {
                    // พบผู้ใช้ในฐานข้อมูล ไปที่ MyMenu
                    return MyMenu(user_id: snapshot.data);
                  } else {
                    // ไม่พบผู้ใช้ ไปที่ Personal พร้อมส่งข้อมูลอีเมลและชื่อ หรือเบอร์โทร
                    return Personal(
                      email: user.email ?? '',
                      name: user.displayName ?? 'Unknown',
                      phoneNumber: user.phoneNumber ?? '',
                    );
                  }
                },
              );
            } else {
              return Login(); // หากไม่สามารถดึงข้อมูลผู้ใช้ได้ให้ไปที่หน้า Login
            }
          } else {
            return Login(); // หากผู้ใช้ยังไม่ล็อกอินให้ไปที่หน้า Login
          }
        },
      ),
    );
  }
}
