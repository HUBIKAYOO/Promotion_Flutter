import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:upro/store/test1.dart';

class Test2 extends StatelessWidget {
  const Test2({super.key});

  @override
  Widget build(BuildContext context) {
    // ใช้ Provider.of<AnotherProvider>(context) เพื่อเข้าถึงข้อมูล
    final anotherProvider = Provider.of<AnotherProvider>(context);
    
    return Scaffold(
      appBar: AppBar(title: Text('Test2')), // เพิ่ม AppBar
      body: Center(
        child: Text(
          'Stored number: ${anotherProvider.count}', // แสดงค่าจาก AnotherProvider
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
