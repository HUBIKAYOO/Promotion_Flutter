import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:upro/SignIn/Login/Login_Phone_OTP.dart';

class Login_Phone extends StatelessWidget {
  Login_Phone({super.key});
  final TextEditingController NumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.transparent,
      child: Column(
        children: [
          Text("ลงทะเบียนหรือเข้าสู่ระบบด้วยเบอร์โทรศัพท์"),
          SizedBox(height: 10),
          TextField(
            controller: NumberController,
            textAlign: TextAlign.center,
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
              hintText: "กรอกเบอร์โทรศัพท์ของคุณ",
              fillColor: Color(0xFFEEEEEE), // สีพื้นหลัง
              filled: true, // ต้องตั้งค่าเป็น true เพื่อให้สีแสดงผล
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(7),
                borderSide: BorderSide(
                  color: Colors.grey, // สีกรอบขอบตอนปกติ
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(7),
                borderSide: BorderSide(
                  color: Colors.orange, // สีกรอบขอบตอนกด
                  width: 2.0, // ความหนาของกรอบขอบตอนกด
                ),
              ),
            ),
          ),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              _otp(context); // ส่ง context ไปใน method
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange,
              fixedSize: Size(450, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(7),
              ),
            ),
            child: Text(
              "สมัคร",
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  _otp(BuildContext context) async {
    FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: NumberController.text,
      verificationCompleted: (phoneAuthCredential) {},
      verificationFailed: (error) {
        log(error.toString()); // ล็อก error ลงใน console
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("เกิดข้อผิดพลาด: ${error.message}")),
        ); // แสดงข้อความแจ้งเตือนผู้ใช้งาน
      },
      codeSent: (verificationId, forceResendingToken) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                Login_Phone_OTP(verificationId: verificationId),
          ),
        );
      },
      codeAutoRetrievalTimeout: (verificationId) {
        log('Auth Retrieval timeout');
      },
    );
  }
}
