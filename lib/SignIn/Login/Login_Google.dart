import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Login_Google extends StatelessWidget {
  const Login_Google({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          _Login(context);
        },
        borderRadius: BorderRadius.circular(7),
        child: Container(
          padding: const EdgeInsets.only(left: 40),
          width: 300,
          height: 40,
          decoration: BoxDecoration(
            
            borderRadius: BorderRadius.circular(7),
            border: Border.all(color: Colors.grey),
          ),
          child: Row(
            children: [
              Image.asset(
                'images/login/Google.png',
                width: 24,
                height: 24,
              ),
              const SizedBox(width: 20),
              const Text(
                "ดำเนินการต่อด้วย Google",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _Login(BuildContext context) async {
    try {
      // ล็อกเอาต์จากบัญชีที่ล็อกอินอยู่
      await GoogleSignIn().signOut();

      // ล็อกอินใหม่และบังคับให้แสดง popup เลือกบัญชี
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      await FirebaseAuth.instance.signInWithCredential(credential);

      print("Login Success");
    } catch (e) {
      print("Login Failed: $e");
    }
  }
}
