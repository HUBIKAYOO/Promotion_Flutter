import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:upro/IP.dart';

class Personal extends StatefulWidget {
  final String? email;
  final String? name;
  final String? phoneNumber;

  Personal({this.email, this.name, this.phoneNumber});

  @override
  _PersonalState createState() => _PersonalState();
}

class _PersonalState extends State<Personal> {
  final TextEditingController EmailController = TextEditingController();
  final TextEditingController NameUserController = TextEditingController();
  final TextEditingController NameController = TextEditingController();
  final TextEditingController PhonNumberController = TextEditingController();
  final TextEditingController AddressController = TextEditingController();

  @override
  void initState() {
    super.initState();

    // กำหนดค่าจาก widget ไปยัง controller
    EmailController.text = widget.email ?? '';
    NameController.text = widget.name ?? '';
    PhonNumberController.text = widget.phoneNumber ?? '';
  }

  @override
  Widget build(BuildContext context) {
    print(
        'Email : ${widget.email} , name : ${widget.name} ,number phone : ${widget.phoneNumber}');
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(30),
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
                    Text("อีเมล"),
                    SizedBox(height: 5),
                    TextField(
                      controller: EmailController,
                      readOnly: widget.email != '',
                      decoration: InputDecoration(
                        hintText: "อีเมล",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(7),
                        ),
                        filled: true,
                        fillColor: widget.email != null
                            ? Colors.grey[200]
                            : Colors.white,
                      ),
                    ),
                    SizedBox(height: 20),
                    Text("ชื่อผู้ใช้"),
                    SizedBox(height: 5),
                    TextField(
                      controller: NameUserController,
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
                    Text("เบอร์มือถือ"),
                    SizedBox(height: 5),
                    TextField(
                      controller: PhonNumberController,
                      readOnly: widget.phoneNumber !=
                          '', // ให้แก้ไขไม่ได้ถ้ามีค่า phoneNumber
                      decoration: InputDecoration(
                        hintText: "เบอร์มือถือ",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(7)),
                        filled: true,
                        fillColor: widget.phoneNumber != ''
                            ? Colors.grey[200]
                            : Colors.white,
                      ),
                    ),
                    SizedBox(height: 20),
                    Text("ที่อยู่"),
                    SizedBox(height: 5),
                    TextField(
                      maxLines: 2,
                      minLines: 1,
                      controller: AddressController,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(7)),
                          hintText: "ที่อยู่"),
                    ),
                    SizedBox(height: 30),
                    InkWell(
                      onTap: () {
                        _insert();
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

  void _insert() async {
    String url = "http://$IP/users_register";
    Map<String, dynamic> data = {
      'referred_by': '',
      'username': NameUserController.text,
      'email': EmailController.text,
      'password': '',
      'full_name': NameController.text,
      'address': AddressController.text,
      'phone_number': PhonNumberController.text,
      'user_type': '2',
    };

    final response = await http.post(Uri.parse(url), body: data);

    if (response.statusCode == 201) {
      print(response.body);
      Navigator.popAndPushNamed(
          context, '/permissions'); // แทนที่ด้วยชื่อเส้นทางของคุณ
    } else {
      // Handle error here
      print('Failed to register user');
    }
  }
}
