import 'package:flutter/material.dart';
import 'package:upro/Customer/Main/Mian.dart';

class Liking extends StatefulWidget {
  const Liking({super.key});

  @override
  State<Liking> createState() => _LikingState();
}

class _LikingState extends State<Liking> {
  List<bool> isSelected = List.generate(10, (index) => false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent,),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(left: 30,right: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "คุณชอบอะไร",
                style: TextStyle(fontSize: 30),
              ),
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.only(left: 20, right: 20, top: 20),
                child: Column(
                  children: List.generate(5, (index) {
                    return Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(2, (innerIndex) {
                          int currentIndex = index * 2 + innerIndex;
                          return Padding(
                            padding: EdgeInsets.all(5),
                            child: ClipRRect(
                              borderRadius:
                                  BorderRadius.circular(15), // มุมโค้ง
                              child: Container(
                                width: 145,
                                height: 90,
                                decoration: BoxDecoration(
                                  color: isSelected[currentIndex]
                                      ? Colors.orange.withOpacity(0.05)
                                      : Colors.blueGrey.withOpacity(0.05),
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(
                                    color: isSelected[currentIndex]
                                        ? Colors.orange
                                        : Colors.grey,
                                    width: 2,
                                  ),
                                ),
                                child: Material(
                                  color: Colors
                                      .transparent, // ทำให้พื้นหลังของ Material โปร่งใส
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        isSelected[currentIndex] =
                                            !isSelected[currentIndex];
                                      });
                                    },
                                    child: Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                            'images/login/U.png',
                                            width: 45,
                                          ),
                                          Text("อาหาร")
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                      ),
                    );
                  }),
                ),
              ),
              SizedBox(height: 30),
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.only(left: 20, right: 20),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Main(),
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
                        "เสร็จสิ้น",
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
