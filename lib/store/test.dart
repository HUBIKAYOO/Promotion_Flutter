import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:upro/store/test1.dart';
import 'package:upro/store/test2.dart';

class NumberInputWidget extends StatefulWidget {
  @override
  _NumberInputWidgetState createState() => _NumberInputWidgetState();
}

class _NumberInputWidgetState extends State<NumberInputWidget> {
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final anotherProvider = Provider.of<AnotherProvider>(context); // ใช้ Provider

    return Scaffold(
      extendBodyBehindAppBar:true,
      appBar: AppBar(title: Text('Number Input Widget'),backgroundColor: Colors.transparent,),
      body: Container(
        color: Colors.amber,
        child: Center(
          child: Column(
            children: [
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.number, // ใช้คีย์บอร์ดสำหรับตัวเลข
                decoration: InputDecoration(
                  labelText: 'Enter a number',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              InkWell(
                onTap: () {
                  // รับค่าจาก TextFormField และอัปเดตใน AnotherProvider
                  int? number = int.tryParse(_emailController.text);
                  if (number != null) {
                    anotherProvider.increment(number); // เรียกใช้เมธอดใน AnotherProvider
                     Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Test2()));
                  }
                },
                child: Text(
                  "ส่ง",
                  style: TextStyle(fontSize: 50),
                ),
              ),
              SizedBox(height: 20),
              // ใช้ Consumer หรือ Provider.of เพื่อแสดงค่าจาก AnotherProvider
              Text(
                'Stored number: ${anotherProvider.count}', // แสดงค่าจาก AnotherProvider
                style: TextStyle(fontSize: 20),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
