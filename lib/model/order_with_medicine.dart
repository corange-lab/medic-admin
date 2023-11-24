import 'package:medic_admin/model/medicine_data.dart';
import 'package:medic_admin/model/order_data.dart';
import 'package:medic_admin/model/user_address.dart';

class OrderWithMedicines {
  OrderData orderData;
  List<MedicineData> medicines;
  UserAddress? address;

  OrderWithMedicines({
    required this.orderData,
    required this.medicines,
    this.address,
  });
}
