import 'package:flutter/material.dart';
import 'package:upro/Customer/promostion/Promostion_Bottombar.dart';
import 'package:upro/Customer/main/main_promotion.dart';
import 'package:upro/Customer/promostion/promostion_image.dart';
import 'package:upro/Customer/promostion/promostion_map.dart';

class Promostion extends StatefulWidget {
  final dynamic data;

  // คอนสตรัคเตอร์ที่รับข้อมูล
  Promostion({required this.data});

  @override
  _PromostionState createState() => _PromostionState();
}

class _PromostionState extends State<Promostion> {
  late Map<String, dynamic> _data;

  @override
  void initState() {
    super.initState();
    // ตั้งค่าเริ่มต้นของข้อมูล
    _data = widget.data;
  }

  @override
  Widget build(BuildContext context) {
    print(_data);
    return Scaffold(
      extendBodyBehindAppBar:true,
      appBar: AppBar(
        backgroundColor:Colors.transparent,
      ),
      bottomNavigationBar: Promostion_Bottombar(data: _data),
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            color: Color(0xFFEEEEEE),
            child: Column(
              children: [
                Promostion_Image(data: _data),
                Container(
                  color: Colors.black,
                  height: 10,
                ),
                Promostion_Map(),
                Container(
                  color: Colors.black,
                  height: 10,
                ),
                Main_Promostion(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
