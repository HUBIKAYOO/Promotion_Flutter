import 'package:flutter/material.dart';
import 'package:upro/IP.dart';

class Basket_NameOder extends StatelessWidget {
  final Map<String, dynamic> Oder;
  final List<String> imageUrls;
  final int index;
  final Map<int, List<bool>> basketOrderBool;
  final Function(bool) onStoreCheckboxChanged;
  final Function(bool) HowMuch;

  Basket_NameOder(
      {required this.Oder,
      required this.imageUrls,
      required this.index,
      required this.basketOrderBool,
      required this.onStoreCheckboxChanged,
      required this.HowMuch});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 10),
      color: Colors.transparent,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Transform.scale(
            scale: 1, // ปรับขนาดของ Checkbox
            child: CheckboxTheme(
              data: CheckboxThemeData(
                side: BorderSide(
                    color: Color(0xFFB7B7B7),
                    width: 2), // กำหนดสีและความหนาของขอบ
              ),
              child: Checkbox(
                value: basketOrderBool[Oder['storeId']]![index],
                activeColor: Colors.orange,
                onChanged: (bool? value) {
                  onStoreCheckboxChanged(value ?? false);
                },
              ),
            ),
          ),
          Container(
            height: 80,
            width: 80,
            color: Colors.transparent,
            child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Image.network(
                  'http://$IP/productimages/${imageUrls[0]}',
                  fit: BoxFit.cover,
                )),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Container(
              height: 80,
              color: Colors.transparent,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    Oder['name'],
                    style: TextStyle(fontSize: 18),
                  ),
                  Row(
                    children: [
                      Text(
                        Oder['menu_detail_data'] != "ไม่มี"
                            ? Oder['menu_detail_data']
                            : '',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("฿${Oder['price'] * Oder['repeated']}",
                            style: TextStyle(fontSize: 18,color: Colors.orange)),
                        Spacer(),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Color(0xFFEEEEEE))),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 30,
                                child: IconButton(
                                  icon: Icon(
                                    Icons.remove,
                                    size: 15,
                                  ),
                                  onPressed: () => HowMuch(false),
                                  // _decrement(Oder, Oder['storeId'], index),
                                ),
                              ),
                              Container(
                                alignment: Alignment.center,
                                width: 30,
                                color: Color(0xFFEEEEEE),
                                child: Text(
                                  Oder['repeated'].toString(),
                                  style: TextStyle(fontSize: 15),
                                ),
                              ),
                              SizedBox(
                                width: 30, // กำหนดความกว้างของขอบเขต
                                child: IconButton(
                                  icon: Icon(
                                    Icons.add,
                                    size: 15,
                                  ),
                                  onPressed: () => HowMuch(true),
                                  // _increment(Oder), // กดเพิ่มค่า
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
