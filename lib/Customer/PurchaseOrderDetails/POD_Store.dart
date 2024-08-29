import 'package:flutter/material.dart';
import 'package:upro/Customer/promostion/Promostion_Map.dart';

class POD_Store extends StatelessWidget {
  final  storeName;
   POD_Store({required this.storeName});

  @override
  Widget build(BuildContext context) {
    return Container(
      
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(10),
            color: Colors.blue,
            child: Text("กำลังทำอาหาร"),
          ),
          Container(
              padding: EdgeInsets.all(10),
              width: double.infinity,
              color: Colors.green,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [Text(storeName), 
                Promostion_Map()],
              ))
        ],
      ),
    );
  }
}
