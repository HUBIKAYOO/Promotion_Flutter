import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController numberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.symmetric(
              horizontal: 30,
              vertical:
                  50), // กำหนด padding ที่เพิ่มเติมเพื่อให้เนื้อหาอยู่กึ่งกลางจอ
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 50),
                width: 100,
                height: 100,
                child: ClipRRect(
                  borderRadius:
                      BorderRadius.circular(50), // กำหนดขอบเขตของวงกลม
                  child: Image.asset('images/login/U.png'),
                ),
              ),
              SizedBox(height: 20),
              Text("ลงทะเบียนหรือเข้าสู่ระบบด้วยเบอร์โทรศัพท์"),
              SizedBox(height: 10),
              TextField(
                controller: numberController,
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: "กรอกเบอร์โทรศัพท์ของคุณ",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(7),
                  ),
                ),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  _insert();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  fixedSize: Size(450, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7),
                  ),
                ),
                child: Text(
                  "ขอรับ OTP",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
              SizedBox(height: 30),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 1,
                      color: Colors.grey,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      "หรือเข้าสู่ระบบด้วย",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: 1,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              InkWell(
                onTap: () {},
                borderRadius: BorderRadius.circular(7),
                child: Container(
                  padding:
                      EdgeInsets.only(left: 40), // เพื่อให้ขนาดสูงขึ้นเล็กน้อย

                  width: 300,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.transparent, // ไม่มีสีพื้นหลัง
                    borderRadius: BorderRadius.circular(7),
                    border: Border.all(color: Colors.grey),
                  ),
                  child: Row(
                    // จัดตำแหน่งให้อยู่ตรงกลาง
                    children: [
                      Image.asset(
                        'images/login/Google.png',
                        width: 24,
                        height: 24,
                      ),
                      SizedBox(width: 20),
                      Text(
                        "ดำเนินการต่อด้วย Google",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10),
              InkWell(
                onTap: () {},
                borderRadius: BorderRadius.circular(7),
                child: Container(
                  padding:
                      EdgeInsets.only(left: 40), // เพื่อให้ขนาดสูงขึ้นเล็กน้อย

                  width: 300,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.transparent, // ไม่มีสีพื้นหลัง
                    borderRadius: BorderRadius.circular(7),
                    border: Border.all(color: Colors.grey),
                  ),
                  child: Row(
                    children: [
                      Image.asset(
                        'images/login/Facebook.png',
                        width: 24,
                        height: 24,
                      ),
                      SizedBox(width: 20),
                      Text(
                        "ดำเนินการต่อด้วย Facebook",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10),
              InkWell(
                onTap: () {},
                borderRadius: BorderRadius.circular(7),
                child: Container(
                  padding:
                      EdgeInsets.only(left: 40), // เพื่อให้ขนาดสูงขึ้นเล็กน้อย
                  width: 300,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.transparent, // ไม่มีสีพื้นหลัง
                    borderRadius: BorderRadius.circular(7),
                    border: Border.all(color: Colors.grey),
                  ),
                  child: Row(
                    // จัดตำแหน่งให้อยู่ตรงกลาง
                    children: [
                      Image.asset(
                        'images/login/Line.png',
                        width: 24,
                        height: 24,
                      ),
                      SizedBox(width: 20),
                      Text(
                        "ดำเนินการต่อด้วย Line",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _insert() async {
    String url = "http://5000/Upro1.0/server/routes/number.js";

    Map<String, String> data = {
      'name': numberController.text,
    };
    final response = await http.post(Uri.parse(url), body: data);
    print(response);
    if (response.statusCode == 200) {
      print('Data and image uploaded successfully');
      
    } else {
      print(
          'Failed to upload data and image. Status code: ${response.statusCode}');
    }
  }
}
