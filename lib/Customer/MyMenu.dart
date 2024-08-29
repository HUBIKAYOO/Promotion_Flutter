import 'package:flutter/material.dart';
import 'package:upro/Customer/Main/Mian.dart';
import 'package:upro/Customer/PurchaseOrder/PurchaseOrder.dart';
import 'package:upro/Customer/profile/profile.dart';

class MyMenu extends StatefulWidget {
  final String? user_id;
  final int? menu;

  MyMenu({this.user_id, this.menu});

  @override
  _MyMenuState createState() => _MyMenuState();
}

class _MyMenuState extends State<MyMenu> {
  late int _currentIndex;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();

    // ถ้า widget.menu มีค่า ให้ _currentIndex เป็นค่าใน widget.menu
    _currentIndex = widget.menu ?? 0;

    // กำหนด PageController พร้อมตำแหน่งเริ่มต้นเป็น _currentIndex
    _pageController = PageController(initialPage: _currentIndex);
  }

  final List<Widget> _widgetOptions = [
    Main(),
    PurchaseOrder(),
    Profile(),
  ];

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
            label: "หน้าหลัก",
            icon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            label: "ใบสั่งซื้อ",
            icon: Icon(Icons.subtitles),
          ),
          BottomNavigationBarItem(
            label: "โปรไฟล์",
            icon: Icon(Icons.person),
          ),
        ],
        currentIndex: _currentIndex,
        selectedFontSize: 14.0,
        unselectedFontSize: 14.0,
        selectedIconTheme: IconThemeData(size: 24.0),
        selectedItemColor: Colors.orange,
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
