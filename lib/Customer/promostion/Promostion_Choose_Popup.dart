import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:upro/Customer/OrderList/OrderList.dart';
import 'package:upro/IP.dart';

class Promostion_Choose_Popup extends StatefulWidget {
  final Map<String, dynamic> data;
  Promostion_Choose_Popup({required this.data});

  @override
  _Promostion_Choose_PopupState createState() => _Promostion_Choose_PopupState();
}

class _Promostion_Choose_PopupState extends State<Promostion_Choose_Popup> {
  // รีทุกครั้งที่เข้ามา
  @override
  void initState() {
    super.initState();
    _fetchAttractions();
  }

  List<dynamic> _type = [];
  Set<int> _selectedIds = Set<int>(); // เก็บค่า menu_detail_id ที่ถูกเลือก

  Future<void> _fetchAttractions() async {
    try {
      final response = await http.get(Uri.parse(
          'http://$IP/menu_detail/${widget.data['product_type_id'].toString()}'));

      if (response.statusCode == 200) {
        setState(() {
          _type = json.decode(response.body);
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
    List<dynamic> images = [];
    try {
      images = json.decode(widget.data['images']);
    } catch (e) {
      print('Error parsing images: $e');
    }
print('aaaaaaaaaaaa${_selectedIds.toString()}');
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(5), topRight: Radius.circular(5))),
      width: double.infinity,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 100,
                  height: 100,
                  child: Image.network(
                    'http://$IP/productimages/${images[0]}',
                    fit: BoxFit.cover,
                  ),
                ),
                Column(
                  children: [
                    Text(
                      "฿${widget.data['cost_price']}",
                      style: TextStyle(color: Colors.red, fontSize: 25),
                    ),
                    Text(
                      "฿${widget.data['price']}",
                      style: TextStyle(
                          fontSize: 15, decoration: TextDecoration.lineThrough),
                    )
                  ],
                ),
                SizedBox(width: 100),
                Row(
                  children: [
                    Text("-"),
                    Text("1"),
                    Text("+"),
                  ],
                )
              ],
            ),
            ...(_type.isNotEmpty
                ? _type.map((typeItem) {
                    int menuDetailId = typeItem['menu_detail_id'];
                    bool isSelected = _selectedIds.contains(menuDetailId);
                    print('wwww$menuDetailId.toString()');

                    return Container(
                      color: Colors.blue,
                      margin: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Checkbox(
                            value: isSelected,
                            activeColor: Colors.orange, // สีของ Checkbox เมื่อถูกเลือก
                            onChanged: (bool? value) {
                              setState(() {
                                if (value == true) {
                                  _selectedIds.add(menuDetailId);
                                } else {
                                  _selectedIds.remove(menuDetailId);
                                }
                              });
                            },
                          ),
                          Text(
                            typeItem['menu_detail_name'],
                            style: TextStyle(fontSize: 16.0),
                          ),
                        ],
                      ),
                    );
                  }).toList()
                : []),
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => OrderList(data: widget.data,selectedIds:_selectedIds)));
              },
              child: Container(
                alignment: Alignment.center,
                width: double.infinity,
                height: 30,
                color: Colors.orange,
                child: Text("จอง"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
