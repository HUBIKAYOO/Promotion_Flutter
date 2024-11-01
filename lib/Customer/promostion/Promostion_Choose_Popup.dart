import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:upro/Customer/OrderList/OrderList.dart';
import 'package:upro/IP.dart';
import 'package:upro/SignIn/Login/UserID.dart';

class Promostion_Choose_Popup extends StatefulWidget {
  final Map<String, dynamic> data;
  final String Type;
  Promostion_Choose_Popup({required this.data, required this.Type});

  @override
  _Promostion_Choose_PopupState createState() =>
      _Promostion_Choose_PopupState();
}

class _Promostion_Choose_PopupState extends State<Promostion_Choose_Popup> {
  @override
  void initState() {
    super.initState();
    _fetchAttractions();
  }

  int repeated = 1;
  List<dynamic> _type = [];
  String? _selectedMenuDetailName; // เก็บค่า menu_detail_name ที่ถูกเลือก

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
    // print('data : ${MenuDetailId}');
    List<dynamic> images = [];
    try {
      images = json.decode(widget.data['images']);
    } catch (e) {
      print('Error parsing images: $e');
    }
    print('Selected menu_detail_name: $_selectedMenuDetailName');

    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        mainAxisSize: MainAxisSize.min, // ขนาดของ Column จะปรับตามเนื้อหา
        children: [
          _buildImage(widget.data, images),
          Divider(color: Color(0xFFE8E8E8)),
          if (_type.isNotEmpty) _buildType(_type, _selectedMenuDetailName),
          _builQuantity(),
          SizedBox(height: 10),
          _builButton(widget.Type),
        ],
      ),
    );
  }

  Widget _buildImage(Map<String, dynamic> data, List<dynamic> images) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          width: 100,
          height: 100,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Image.network(
              'http://$IP/productimages/${images[0]}',
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "฿${data['price'] * repeated}",
              style: TextStyle(color: Colors.orange, fontSize: 25),
            ),
            Text(
              "฿${data['oprice']}",
              style: TextStyle(
                  fontSize: 15,decoration:
                                TextDecoration.lineThrough, // ขีดกลางข้อความ
                            decorationColor: Colors.grey,color: Colors.grey),
            ),
           
          ],
        ),
      ],
    );
  }

  Widget _buildType(List<dynamic> type, String? selectedMenuDetailName) {
  return Padding(
    padding: EdgeInsets.only(top: 10, bottom: 10),
    child: ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: 300, // กำหนดความสูงสูงสุดที่นี่
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ...type.map((typeItem) {
              String menuDetailName = typeItem['menu_detail_name'];
              bool isSelected = selectedMenuDetailName == menuDetailName;

              return Container(
                margin: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Radio<String>(
                      value: menuDetailName,
                      groupValue: selectedMenuDetailName,
                      activeColor: Colors.orange,
                      onChanged: (String? value) {
                        setState(() {
                          _selectedMenuDetailName = value;
                        });
                      },
                    ),
                    Text(
                      menuDetailName,
                      style: TextStyle(fontSize: 16.0),
                    ),
                  ],
                ),
              );
            }).toList(),
          ],
        ),
      ),
    ),
  );
}


  Widget _builQuantity() => Container(
        child: Row(
          children: [
            Text("จำนวน"),
            Spacer(),
            Container(
              height: 30,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: Color(0xFFEEEEEE), width: 2),
              ),
              child: Row(
                children: [
                  SizedBox(
                    width: 30,
                    child: IconButton(
                      icon: Icon(Icons.remove, size: 15),
                      onPressed: _decrement,
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    width: 30,
                    color: Color(0xFFEEEEEE),
                    child: Text(
                      repeated.toString(),
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                  SizedBox(
                    width: 30,
                    child: IconButton(
                      icon: Icon(Icons.add, size: 15),
                      onPressed: _increment,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      );

  void _increment() {
    setState(() {
      repeated++;
    });
  }

  void _decrement() {
    setState(() {
      if (repeated > 1) repeated--;
    });
  }

  Widget _builButton(String Type) => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.orange,
        ),
        alignment: Alignment.center,
        width: double.infinity,
        height: 50,
        child: InkWell(
          onTap: () {
            Map<String, dynamic> updatedData = Map.from(widget.data);
            updatedData['repeated'] = repeated;
            if (_selectedMenuDetailName == null) {
              updatedData['menu_detail_data'] = "ไม่มี";
              updatedData['menu_data_id'] = 1;
            } else {
              updatedData['menu_detail_data'] = _selectedMenuDetailName;
            }

            if (Type == 'ซื้อเลย') {
              if (_type.isEmpty || _selectedMenuDetailName != null) {
                print("repeated : ${updatedData['repeated']}");
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => OrderList(
                      store: [
                        {
                          'storeId': widget.data['storeId'],
                          'storeName': widget.data['storeName']
                        }
                      ],
                      data: {
                        widget.data['storeId']: [updatedData]
                      },
                      selectedMenuDetailName: _selectedMenuDetailName,
                    ),
                  ),
                );
              }
              ;
            } else {
              if (_type.isEmpty || _selectedMenuDetailName != null) {
                _InsertBasket(updatedData['menu_detail_data']);
              }
            }
          },
          child: Center(
            child: Text(
              Type,
              style: TextStyle(fontSize: 18),
            ),
          ),
        ),
      );

  void _InsertBasket(String MenuDetailNam) async {
    final userId = Provider.of<UserIdProvider>(context, listen: false).userId;
    int? MemuDataId;
    print("MenuDetailNam : $MenuDetailNam");

    String url =
        "http://$IP/check_menu_data/Basket"; // เรียกใช้ API เปรียบเทียบข้อมูล
    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'menu_detail_data': MenuDetailNam.toString(),
        'user_id': userId.toString(),
        'set_promotion_id': widget.data['set_promotion_id'].toString()
      }),
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> responseData = json.decode(response.body);
      MemuDataId = responseData['menuDataId'];
      print('MemuDataId: ${MemuDataId.toString()}');
    } else {
      if (MenuDetailNam != "ไม่มี") {
        String url = "http://$IP/menu_data_register";
        final insertMemuData = await http.post(Uri.parse(url),
            headers: {'Content-Type': 'application/json'},
            body: json.encode({'menu_detail_data': MenuDetailNam.toString()}));

        if (insertMemuData.statusCode == 201) {
          Map<String, dynamic> responseData = json.decode(insertMemuData.body);
          MemuDataId = responseData['menuDataId'];
        }
      } else {
        MemuDataId = 1;
      }
    }

    Map<String, dynamic> Basket = {
      'set_promotion_id': widget.data['set_promotion_id'].toString(),
      'user_id': userId.toString(),
      'storeId': widget.data['storeId'].toString(),
      'count': repeated.toString(),
      'menudatabasket_id': MemuDataId.toString(),
    };
    String url2 = "http://$IP/updateBasket";
    await http.post(Uri.parse(url2), body: Basket);

    Navigator.of(context).pop(); // ปิด popup โดยไม่ทำอะไร
  }
}
