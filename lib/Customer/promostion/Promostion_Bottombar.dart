import 'package:flutter/material.dart';
import 'package:upro/Customer/promostion/promostion_choose_popup.dart';

class Promostion_Bottombar extends StatefulWidget {
  final dynamic data;
  Promostion_Bottombar({required this.data});

  @override
  _Promostion_BottombarState createState() => _Promostion_BottombarState();
}

class _Promostion_BottombarState extends State<Promostion_Bottombar> {
  late Map<String, dynamic> _data;
  @override
  void initState() {
    super.initState();
    _data = widget.data;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: GestureDetector(
              onTap: () {},
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center ,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.network(
                        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRZ_BkcnEISMFuEl5_l9h9vHPR0BRoMGDsi9w&s",
                        width: 30,
                        height: 30,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(height: 3,),
                    Text(
                      "ร้าน",
                      style: TextStyle(fontSize: 10, color: Color(0xFF535353)),
                    )
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 10, top: 10),
            child: VerticalDivider(color: Colors.grey),
          ),
          Expanded(
            flex: 1,
            child: InkWell(
              onTap: () {},
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.add_shopping_cart_outlined,
                      color: Colors.orange,size: 30,
                    ),
                    
                    Text(
                      "เก็บในตะกร้า",
                      style: TextStyle(fontSize: 10, color: Color(0xFF535353)),
                    )
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: InkWell(
              onTap: () {
                // แสดง popup จากด้านล่าง
                showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return Promostion_Choose_Popup(data: _data);
                  },
                );
              },
              child: Container(
                height: double.infinity,
                color: Colors.orange,
                child: Center(
                  child: Text(
                    'ซื้อเลย',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
