import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:upro/Customer/Popup_Confirm.dart';
import 'package:upro/Customer/PurchaseOrder/ImageUploadDialog.dart';
import 'package:upro/Customer/PurchaseOrder/PurchaseOrderHelpers.dart';
import 'package:upro/Customer/PurchaseOrder/QRCodePromptpay.dart';
import 'package:upro/Customer/PurchaseOrder/QRCodePurchase.dart';
import 'package:upro/IP.dart';

class PurchaseOrder_List_Totol extends StatefulWidget {
  final int totalRepeated;
  final String puoderStatusId;
  final int puchaseoder_id;
  final double amount;
  Function(String)? onStatusUpdated; // เพิ่มฟังก์ชัน callback

  PurchaseOrder_List_Totol({
    required this.totalRepeated,
    required this.puoderStatusId,
    required this.puchaseoder_id,
    required this.amount,
    this.onStatusUpdated, // เพิ่มฟังก์ชันนี้
  });

  @override
  _PurchaseOrder_List_TotolState createState() =>
      _PurchaseOrder_List_TotolState();
}

class _PurchaseOrder_List_TotolState extends State<PurchaseOrder_List_Totol> {
  File? _selectedImage;
  String? _fetchedImage; // ตัวแปรเก็บรูปที่ดึงจาก API

  @override
  void initState() {
    super.initState();
    if (widget.puoderStatusId == "1") {
      _fetchMoneySlip(); // เรียก API เพื่อดึงข้อมูลมาทันทีเมื่อสถานะเป็น "1"
    }
  }

