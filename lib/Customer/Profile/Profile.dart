import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_launcher_icons/xml_templates.dart';
import 'package:upro/Customer/Popup_Confirm.dart';
import 'package:upro/Customer/Profile/Profile_Image.dart';
import 'package:upro/SignIn/Permissions.dart';

class Profile extends StatelessWidget {
  Profile({super.key});
  final User? user = FirebaseAuth.instance.currentUser;

  final List<String> NameStore = [
    'สมัครร้านค้า',
    'ยังไม่รู้จะใส่อะไร',
    'เหมือนกันเลยว่ะ',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          color: Color(0xFFEEEEEE),
          child: Column(
            mainAxisAlignment: MainAxisAlignment
                .start, // เปลี่ยนเป็น start เพื่อให้ช่องว่างที่มีอยู่ด้านบนและล่าง
            children: [
              Profile_Image(),
              _buildStore(),
              _buildStore(),
              _buildStore(),
              _buildStore(),
              _buildSignOut(context),
            ],
          ),
        ),
      ),
    );
  }

  _buildStore() => Container(
        color: Colors.white,
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.only(bottom: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: NameStore.asMap().entries.map((entry) {
            int index = entry.key;
            String name = entry.value;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.store,
                        color: Colors.orange, size: 45), // ไอคอนร้านค้า
                    SizedBox(width: 8), // ระยะห่างระหว่างไอคอนและข้อความ
                    Expanded(
                      child: Text(name, style: TextStyle(fontSize: 18)),
                    ),
                    Icon(Icons.chevron_right, color: Colors.grey), // ไอคอน >
                  ],
                ),
                if (index < NameStore.length - 1) // ตรวจสอบว่าไม่ใช่ตัวสุดท้าย
                  Divider(
                    color: Color(0xFFEEEEEE),
                    thickness: 2, // ความหนาของเส้น
                  ),
              ],
            );
          }).toList(),
        ),
      );

  _buildSignOut(BuildContext context) {
    return InkWell(
      onTap: () {
        showDialog(
                context: context,
                builder: (BuildContext context) {
                  return Popup_Confirm(
                      need: "ยืนยันการออกจากระบบ",
                      choose: 2,
                      click: (value) {
                        if (value == true) {
                           _signout(context);
                        } else {
                          Navigator.of(context).pop();
                        }
                      });
                });
      },
      child: Container(
        width: double.infinity,
        height: 40,
        margin: EdgeInsets.only(right: 10, left: 10, bottom: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
        ),
        alignment: Alignment.center,
        child: Text(
          "ออกจากระบบ",
          style: TextStyle(color: Colors.red),
        ),
      ),
    );
  }

  Future<void> _signout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => Permissions()),
      ModalRoute.withName('/'),
    );
  }
}
