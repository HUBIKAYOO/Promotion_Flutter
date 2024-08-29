class OderStatus1 {
  // รายการข้อมูลที่เก็บอยู่
  List<dynamic> _oderStatus1 = [];

  // Getter เพื่อดึงข้อมูล
  List<dynamic> get oderStatus1 => _oderStatus1;

  // Setter เพื่ออัพเดทข้อมูล
  void setOderStatus1(List<dynamic> status) {
    _oderStatus1 = status;
  }

  // เพิ่มรายการในข้อมูล
  void addOderStatus(dynamic status) {
    _oderStatus1.add(status);
  }

  // ลบรายการจากข้อมูลตาม index
  void removeOderStatus(int index) {
    if (index >= 0 && index < _oderStatus1.length) {
      _oderStatus1.removeAt(index);
    }
  }

  // เคลียร์ข้อมูลทั้งหมด
  void clearOderStatus() {
    _oderStatus1.clear();
  }
}
