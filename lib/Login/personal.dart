import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:upro/Login/liking.dart'; // ใช้สำหรับการจัดรูปแบบวันที่

class Personal extends StatefulWidget {
  const Personal({super.key});

  @override
  State<Personal> createState() => _PersonalState();
}

class _PersonalState extends State<Personal> {
  TextEditingController NameController = TextEditingController();

  DateTime? _selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    DateTime initialDate = DateTime.now();
    if (_selectedDate != null) {
      initialDate = _selectedDate!;
    }

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  String? _selectedGender;
  void _showGenderPicker(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('เลือกเพศ'),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ), // ใช้เพื่อให้มุมของป๊อบอัพมน
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                title: Text('ชาย'),
                onTap: () {
                  setState(() {
                    _selectedGender = 'ชาย';
                  });
                  Navigator.pop(context); // ปิดป๊อบอัพ
                },
              ),
              ListTile(
                title: Text('หญิง'),
                onTap: () {
                  setState(() {
                    _selectedGender = 'หญิง';
                  });
                  Navigator.pop(context); // ปิดป๊อบอัพ
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(30),
          // color: Colors.blue,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "ข้อมูลส่วนตัว",
                style: TextStyle(fontSize: 30),
              ),
              Container(
                padding: EdgeInsets.only(left: 30, right: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20),
                    Text("ชื่อผู้ใช้"),
                    SizedBox(height: 5),
                    TextField(
                      controller: NameController,
                      decoration: InputDecoration(
                          hintText: "ชื่อผู้ใช้",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(7))),
                    ),
                    SizedBox(height: 20),
                    Text("ชื่อ-สกุล"),
                    SizedBox(height: 5),
                    TextField(
                      controller: NameController,
                      decoration: InputDecoration(
                          hintText: "ชื่อ-สกุล",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(7))),
                    ),
                    SizedBox(height: 20),
                    Text('วันเกิด'),
                    SizedBox(height: 5),
                    GestureDetector(
                      onTap: () => _selectDate(context),
                      child: AbsorbPointer(
                        child: TextFormField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(7)),
                            hintText: _selectedDate != null
                                ? DateFormat('dd/MM/yyyy')
                                    .format(_selectedDate!)
                                : 'เลือกวันเกิด',
                            suffixIcon: Icon(Icons.calendar_today),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Text("เพศ"),
                    SizedBox(height: 5),
                    GestureDetector(
                      onTap: () => _showGenderPicker(context),
                      child: AbsorbPointer(
                        child: TextFormField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(7)),
                            hintText: _selectedGender ?? 'เลือกเพศ',
                            suffixIcon: Icon(Icons.arrow_drop_down),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Text("อาชีพ"),
                    SizedBox(height: 5),
                    GestureDetector(
                      onTap: () => _showGenderPicker(context),
                      child: AbsorbPointer(
                        child: TextFormField(
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(7)),
                              hintText: _selectedGender ?? "เลือกอาชีพ",
                              suffixIcon: Icon(Icons.arrow_drop_down)),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Text("เงินเดือน"),
                    SizedBox(height: 5),
                    GestureDetector(
                      onTap: () => _showGenderPicker(context),
                      child: AbsorbPointer(
                        child: TextFormField(
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(7)),
                              hintText: _selectedGender ?? "เลือกเงินเดือน",
                              suffixIcon: Icon(Icons.arrow_drop_down)),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Text("ที่อยู่"),
                    SizedBox(height: 5),
                    TextField(
                      maxLines: 2,
                      minLines: 1,
                      controller: NameController,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(7)),
                          hintText: "ที่อยู่"),
                    ),
                    SizedBox(height: 30),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Liking(),
                          ),
                        );
                      },
                      child: Container(
                        width: 300,
                        height: 60,
                        decoration: BoxDecoration(
                            color: Colors.orange,
                            borderRadius: BorderRadius.circular(7)),
                        child: Center(
                          child: Text(
                            "ถัดไป",
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20)
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
