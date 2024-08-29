import 'package:firebase_auth/firebase_auth.dart';

class Logout {
  static Future<void> logoutAll() async {
    await FirebaseAuth.instance.signOut();
  }
}
