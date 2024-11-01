import 'package:flutter/material.dart';
import 'package:upro/Customer/Popup_Confirm.dart';
import 'package:upro/Customer/promostion/Promostion_Map.dart';
import 'package:url_launcher/url_launcher.dart';

class POD_Store extends StatelessWidget {
  String phone;
  String address;
  final storeName;
  POD_Store(
      {required this.storeName, required this.address, required this.phone});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: Colors.orange,
              width: double.infinity,
              padding: EdgeInsets.all(10),
              child: Text("ข้อมูลร้านค้า"),
            ),
            _location(storeName,address),
            Divider(color: Colors.grey),
            _NumberPhone(context, storeName, phone),
          ],
        ),
      ),
    );
  }
}

_location(String storeName,String address) => Container(
      padding: EdgeInsets.only(left: 10, right: 10, bottom: 5, top: 10),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            Icon(Icons.location_on),
            SizedBox(
              width: 5,
            ),
            Text(
              "ที่อยู่ร้านค้า",
              style: TextStyle(fontSize: 15),
            ),
          ]),
          Padding(
              padding: EdgeInsets.only(left: 30, top: 10, right: 30, bottom: 5),
              child: Promostion_Map()),
          Padding(
              padding: EdgeInsets.only(left: 40,bottom: 5),
              child: Text('$storeName $address')),
        ],
      ),
    );

_NumberPhone(context, String storeName,String phone) => Container(
    padding: EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 5),
    child: Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.call),
            SizedBox(
              width: 5,
            ),
            Text(
              "เบอร์ติดต่อร้านค้า",
              style: TextStyle(fontSize: 15),
            )
          ],
        ),
        SizedBox(height: 5),
        Padding(
          padding: EdgeInsets.only(left: 40),
          child: Row(
            children: [
              InkWell(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return Popup_Confirm(
                            need: "ต้องการโทรไปยังร้าน$storeName",
                            choose: 3,
                            click: (value) async {
                              if (value == true) {
                                print("object");
                                final Uri phoneUri = Uri(
                                  scheme: 'tel',
                                  path: phone,
                                );

                                if (await canLaunchUrl(phoneUri)) {
                                  await launchUrl(phoneUri);
                                } else {
                                  throw 'Could not launch $phoneUri';
                                }
                              } else {
                                Navigator.of(context).pop();
                              }
                            });
                      });
                },
                child: Text(
                  phone,
                  style: TextStyle(color: Colors.orange),
                ),
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                "(คลิกเพื่อโทร)",
                style: TextStyle(color: Colors.grey),
              )
            ],
          ),
        )
      ],
    ));
