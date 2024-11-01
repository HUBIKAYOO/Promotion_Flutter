  import 'dart:convert';

  import 'package:flutter/material.dart';
  import 'package:http/http.dart' as http;
  import 'package:provider/provider.dart';
  import 'package:upro/Customer/Bsket/Basket_Bottom.dart';
  import 'package:upro/Customer/Bsket/Basket_NameOder.dart';
  import 'package:upro/Customer/Bsket/Basket_NameStore.dart';
  import 'package:upro/Customer/Popup_Confirm.dart';
  import 'package:upro/IP.dart';
  import 'package:upro/SignIn/Login/UserID.dart';

  class Basket extends StatefulWidget {
    const Basket({super.key});

    @override
    State<Basket> createState() => _BasketState();
  }

  class _BasketState extends State<Basket> {
    List<dynamic> _Basket = [];
    Map<int, List<dynamic>> _BasketOderMap = {};
    Map<int, List<bool>> _BasketOderBool = {};
    bool _isLoading = true; // เพิ่มสถานะการโหลด

    // API
    // API
    Future<void> _fetchAttractions() async {
      try {
        final userId = Provider.of<UserIdProvider>(context, listen: false).userId;

        final response =
            await http.get(Uri.parse('http://$IP/unique-stores/$userId'));

        if (response.statusCode == 200) {
          setState(() {
            _Basket = json.decode(response.body);
          });
          for (var store in _Basket) {
            int storeId = store['storeId'];
            await _BasketOder(userId, storeId);
          }
          initializeBasketOderBool();
        } else {
          throw Exception('Failed to load data');
        }
      } catch (e) {
        print('Error fetching data: $e');
      } finally {
        setState(() {
          _isLoading = false; // เปลี่ยนสถานะการโหลดเมื่อเสร็จสิ้น
        });
      }
    }

    Future<void> _BasketOder(final userId, int storeId) async {
      try {
        final response =
            await http.get(Uri.parse('http://$IP/baskets/$userId/$storeId'));

        if (response.statusCode == 200) {
          final detaOder = json.decode(response.body);
          setState(() {
            if (_BasketOderMap.containsKey(storeId)) {
              _BasketOderMap[storeId]!.addAll(detaOder);
            } else {
              _BasketOderMap[storeId] = detaOder;
            }
          });
        } else {
          throw Exception('Failed to load data');
        }
      } catch (e) {
        print('Error fetching data: $e');
      }
    }

    void initializeBasketOderBool() {
      _BasketOderMap.forEach((storeId, orderList) {
        _BasketOderBool[storeId] = List<bool>.filled(orderList.length, false);
      });
    }

    // รีทุกครั้งที่เข้ามา
    @override
    void initState() {
      super.initState();
      _fetchAttractions();
    }

    @override
    Widget build(BuildContext context) {
      print("_BasketOderMap : $_BasketOderMap");
      int total = calculateTotalPrice();
      List<dynamic> selectedStores = _filterSelectedStores();
      Map<int, List<dynamic>> selectedOrders = _filterSelectedOrders();

      return Scaffold(
        appBar: AppBar(title: Text('รถเข็น')),
        bottomNavigationBar: Basket_Bottom(
          selectedOrders: selectedOrders,
          selectedStores: selectedStores,
          total: total,
          BasketOderBool: _BasketOderBool,
          onStoreCheckboxChanged: (Value) => All(Value),
        ),
        body: _isLoading
            ? Center(
                child: CircularProgressIndicator()) // แสดง Spinner ขณะกำลังโหลด
            : Container(
                padding: EdgeInsets.all(10),
                color: Color(0xFFEEEEEE),
                child: Column(
                  children: _Basket.map((stores) {
                    int storesrId = int.parse(stores['storeId'].toString());
                    List<dynamic> orderDetails = _BasketOderMap[storesrId] ?? [];
                    return Container(
                      margin: EdgeInsets.only(bottom: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.white),
                      width: double.infinity,
                      padding: EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Basket_NameStore(
                              store: stores,
                              basketOrderBool: _BasketOderBool,
                              onStoreCheckboxChanged: (storeId, value) =>
                                  updateBasketStore(storeId, value)),
                          Divider(color: Colors.grey),
                          ...orderDetails.asMap().entries.map((entry) {
                            int index = entry.key; // ตำแหน่งในลูป
                            var Oder = entry.value; // ข้อมูลในลูป

                            List<String> imageUrls = List<String>.from(
                                json.decode(Oder['images'] ?? '[]'));
                            return Basket_NameOder(
                              Oder: Oder,
                              imageUrls: imageUrls,
                              index: index,
                              basketOrderBool: _BasketOderBool,
                              onStoreCheckboxChanged: (value) =>
                                  updateBasketOder(Oder['storeId'], index, value),
                              HowMuch: (value) => HowMuch(
                                value,
                                Oder,
                                Oder['storeId'],
                                index,
                                Oder['basket_id'],
                              ),
                            );
                          }),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
      );
    }

    void updateBasketStore(int storeId, bool value) {
      setState(() {
        for (int i = 0; i < _BasketOderBool[storeId]!.length; i++) {
          _BasketOderBool[storeId]![i] = value;
        }
      });
    }

    void updateBasketOder(int storeId, int index, bool value) {
      setState(() {
        _BasketOderBool[storeId]![index] = value;
      });
    }

    void HowMuch(bool value, Map<String, dynamic> Oder, int storeId, int index,
        int basketId) async {
      if (value == false) {
        // _decrement(Oder, storeId, index,basketId);
        if (Oder['repeated'] > 1) {
          updateRepeated(Oder, basketId, -1);
        } else {
          _decrement(Oder, storeId, index, basketId);
        }
      } else {
        updateRepeated(Oder, basketId, 1);
      }
    }

    void updateRepeated(
        Map<String, dynamic> Oder, int basketId, int repeated) async {
      final response = await http.put(
        Uri.parse('http://$IP/update_basket_count/$basketId/$repeated'),
      );
      if (response.statusCode == 200) {
        setState(() {
          if (repeated == 1) {
            Oder['repeated']++;
          } else if (repeated == -1) {
            Oder['repeated']--;
          }
        });
      }
    }

    void _decrement(Oder, storeId, index, basketId) async {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return Popup_Confirm(
              need: "คุณเเน่ใจว่าต้องการลบหรือไม่",
              choose: 1,
              click: (value) async {
                if (value) {
                  final response = await http.delete(
                    Uri.parse('http://$IP/delete_basket/${Oder['basket_id']}'),
                  );

                  if (response.statusCode == 200) {
                    if (Oder['menu_data_id'] != 1) {
                      final deletemenu = await http.delete(Uri.parse(
                          'http://$IP/delete_menu_data/${Oder['menu_data_id']}'));
                      if (deletemenu.statusCode == 200) {
                        print("ลบMenuสำเร็จ");
                      }
                    }
                    setState(() {
                      // สร้าง List ใหม่จาก _BasketOderMap และ _BasketOderBool
                      List<dynamic> orders = List.from(_BasketOderMap[storeId]!);
                      orders.removeAt(index);
                      _BasketOderMap[storeId] = orders;

                      List<bool> orderBools =
                          List.from(_BasketOderBool[storeId]!);
                      orderBools.removeAt(index);
                      _BasketOderBool[storeId] = orderBools;

                      // ถ้าไม่มีรายการใน _BasketOderMap ให้ลบ storeId ออกจาก _Basket
                      if (_BasketOderMap[storeId]!.isEmpty) {
                        _Basket.removeWhere(
                            (store) => store['storeId'] == storeId);
                        _BasketOderMap.remove(storeId);
                        _BasketOderBool.remove(storeId);
                      }
                    });
                  } else {
                    print('Error deleting basket: ${response.body}');
                  }
                }
                Navigator.of(context).pop(); // ปิด popup
              });
        },
      );
    }

    int calculateTotalPrice() {
      int totalPrice = 0;

      _BasketOderMap.forEach((storeId, orders) {
        for (int i = 0; i < orders.length; i++) {
          if (_BasketOderBool[storeId]![i] == true) {
            // สมมติว่าแต่ละ 'orders' มี key 'price' ที่เป็นราคาของสินค้า
            int price = orders[i]['price'];
            int repeated = orders[i]['repeated'];
            totalPrice += price * repeated;
          }
        }
      });

      return totalPrice;
    }

    void All(bool value) {
      setState(() {
        if (value == true) {
          _BasketOderBool.forEach((storeId, orderList) {
            for (int i = 0; i < orderList.length; i++) {
              orderList[i] = true;
            }
          });
        } else {
          _BasketOderBool.forEach((storeId, orderList) {
            for (int i = 0; i < orderList.length; i++) {
              orderList[i] = false;
            }
          });
        }
      });
    }

    Map<int, List<dynamic>> _filterSelectedOrders() {
      Map<int, List<dynamic>> filteredOrders = {};

      _BasketOderMap.forEach((storeId, orders) {
        List<dynamic> selectedOrders = [];
        for (int i = 0; i < orders.length; i++) {
          if (_BasketOderBool[storeId]![i] == true) {
            selectedOrders.add(orders[i]);
          }
        }

        if (selectedOrders.isNotEmpty) {
          filteredOrders[storeId] = selectedOrders;
        }
      });

      return filteredOrders;
    }

    List<dynamic> _filterSelectedStores() {
      // สร้าง List ที่เก็บร้านค้าที่ถูกเลือกจาก _BasketOderBool
      List<dynamic> selectedStores = [];

      // ลูปร้านค้าทั้งหมด
      for (var store in _Basket) {
        int storeId = store['storeId'];

        // ตรวจสอบว่ามีการเลือกสินค้าในร้านนั้นๆ หรือไม่
        if (_BasketOderBool[storeId] != null &&
            _BasketOderBool[storeId]!.contains(true)) {
          selectedStores.add(store);
        }
      }

      return selectedStores;
    }
  }
