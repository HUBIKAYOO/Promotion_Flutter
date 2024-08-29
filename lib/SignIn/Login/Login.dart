import 'package:flutter/material.dart';
import 'package:upro/SignIn/Login/Login_Google.dart';
import 'package:upro/SignIn/Login/Login_Image.dart';
import 'package:upro/SignIn/Login/Login_Phone.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.only(left: 50,right: 50), // กำหนด padding ที่เพิ่มเติมเพื่อให้เนื้อหาอยู่กึ่งกลางจอ
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Login_Image(),
              Login_Phone(),
              SizedBox(height: 10),
              Row(
                children: [
                  Expanded(child: Divider(color: Colors.grey)),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      "หรือเข้าสู่ระบบด้วย",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                  Expanded(child: Divider(color: Colors.grey)),
                ],
              ),
              SizedBox(height: 10),
              Login_Google(),
            ],
          ),
        ),
      ),
    );
  }
}
