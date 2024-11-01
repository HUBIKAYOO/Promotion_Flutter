import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:dotted_border/dotted_border.dart'; // นำเข้าแพ็กเกจ dotted_border

class ImageUploadWidget extends StatefulWidget {
  final Function(File?) onImageSelected;

  ImageUploadWidget({required this.onImageSelected});

  @override
  _ImageUploadWidgetState createState() => _ImageUploadWidgetState();
}

class _ImageUploadWidgetState extends State<ImageUploadWidget> {
  File? _imageFile;

  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _pickImage,
      child: Container(
        width: 100,
        height: 250,
        child: _imageFile == null
            ? DottedBorder(
                color: Colors.orange  ,
                strokeWidth: 2,
                dashPattern: [20, 4], // ความยาวเส้นประและช่องว่าง
                borderType: BorderType.RRect, // ใช้ BorderType.RRect สำหรับขอบโค้ง
                radius: Radius.circular(10), // กำหนดความโค้งของขอบ
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.photo, // ใช้ไอคอน Gallery
                        size: 30,
                        color: Colors.orange,
                      ),
                      SizedBox(height: 8), // ช่องว่างระหว่างไอคอนกับข้อความ
                      Text(
                        "กดเพื่อเลือกภาพสลิป", // ข้อความด้านใต้
                        style: TextStyle(color: Colors.orange),
                      ),
                    ],
                  ),
                ),
              )
            : ClipRRect(
                borderRadius: BorderRadius.circular(10), // กำหนดความโค้งของขอบที่มีรูป
                child: Image.file(
                  _imageFile!,
                  fit: BoxFit.cover,
                  height: 300,
                  width: 100,
                ),
              ),
      ),
    );
  }

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _imageFile = File(image.path);
      });
      widget.onImageSelected(_imageFile); // เรียก callback function เพื่อส่งข้อมูลกลับ
    }
  }
}
