import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Login_Phone_OTP extends StatefulWidget {
  const Login_Phone_OTP({super.key, required this.verificationId});
  final String verificationId;

  @override
  State<Login_Phone_OTP> createState() => _otppState();
}

class _otppState extends State<Login_Phone_OTP> {
  final otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("otp"),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(50),
          child: Column(
            children: [
              Text("otp"),
              SizedBox(height: 10),
              TextField(
                controller: otpController,
                textAlign: TextAlign.start,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  hintText: "otp",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(7),
                  ),
                ),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  _otp();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  fixedSize: Size(450, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7),
                  ),
                ),
                child: Text(
                  "ยืนยัน",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _otp() async {
    try {
      final crad = PhoneAuthProvider.credential(
          verificationId: widget.verificationId, smsCode: otpController.text);
      await FirebaseAuth.instance.signInWithCredential(crad);
      Navigator.pop(context);
    } catch (e) {
      log(e.toString());
    }
  }
}
