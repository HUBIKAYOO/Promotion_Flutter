import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Profile_Image extends StatelessWidget {
  Profile_Image({super.key});
  final User? user = FirebaseAuth.instance.currentUser; // ตรวจสอบว่า user เป็น nullable

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.only(right: 10,left: 10,bottom: 10,top: 40),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 80,
            width: 80,
            color: Colors.transparent,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: user?.photoURL != null
                ? Image.network(
                    user!.photoURL!,
                    fit: BoxFit.cover, // ปรับให้ภาพไม่เกินขอบเขต
                    errorBuilder: (context, error, stackTrace) {
                      // แสดงภาพดีฟอลต์หากมีข้อผิดพลาดในการโหลดภาพ
                      return Icon(Icons.person, size: 80, color: Colors.grey);
                    },
                  )
                : Icon(Icons.person, size: 80, color: Colors.grey), // แสดงไอคอนแทนที่เมื่อไม่มี URL
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user?.displayName ?? "User Name",
                      style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                    Text(user?.email ?? "Email"),
                  ],
                ),
                Icon(Icons.settings, color: Colors.grey), // เพิ่มสัญลักษณ์ >
              ],
            ),
          ),
        ],
      ),
    );
  }
}
