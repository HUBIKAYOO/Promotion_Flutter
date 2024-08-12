import 'package:flutter/material.dart';
import 'package:upro/Customer/Main/Mian.dart';
import 'package:upro/Customer/profile/profile.dart';

class MyMenu extends StatefulWidget {
  @override
  State<MyMenu> createState() => _MyMenuState();
}

class _MyMenuState extends State<MyMenu> {
  int _currentIndex = 0;

  final List<Widget> _widgetOptions = [
    Main(),
    Profile(),
  ];

  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (int newIndex) {
          setState(() {
            _currentIndex = newIndex;
          });
        },
        children: _widgetOptions,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            label: "Main",
            icon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            label: "Profile",
            icon: Icon(Icons.portable_wifi_off_outlined),
          ),
        ],
        currentIndex: _currentIndex,
        selectedFontSize: 14.0, // ขนาดของข้อความเมื่อเลือก
        unselectedFontSize: 14.0, // ขนาดของข้อความเมื่อไม่ได้เลือก
        selectedIconTheme: IconThemeData(size: 24.0), // ขนาดของไอคอนเมื่อเลือก
        onTap: (int newIndex) {
          setState(() {
            _currentIndex = newIndex;
            _pageController.animateToPage(
              newIndex,
              duration: Duration(milliseconds: 300),
              curve: Curves.ease,
            );
          });
        },
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
