import 'package:flutter/material.dart';
import 'package:upro/Customer/Main/Mian.dart';
import 'package:upro/Customer/N%E0%B9%8Cotification/Ntification.dart';
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
    Ntification(), // เพิ่มหน้าแจ้งเตือน
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
        type: BottomNavigationBarType.fixed, // ป้องกันการขยายตัวของไอคอน
        items: [
          BottomNavigationBarItem(
            label: "หน้าหลัก",
            icon: Icon(Icons.home_outlined), // ไอคอนเมื่อไม่ถูกเลือก
            activeIcon: Icon(Icons.home), // ไอคอนเมื่อถูกเลือก
          ),
          BottomNavigationBarItem(
            label: "ใบสั่งซื้อ",
            icon: Icon(Icons.subtitles_outlined),
            activeIcon: Icon(Icons.subtitles),
          ),
          BottomNavigationBarItem(
            label: "แจ้งเตือน",
            icon: Icon(Icons.notifications_none), // ไอคอนเมื่อไม่ถูกเลือก
            activeIcon: Icon(Icons.notifications), // ไอคอนเมื่อถูกเลือก
          ),
          BottomNavigationBarItem(
            label: "โปรไฟล์",
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
          ),
        ],
        currentIndex: _currentIndex,
        selectedFontSize: 14.0,
        unselectedFontSize: 14.0,
        selectedIconTheme: IconThemeData(size: 24.0),
        unselectedIconTheme: IconThemeData(size: 24.0),
        selectedItemColor: Colors.orange,
        unselectedItemColor: Color(0xFF5B5A5A), // กำหนดสีของไอคอนที่ไม่ถูกเลือก
        showUnselectedLabels: true, // แสดงป้ายข้อความของไอเท็มที่ไม่ถูกเลือก
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