  @override
  Widget build(BuildContext context) {
    final decoration = getContainerDecoration(widget.puoderStatusId);
    final statusText = getStatusText(widget.puoderStatusId);

    return Container(
      color: Colors.transparent,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                "โปรรวม ${widget.totalRepeated} ",
                style: TextStyle(fontSize: 17),
              ),
              Text("รายการ ฿${widget.amount.toInt()}",
                  style: TextStyle(fontSize: 17)),
            ],
          ),
          SizedBox(height: 5),
          if (widget.puoderStatusId == "1") ...[
            _fetchedImage == null
                ? Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      _buildCencel(),
                      Spacer(),
                      SizedBox(width: 5),
                      _buildStatusId(decoration, statusText, context),
                    ],
                  )
                : Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [Spacer(), _buildInspecting()],
                  )
          ] else if (widget.puoderStatusId != "2") ...[
            Row(
              children: [
                Spacer(),
                SizedBox(width: 5),
                _buildStatusId(decoration, statusText, context),
              ],
            )
          ],
        ],
      ),
    );
  }

  // ฟังก์ชันดึงข้อมูล API
  Future<void> _fetchMoneySlip() async {
    try {
      final response = await http
          .get(Uri.parse('http://$IP/moneyslip/${widget.puchaseoder_id}'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          _fetchedImage = data['image']; // เก็บชื่อไฟล์รูปภาพจาก API
        });
      } else {
        print(
            'Failed to fetch money slip. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching money slip: $e');
    }
  }

  _buildInspecting() => Container(
        padding: EdgeInsets.only(left: 10, right: 10),
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Color(0xFFEEEEEE),
        ),
        alignment: Alignment.center,
        child: Text("กำลังตรวจสอบ",
            style: TextStyle(fontSize: 20, color: Color(0xFF4F4E4E))),
      );

  _buildCencel() => InkWell(
        onTap: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return Popup_Confirm(
                    need: "คุณเเน่ใจหรือไม่ต้องการยกเลิก",
                    choose: 2,
                    click: (value) {
                      if (value == true) {
                        _updatePurchaseOrderStatus("2");
                      } else {
                        Navigator.of(context).pop();
                      }
                    });
              });
        },
        child: Text(
          "ยกเลิก",
          style: TextStyle(fontSize: 20, color: Colors.grey),
        ),
      );

  // _buildPay(context) => InkWell(
  //       onTap: () => showDialog(
  //         context: context,
  //         builder: (BuildContext context) {
  //           return QRCodeDialog(
  //             amount: widget.amount,
  //             puchaseoder_id: widget.puchaseoder_id.toString(),
  //             onStatusUpdated: (Image) {
  //               setState(() {
  //                 _fetchedImage = Image;
  //               });
  //             },
  //           );
  //         },
  //       ),
  //       child: Container(
  //         alignment: Alignment.center,
  //         width: 100,
  //         height: 50,
  //         decoration: BoxDecoration(
  //           borderRadius: BorderRadius.circular(8),
  //           border: Border.all(color: Colors.black),
  //         ),
  //         child: Text(
  //           "ชำระเงิน",
  //           style: TextStyle(fontSize: 20, color: Colors.black),
  //         ),
  //       ),
  //     );

  _buildStatusId(decoration, statusText, context) => InkWell(
        onTap: () {
          if (widget.puoderStatusId == "1") {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return QRCodeDialog(
                    amount: widget.amount,
                    puchaseoder_id: widget.puchaseoder_id.toString(),
                    onStatusUpdated: (Image) {
                      setState(() {
                        _fetchedImage = Image;
                      });
                    });
              },
            );
          } else if (widget.puoderStatusId == "3") {
            showQRCodePopup(context, widget.puchaseoder_id);
          } else if (widget.puoderStatusId == "4") {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return Popup_Confirm(
                      need: "ยืนยันการเสร็จสิน",
                      choose: 2,
                      click: (value) {
                        if (value == true) {
                          _updatePurchaseOrderStatus("5");
                        } else {
                          Navigator.of(context).pop();
                        }
                      });
                });
          } else if (widget.puoderStatusId == "5") {}
        },
        child: Container(
          alignment: Alignment.center,
          child: statusText,
          decoration: decoration,
          width: 100,
          height: 50,
        ),
      );

  // void _showImageUploadDialog(BuildContext context) {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //           contentPadding: EdgeInsets.zero,
  //           content: Container(
  //             decoration: BoxDecoration(
  //                 color: Colors.white, borderRadius: BorderRadius.circular(15)),
  //             child: Column(
  //               crossAxisAlignment: CrossAxisAlignment.center,
  //               mainAxisSize: MainAxisSize.min,
  //               children: [
  //                 SizedBox(height: 10),
  //                 Text("อัปโหลดรูปภาพ"),
  //                 Container(
  //                   padding: EdgeInsets.all(10),
  //                   width: double.maxFinite,
  //                   child: ImageUploadWidget(
  //                     onImageSelected: (File? file) {
  //                       setState(() {
  //                         _selectedImage = file;
  //                       });
  //                     },
  //                   ),
  //                 ),
  //                 Divider(
  //                   color: Colors.grey,
  //                   height: 1, // กำหนดความสูงของ Divider ให้ติดกันกับข้อความ
  //                   thickness: 1, // ความหนาของ Divider
  //                 ),
  //                 IntrinsicHeight(
  //                   child: Row(
  //                     mainAxisAlignment: MainAxisAlignment.center,
  //                     children: [
  //                       Expanded(
  //                         child: TextButton(
  //                           onPressed: () => Navigator.of(context).pop(),
  //                           child: Text(
  //                             "ยกเลิก",
  //                             style: TextStyle(
  //                                 color: Colors.black,
  //                                 fontWeight: FontWeight.bold,
  //                                 fontSize: 16),
  //                           ),
  //                         ),
  //                       ),
  //                       VerticalDivider(
  //                         width: 1, // กำหนดความกว้างของเส้น
  //                         color: Colors.grey, // สีของเส้น
  //                         thickness: 1, // ความหนาของเส้น
  //                       ),
  //                       Expanded(
  //                         child: TextButton(
  //                           onPressed: () {
  //                             Navigator.of(context).pop();
  //                             // ส่งข้อมูลไปยังเซิร์ฟเวอร์
  //                             if (_selectedImage != null) {
  //                               _uploadImage(); // เรียกใช้ฟังก์ชันการอัปโหลด
  //                             }
  //                           },
  //                           child: Text(
  //                             "ยืนยัน",
  //                             style: TextStyle(
  //                                 color: Colors.orange,
  //                                 fontWeight: FontWeight.bold,
  //                                 fontSize: 16),
  //                           ),
  //                         ),
  //                       ),
  //                     ],
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ));
  //     },
  //   );
  // }

  // Future<void> _uploadImage() async {
  //   if (_selectedImage == null) return;

  //   final uri = Uri.parse('http://$IP/upload-slip-v2'); // ใช้ URL ใหม่ของ API

  //   try {
  //     final request = http.MultipartRequest('POST', uri)
  //       ..fields['puchaseoder_id'] = widget.puchaseoder_id.toString()
  //       ..files.add(await http.MultipartFile.fromPath(
  //           'moneyslip_file', _selectedImage!.path));

  //     final response = await request.send();
  //     final responseBody = await response.stream.bytesToString();

  //     if (response.statusCode == 200) {
  //       print('File uploaded successfully');
  //       print('Response body: $responseBody');
  //       setState(() {
  //         _fetchedImage = "พึ่งใส่สลิป";
  //       });
  //     } else {
  //       print('Failed to upload file. Status code: ${response.statusCode}');
  //       print('Response body: $responseBody');
  //     }
  //   } catch (e) {
  //     print('Error uploading file: $e');
  //   }
  // }

  Future<void> _updatePurchaseOrderStatus(String status) async {
    final uri = Uri.parse(
        'http://$IP/edit_puchaseoder/status/${widget.puchaseoder_id}');

    try {
      final response = await http.put(
        uri,
        headers: {"Content-Type": "application/json"},
        body: json
            .encode({"puoder_status_id": status}), // ค่า status ที่ต้องการส่งไป
      );

      if (response.statusCode == 200) {
        print('Purchase order updated successfully');
        if (widget.onStatusUpdated != null) {
          Navigator.of(context).pop();
          widget.onStatusUpdated!(
              status); // เรียกใช้ฟังก์ชัน callback เมื่อสถานะถูกอัปเดต
        }
      } else {
        print(
            'Failed to update purchase order. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error updating purchase order: $e');
    }
  }
}
