import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Main_Advert extends StatefulWidget {
  const Main_Advert({super.key});

  @override
  State<Main_Advert> createState() => _Main_AdvertState();
}

class _Main_AdvertState extends State<Main_Advert> {
  final CarouselController _carouselController = CarouselController();
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Stack(
        children: [
          CarouselSlider(
            carouselController: _carouselController,
            options: CarouselOptions(
              
              height: 150, // กำหนดความสูงของ Carousel
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 5),
              viewportFraction: 1.0, // แสดงภาพเต็มหน้าจอ
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
                  onTap: () {},
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15.0),
                    child: Image.asset(
                      "images/client/Advert/$index.jpg",
                      fit: BoxFit.cover, width: double.infinity,
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
                  _carouselController.animateToPage(index);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
