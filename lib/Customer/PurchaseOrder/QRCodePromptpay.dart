  import 'dart:io';
  import 'package:flutter/material.dart';
  import 'package:promptpay_qrcode_generate/promptpay_qrcode_generate.dart';
  import 'package:screenshot/screenshot.dart';
  import 'package:image_gallery_saver/image_gallery_saver.dart';
  import 'dart:typed_data';
  import 'package:permission_handler/permission_handler.dart';
  import 'package:upro/Customer/PurchaseOrder/ImageUploadDialog.dart';
  import 'package:http/http.dart' as http;
  import 'package:upro/IP.dart';

  class QRCodeDialog extends StatefulWidget {
    final double amount;
    final String puchaseoder_id;
    Function(String)? onStatusUpdated; // เพิ่มฟังก์ชัน callback

    QRCodeDialog(
        {required this.amount,
        required this.puchaseoder_id,
        this.onStatusUpdated});

    @override
    _QRCodeDialogState createState() => _QRCodeDialogState();
  }

  class _QRCodeDialogState extends State<QRCodeDialog> {
    ScreenshotController screenshotController = ScreenshotController();
    String phoneNumber = "0823016849"; // หมายเลข PromptPay
    File? _selectedImage;
    PageController _pageController = PageController(); // ควบคุมการเลื่อนหน้า
    int _currentPage = 0; // หน้าที่กำลังแสดง

    Future<void> _saveScreenshotToGallery(Uint8List image) async {
      if (await Permission.storage.request().isGranted) {
        final result = await ImageGallerySaver.saveImage(image);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('QR Code ถูกบันทึกลงในแกลเลอรี: $result')),
        );
        Navigator.of(context).pop();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('ไม่ได้รับอนุญาตให้เข้าถึงพื้นที่จัดเก็บ')),
        );
      }
    }

    Future<void> _uploadImage() async {
      if (_selectedImage == null) return;

      final uri = Uri.parse('http://$IP/upload-slip-v2'); // URL ของ API

      try {
        final request = http.MultipartRequest('POST', uri)
          ..fields['puchaseoder_id'] = widget.puchaseoder_id
          ..files.add(await http.MultipartFile.fromPath(
              'moneyslip_file', _selectedImage!.path));

        final response = await request.send();
        final responseBody = await response.stream.bytesToString();

        if (response.statusCode == 200) {
          print('File uploaded successfully');
          print('Response body: $responseBody');
          widget.onStatusUpdated!("พึ่งส่งสลิป");
        } else {
          print('Failed to upload file. Status code: ${response.statusCode}');
          print('Response body: $responseBody');
        }
      } catch (e) {
        print('Error uploading file: $e');
      }
    }

    @override
    Widget build(BuildContext context) {
      return AlertDialog(
        contentPadding: EdgeInsets.zero,
        content: Container(
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(15)),
          child: SizedBox(
            width: 300,
            height: 420,
            child: Column(
              children: [
                SizedBox(height: 10),
                // ตัวบ่งชี้สถานะ
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            _pageController.jumpToPage(0);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: _currentPage == 0
                                    ? Colors.transparent
                                    : Colors.orange,
                                width: 2,
                              ),
                              color: _currentPage == 0
                                  ? Colors.orange
                                  : Colors.transparent,
                            ),
                            child: CircleAvatar(
                              backgroundColor: _currentPage == 0
                                  ? Colors.orange
                                  : Colors.transparent,
                              child: Text(
                                "1",
                                style: TextStyle(
                                  color: _currentPage == 0
                                      ? Colors.white
                                      : Colors.orange,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Text(
                          "QRcode",
                          style: TextStyle(
                              fontSize: 11,
                              color: Colors.orange), // เปลี่ยนให้สีส้มตลอด
                        ),
                      ],
                    ),
                    // เส้นเชื่อมระหว่างวงกลม
                    if (_currentPage == 0) ...[
                      Container(
                        height: 2,
                        width: 40,
                        color: Colors.orange,
                        margin: EdgeInsets.only(bottom: 15),
                      ),
                    ] else ...[
                      Container(
                        height: 2,
                        width: 40,
                        color: Colors.grey,
                        margin: EdgeInsets.only(bottom: 15),
                      ),
                    ],
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () {
                            _pageController.jumpToPage(1);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: _currentPage == 1
                                    ? Colors.transparent
                                    : Colors.orange,
                                width: 2,
                              ),
                              color: _currentPage == 1
                                  ? Colors.orange
                                  : Colors.transparent,
                            ),
                            child: CircleAvatar(
                              backgroundColor: _currentPage == 1
                                  ? Colors.orange
                                  : Colors.transparent,
                              child: Text(
                                "2",
                                style: TextStyle(
                                  color: _currentPage == 1
                                      ? Colors.white
                                      : Colors.orange,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Text(
                          "ชำระเงิน",
                          style: TextStyle(
                              fontSize: 11,
                              color: Colors.orange), // เปลี่ยนให้สีส้มตลอด
                        ),
                      ],
                    ),
                  ],
                ),

                // PageView
                Expanded(
                  child: PageView(
                    controller: _pageController,
                    onPageChanged: (index) {
                      setState(() {
                        _currentPage = index;
                      });
                    },
                    children: [
                      // หน้าแรก (แสดง QR Code)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(height: 10),
                          Text("QR Code สำหรับการชำระเงิน"),
                          Padding(
                            padding: EdgeInsets.all(10),
                            child: Screenshot(
                              controller: screenshotController,
                              child: SizedBox(
                                width: 250,
                                height: 250,
                                child: QRCodeGenerate(
                                  promptPayId: phoneNumber,
                                  amount: widget.amount,
                                  width: 250,
                                  height: 250,
                                  isShowAccountDetail: false,
                                ),
                              ),
                            ),
                          ),
                          Divider(color: Colors.grey, height: 1, thickness: 1),
                          IntrinsicHeight(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: TextButton(
                                    onPressed: () => Navigator.of(context).pop(),
                                    child: Text(
                                      "ปิด",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    ),
                                  ),
                                ),
                                VerticalDivider(
                                  width: 1,
                                  color: Colors.grey,
                                  thickness: 1,
                                ),
                                Expanded(
                                  child: TextButton(
                                    onPressed: () async {
                                      screenshotController
                                          .capture()
                                          .then((Uint8List? image) {
                                        if (image != null) {
                                          _saveScreenshotToGallery(image);
                                        }
                                      }).catchError((onError) {
                                        print(onError);
                                      });
                                    },
                                    child: Text(
                                      "บันทึกรูป",
                                      style: TextStyle(
                                          color: Colors.orange,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      // หน้าที่สอง (อัปโหลดรูปภาพ)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(height: 10),
                          Text("อัปโหลดรูปสลิป"),
                          Container(
                            padding: EdgeInsets.all(10),
                            width: double.maxFinite,
                            child: ImageUploadWidget(
                              onImageSelected: (File? file) {
                                setState(() {
                                  _selectedImage = file;
                                });
                              },
                            ),
                          ),
                          Divider(color: Colors.grey, height: 1, thickness: 1),
                          IntrinsicHeight(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: TextButton(
                                    onPressed: () => Navigator.of(context).pop(),
                                    child: Text(
                                      "ยกเลิก",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    ),
                                  ),
                                ),
                                VerticalDivider(
                                  width: 1,
                                  color: Colors.grey,
                                  thickness: 1,
                                ),
                                Expanded(
                                  child: TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                      if (_selectedImage != null) {
                                        _uploadImage();
                                      }
                                    },
                                    child: Text(
                                      "ยืนยัน",
                                      style: TextStyle(
                                          color: Colors.orange,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
  }
