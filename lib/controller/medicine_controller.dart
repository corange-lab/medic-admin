import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:medic_admin/model/medicine.dart';
import 'package:medic_admin/utils/utils.dart';

class MedicineController extends GetxController {
  TextEditingController medicineController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  final CollectionReference medicineRef =
      FirebaseFirestore.instance.collection('medicines');

  bool validateData() {
    if (medicineController.text.trim().isEmpty) {
      showInSnackBar("Please enter first name.",
          title: 'Required!', isSuccess: false);
      return false;
    } else if (priceController.text.trim().isEmpty) {
      showInSnackBar("Please enter last name.",
          title: 'Required!', isSuccess: false);
      return false;
    }
    return true;
  }

  Stream<List<Medicine>> fetchMedicine() {
    var data = medicineRef.snapshots().map((event) {
      return event.docs.map((e) {
        return Medicine.fromMap(e.data() as Map<String, dynamic>);
      }).toList();
    });
    return data;
  }
}
