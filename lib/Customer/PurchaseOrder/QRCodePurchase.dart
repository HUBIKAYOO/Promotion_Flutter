import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'dart:convert'; // นำเข้าเพื่อใช้ jsonEncode

void showQRCodePopup(BuildContext context,int id) {
  // เตรียมข้อมูลที่จะแปลงเป็น QR Code โดยใช้ JSON
  // Map<String, dynamic> qrData = {
  //   "referenceNumber1": 12345, // เลขอ้างอิง 1
  //   "referenceNumber2": 67890, // เลขอ้างอิง 2
  //   "price": 299.99,           // ราคา
  // };

  // // แปลงข้อมูลเป็น JSON String
  // String qrDataString = jsonEncode(qrData);

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        contentPadding: EdgeInsets.zero, // เพิ่ม padding รอบๆ dialog
        content: Container(
          decoration: BoxDecoration(
            color: Colors.white, 
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min, // ให้ Column ใช้ขนาดตามเนื้อหา
            children: [
              SizedBox(height: 10),
              Text(
                "แสดงให้ร้านเพื่อใช้สิทธิ์",
                style: TextStyle(fontSize: 15),
                textAlign: TextAlign.center,
              ),
              Container(
                width: 200, // กำหนดขนาดของ QR Code
                height: 200,
                child: QrImageView(
                  data: id.toString(), // ใช้ JSON String ในการสร้าง QR Code
                  version: QrVersions.auto,
                  size: 200,
                ),
              ),
              Row(mainAxisAlignment: MainAxisAlignment.center,
                children: [
                
                Text("หรือใช้เลข : "),
                Text(id.toString()),
              ],),
              SizedBox(height: 10,),
              Divider(
                color: Colors.grey,
                height: 1, // กำหนดความสูงของ Divider ให้ติดกันกับข้อความ
                thickness: 1, // ความหนาของ Divider
              ),
              InkWell(
                child: Container(
                  width: double.infinity,
                  height: 50,
                  alignment: Alignment.center, 
                  child: Text("ปิด")
                ),
                onTap: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        ),
      );
    },
  );
}
