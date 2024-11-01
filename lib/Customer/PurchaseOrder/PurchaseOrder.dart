import 'package:flutter/material.dart';
import 'package:upro/Customer/PurchaseOrder/PurchaseOrder_List.dart';

class PurchaseOrder extends StatefulWidget {
  const PurchaseOrder({super.key});

  @override
  _PurchaseOrderState createState() => _PurchaseOrderState();
}

class _PurchaseOrderState extends State<PurchaseOrder>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this, initialIndex: 0);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void setTabIndex(int index) {
    _tabController.animateTo(index);
  }

  void onTabChange(int index) {
    setTabIndex(index); // เรียกใช้ setTabIndex เพื่อเปลี่ยนแท็บ
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEEEEEE),
      appBar: AppBar(
        title: Text('รายการซื้อของฉัน'),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(20.0), // เพิ่มความสูง
          // ปรับระยะห่างด้านบน
          child: TabBar(
            controller: _tabController,
            tabAlignment: TabAlignment.start,
            isScrollable: true,
            indicatorColor: Colors.orange,
            labelColor: Colors.orange,
            tabs: [
              Tab(text: 'รอชำระเงิน'),
              Tab(text: 'ชำระเเล้ว'),
              Tab(text: 'กำลังใช้สิทธ์'),
              Tab(text: 'สำเร็จ'),
              Tab(text: 'ยกเลิก'),
            ],
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          SingleChildScrollView(
            child: PurchaseOrder_List(
              POStatus: "1",
              onStatusUpdated: (status) =>
                  onTabChange(4), // ส่ง callback ไปยัง PurchaseOrder_List
            ),
          ),
          SingleChildScrollView(
            child: PurchaseOrder_List(
              POStatus: "3",
              onStatusUpdated: (status) => onTabChange(2),
            ),
          ),
          SingleChildScrollView(
            child: PurchaseOrder_List(
              POStatus: "4",
              onStatusUpdated: (status) => onTabChange(3),
            ),
          ),
          SingleChildScrollView(
            child: PurchaseOrder_List(
              POStatus: "5",
              onStatusUpdated: (status) => onTabChange(4),
            ),
          ),
          SingleChildScrollView(
            child: PurchaseOrder_List(
              POStatus: "2",
              onStatusUpdated: (status) => onTabChange(2),
            ),
          ),
        ],
      ),
    );
  }
}
