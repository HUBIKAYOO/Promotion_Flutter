// BasketNameStore.dart
import 'package:flutter/material.dart';

class Basket_NameStore extends StatelessWidget {
  final Map<String, dynamic> store;
  final Map<int, List<bool>> basketOrderBool;
  final Function(int, bool) onStoreCheckboxChanged;

  Basket_NameStore({
    required this.store,
    required this.basketOrderBool,
    required this.onStoreCheckboxChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20,
      color: Colors.transparent,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Transform.scale(
            scale: 1, // ปรับขนาดของ Checkbox
            child: CheckboxTheme(
              data: CheckboxThemeData(
                side: BorderSide(
                    color: Color(0xFFB7B7B7),
                    width: 2), // กำหนดสีและความหนาของขอบ
              ),
              child: Checkbox(
                value: basketOrderBool[store['storeId']]!.every((val) => val == true),
                activeColor: Colors.orange,
                onChanged: (bool? value) {
                  onStoreCheckboxChanged(store['storeId'], value ?? false);
                },
              ),
            ),
          ),
          Text(
            store['storeName'],
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
