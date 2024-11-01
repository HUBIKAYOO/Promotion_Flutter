import 'package:flutter/material.dart';
import 'package:upro/Customer/Bsket/Basket.dart';
import 'package:upro/Customer/main/main_advert.dart';
import 'package:upro/Customer/main/main_promotion.dart';
import 'package:upro/Customer/main/main_producttype.dart';

class Main extends StatefulWidget {
  const Main({super.key});

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: Icon(Icons.fit_screen_outlined),
          title: _buildtitile(),
          actions: [
            IconButton(
              icon: Icon(Icons.shopping_cart_outlined),
              onPressed: () => Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Basket())),
              padding: EdgeInsets.symmetric(horizontal: 8.0),
            ),
          ]),
      body: ListView(
        children: [
          Container(
            color: Color(0xFFEEEEEE),
            child: Column(
              children: [
                Main_Advert(),
                // Main_Producttype(),
                Main_Promostion(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

_buildtitile() => Container(
      width: double.infinity,
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.orange, width: 2)),
      child: Row(
        children: [
          Text(
            "คุณคิดอะไรอยู่",
            style: TextStyle(
              fontSize: 15,
              color: Colors.grey,
            ),
          ),
          Spacer(),
          Container(
            width: 50,
            height: 30,
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5), color: Colors.orange),
            child: Center(
              child: Text(
                "ค้นหา",
                style: TextStyle(
                    fontSize: 13,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ),
          )
        ],
      ),
    );
