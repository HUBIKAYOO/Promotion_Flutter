import 'dart:convert';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:upro/IP.dart';

class Promostion_Image extends StatefulWidget {
  final dynamic data;

  Promostion_Image({required this.data});

  @override
  _Promostion_ImageState createState() => _Promostion_ImageState();
}

class _Promostion_ImageState extends State<Promostion_Image> {
  late Map<String, dynamic> _data;
  final CarouselController _carouselController = CarouselController();
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _data = widget.data;
  }

  @override
  Widget build(BuildContext context) {
    List<dynamic> images = [];
    try {
      images = json.decode(_data['images']);
    } catch (e) {
      print('Error parsing images: $e');
    }

    return Container(
      padding: EdgeInsets.only(bottom: 10),
      color: Colors.transparent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              CarouselSlider(
                carouselController: _carouselController,
                options: CarouselOptions(
                  height:  MediaQuery.of(context).size.width,
                  enlargeCenterPage: false, // ปิดการขยายภาพตอนอยู่กลางหน้า
                  enlargeStrategy: CenterPageEnlargeStrategy
                      .height, // ใช้ strategy นี้เพื่อให้รูปไม่เล็กลง
                  viewportFraction: 1.0,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                  autoPlay: false, // ปิดการเลื่อนอัตโนมัติ
                  enableInfiniteScroll: false, // ปิดการวนลูป
                ),
                items: images.map((image) {
                  return Image.network(
                    'http://$IP/productimages/$image',
                    width: double.infinity,
                    fit: BoxFit.fitWidth,
                  );
                }).toList(),
              ),
              Positioned(
                right: 10,
                bottom: 10,
                child: Container(
                  decoration: BoxDecoration(color: Colors.black54,borderRadius: BorderRadius.circular(15)),
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  child: Text(
                    '${_currentIndex + 1} / ${images.length}',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.only(left: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                '฿${_data['cost_price']}',
                style: TextStyle(fontSize: 30, color: Colors.orange),
              ),
              SizedBox(width: 20),
              Text(
                '฿${_data['price']}',
                style: TextStyle(
                    fontSize: 15,
                    decoration: TextDecoration.lineThrough,
                    decorationThickness: 2),
              ),
            ],
          ),
          Text(
            _data['name'],
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          Text(
            _data['product_type_name'],
            style: TextStyle(fontWeight: FontWeight.normal),
          ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
