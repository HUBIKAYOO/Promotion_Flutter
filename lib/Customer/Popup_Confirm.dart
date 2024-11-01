import 'package:flutter/material.dart';

class Popup_Confirm extends StatelessWidget {
  final Function(bool) click;
  final String need;
  int choose;

  Popup_Confirm(
      {required this.click, required this.need, required this.choose});

  Map<int, List<String>> choices = {
    1: ["ใช่", "ไม่"],
    2: ["ยืนยัน", "ยกเลิก"],
    3: ["โทร", "ยกเลิก"]
  };

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.zero, // ปิด padding รอบ ๆ ของ AlertDialog
      content: Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(5)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.all(15),
              child: Text(need),
            ),
            Divider(
              color: Colors.grey,
              height: 1, // กำหนดความสูงของ Divider ให้ติดกันกับข้อความ
              thickness: 1, // ความหนาของ Divider
            ),
            IntrinsicHeight(
              // ใช้เพื่อให้ Row ขยายความสูงตามเนื้อหาข้างใน
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () => click(false),
                      child: Text(
                        choices[choose]![1],
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                    ),
                  ),
                  VerticalDivider(
                    width: 1, // กำหนดความกว้างของเส้น
                    color: Colors.grey, // สีของเส้น
                    thickness: 1, // ความหนาของเส้น
                  ),
                  Expanded(
                    child: TextButton(
                      onPressed: () => click(true),
                      child: Text(
                        choices[choose]![0],
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
      ),
    );
  }
}
