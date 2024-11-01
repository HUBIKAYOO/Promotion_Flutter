import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:url_launcher/url_launcher.dart';

class Main_Advert extends StatefulWidget {
  const Main_Advert({super.key});

  @override
  State<Main_Advert> createState() => _Main_AdvertState();
}

class _Main_AdvertState extends State<Main_Advert> {
  int _currentPage = 0;

  final List<String> _adUrls = [
    'https://www.bigc.co.th/shop/lays?srsltid=AfmBOoqMRrISBVS6ox3j8N2ShI3NtInoiynDdPEmlV--NtDHnPhCXwq-', // URL สำหรับภาพที่ 1
    'https://www.nestlepurelife.com/th/th-th', // URL สำหรับภาพที่ 2
    'https://adaddictth.com/news/Veta-Active-14', // URL สำหรับภาพที่ 3
    'https://www.apple.com', // URL สำหรับภาพที่ 4
    'https://www.purefoodsshopping.com', // URL สำหรับภาพที่ 5
    'https://www.bigc.co.th/shop/lays?srsltid=AfmBOoqMRrISBVS6ox3j8N2ShI3NtInoiynDdPEmlV--NtDHnPhCXwq-', // URL สำหรับภาพที่ 6
  ];

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url); // แปลงเป็น Uri
    await launchUrl(uri); // ใช้ launchUrl
    
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Stack(
        children: [
          CarouselSlider(
            options: CarouselOptions(
              height: 150,
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 5),
              viewportFraction: 1.0,
              enlargeCenterPage: false,
              onPageChanged: (index, reason) {
                setState(() {
                  _currentPage = index;
                });
              },
            ),
            items: List.generate(6, (index) {
              return Padding(
                padding: const EdgeInsets.all(10),
                child: GestureDetector(
                  onTap: () {
                    _launchURL(_adUrls[index]);
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15.0),
                    child: Image.asset(
                      "images/client/Advert/$index.jpg",
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                  ),
                ),
              );
            }),
          ),
          Positioned(
            bottom: 15,
            left: 0,
            right: 0,
            child: Center(
              child: AnimatedSmoothIndicator(
                activeIndex: _currentPage,
                count: 6,
                effect: WormEffect(
                  activeDotColor: Colors.white,
                  dotColor: Colors.white.withOpacity(0.5),
                  dotHeight: 8,
                  dotWidth: 8,
                  spacing: 16,
                ),
                onDotClicked: (index) {
                  // คุณสามารถเพิ่มฟังก์ชันในการเปลี่ยนหน้าได้ที่นี่
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
