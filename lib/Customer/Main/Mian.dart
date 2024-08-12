import 'package:flutter/material.dart';
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
    return ListView(
        children: [
          Container(
            color: Colors.amber,
            child: Column(
              children: [
                Main_Advert(),
                Main_Producttype(),
                Main_Promostion(),
                
              ],
            ),
          ),
        ],
      );
  }
}
