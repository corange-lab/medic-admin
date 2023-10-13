import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:medic_admin/model/medicine_data.dart';
import 'package:medic_admin/utils/utils.dart';

class MedicineController extends GetxController {
  TextEditingController medicineController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController aboutController = TextEditingController();
  TextEditingController ratinsController = TextEditingController();
  TextEditingController brandController = TextEditingController();
  TextEditingController directionUseController = TextEditingController();
  TextEditingController drugInterController = TextEditingController();
  TextEditingController safetyInfoController = TextEditingController();
  TextEditingController usesController = TextEditingController();
  TextEditingController benefitsController = TextEditingController();

  final CollectionReference medicineRef =
      FirebaseFirestore.instance.collection('medicines');

  bool validateData() {
    if (medicineController.text.trim().isEmpty) {
      showInSnackBar("Please enter generic name.",
          title: 'Required!', isSuccess: false);
      return false;
    } else if (brandController.text.trim().isEmpty) {
      showInSnackBar("Please enter brand name.",
          title: 'Required!', isSuccess: false);
      return false;
    }else if (descriptionController.text.trim().isEmpty) {
      showInSnackBar("Please enter medicine description.",
          title: 'Required!', isSuccess: false);
      return false;
    }
    return true;
  }

  Stream<List<MedicineData>> fetchMedicine() {
    var data = medicineRef.snapshots().map((event) {
      return event.docs.map((e) {
        return MedicineData.fromMap(e.data() as Map<String, dynamic>);
      }).toList();
    });
    return data;
  }
}
