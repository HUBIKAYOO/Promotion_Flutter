import 'package:flutter/material.dart';
import 'package:upro/SignIn/personal/personal.dart';

class otp extends StatefulWidget {
  const otp({super.key});

  @override
  State<otp> createState() => _OtpState();
}

class _OtpState extends State<otp> {
  final List<TextEditingController> _controllers =
      List.generate(6, (index) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(6, (index) => FocusNode());

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var focusNode in _focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  void _nextField(String value, int index) {
    // Check if value is empty or not a number
    if (value.isEmpty || double.tryParse(value) == null) {
      // Move to the previous field if current field is empty
      if (index > 0) {
        _controllers[index].text = ''; // Clear current text
        FocusScope.of(context).requestFocus(_focusNodes[index - 1]);
      }
    } else {
      // Move to the next field if current field has a valid number
      if (index < 5) {
        _controllers[index].text = value; // Update current text
        FocusScope.of(context).requestFocus(_focusNodes[index + 1]);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(30),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("ป้อนรหัสยืนยัน OTP",
                    style: TextStyle(fontSize: 25, color: Colors.orange)),
                SizedBox(
                  height: 10,
                ),
                Text("ป้อนรหัส 6 หลักที่เราส่งไปยัง"),
                SizedBox(height: 5),
                Text("+66 *****5512"),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(6, (index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: Container(
                        width: 40,
                        height: 60,
                        child: TextField(
                          controller: _controllers[index],
                          focusNode: _focusNodes[index],
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(7),
                            ),
                            filled: true,
                            fillColor: Colors.white,
                          ),
                          style: TextStyle(fontSize: 24),
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            _nextField(value, index);
                          },
                          onSubmitted: (value) {
                            if (value.isEmpty && index > 0) {
                              FocusScope.of(context)
                                  .requestFocus(_focusNodes[index - 1]);
                            }
                          },
                        ),
                      ),
                    );
                  }),
                ),
                SizedBox(
                  height: 15,
                ),
                ElevatedButton(
                  onPressed: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => Personal(),
                    //   ),
                    // );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    fixedSize: Size(300, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7),
                    ),
                  ),
                  child: Text(
                    "ยืนยัน",
                    style: TextStyle(fontSize: 25, color: Colors.white),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => otp(),
                      ),
                    );
                  },
                  borderRadius: BorderRadius.circular(7),
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7),
                    ),
                    child: Text(
                      "ขอรับ OTP อีกครั้ง",
                      style: TextStyle(color: Colors.orange),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
