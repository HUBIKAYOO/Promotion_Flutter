import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:upro/SignIn/Permissions.dart';

class Profile extends StatelessWidget {
  Profile({super.key});
  final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('โปรไฟล์ของ ${user!.email}'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
          color: Colors.yellow,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.network("${user!.photoURL}"),
              Text('${user!.displayName}'),
              SizedBox(
                height: 20,
              ),
              Text('ข้อมูลทั้งหมดจาก Firebase : ${user}'),
              ElevatedButton(
                onPressed: () {
                  _signout(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  fixedSize: Size(450, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7),
                  ),
                ),
                child: Text("ออกจากระบบ"),
              )
            ],
          ),
        ),
      ),
    );
  }

  _signout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => Permissions()),
      ModalRoute.withName('/'), // กำหนดหน้าแรกเป็นจุดสิ้นสุดของการลบ
    );
  }
}
