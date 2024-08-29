import 'package:flutter/material.dart';

class Login_Image extends StatelessWidget {
  const Login_Image({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
                color: Colors.transparent,
                margin: EdgeInsets.only(bottom: 50),
                width: 100,
                height: 100,
                child: ClipRRect(
                  borderRadius:
                      BorderRadius.circular(50), // กำหนดขอบเขตของวงกลม
                  child: Image.asset('images/login/U.png'),
                ),
              );
  }
}