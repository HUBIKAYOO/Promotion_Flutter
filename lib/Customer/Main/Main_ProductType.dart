import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:upro/ip.dart';

class Main_Producttype extends StatefulWidget {
  const Main_Producttype({super.key});

  @override
  State<Main_Producttype> createState() => _Main_ProducttypeState();
}

class _Main_ProducttypeState extends State<Main_Producttype> {
  // เอาไว้เก็บข้อมูล api ที่ได้รับ
  List<dynamic> _productTypes = [];

  @override
  void initState() {
    super.initState();
    _fetchProductTypes();
  }

  // api
  Future<void> _fetchProductTypes() async {
    try {
      final response =
          await http.get(Uri.parse('http://$ip/producttypes'));

      if (response.statusCode == 200) {
        setState(() {
          _productTypes = json.decode(response.body);
        });
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    
    return Container(
      padding: EdgeInsets.only(  bottom: 10, left: 10),
      color: Colors.green,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "หมวดหมู่",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: _productTypes.map((productType) {
                return Container(
                  decoration: BoxDecoration(color: Colors.amber,borderRadius: BorderRadius.circular(8)),
                  padding: EdgeInsets.only(left: 10, top: 10, right: 10),
                  margin: EdgeInsets.only(right: 10,top: 10),
                  child: InkWell(
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.network(
                            "http://$ip/producttypeimages/${productType['product_type_image']}",
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(productType['product_type_name']),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
