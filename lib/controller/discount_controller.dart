import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:medic_admin/model/discount_data_model.dart';
import 'package:medic_admin/utils/utils.dart';

class DiscountController extends GetxController {
  TextEditingController disNameController = TextEditingController();
  TextEditingController disTypeController = TextEditingController();
  TextEditingController disPriceController = TextEditingController();
  TextEditingController disPerController = TextEditingController();
  TextEditingController disCodeController = TextEditingController();

  final CollectionReference discountRef =
      FirebaseFirestore.instance.collection("discounts");

  RxString discountType = "".obs;

  List<String> disTypeList = ["Activate","Deactivate","Deleted"];

  bool validateData() {
    if (disNameController.text.isEmpty) {
      showInSnackBar("Please enter discount name.",
          title: 'Required!', isSuccess: false);
      return false;
    } else if (discountType.isEmpty) {
      showInSnackBar("Please enter discount type.",
          title: 'Required!', isSuccess: false);
      return false;
    } else if (disPriceController.text.isEmpty) {
      showInSnackBar("Please enter discount price.",
          title: 'Required!', isSuccess: false);
      return false;
    } else if (disPerController.text.isEmpty) {
      showInSnackBar("Please enter discount percentage.",
          title: 'Required!', isSuccess: false);
      return false;
    } else if (disCodeController.text.isEmpty) {
      showInSnackBar("Please enter discount code.",
          title: 'Required!', isSuccess: false);
      return false;
    }
    return true;
  }

  addDiscountData(DiscountDataModel discountDataModel) async {
    try {
      await discountRef
          .doc(discountDataModel.id)
          .set(discountDataModel.toMap());
      Get.back();
      Get.back();
      clearController();
      showInSnackBar("Discount Data Added Successfully",
          isSuccess: true, title: "The Medic");
    } catch (e) {
      print("Error : $e");
    }
  }

  editDiscountData(DiscountDataModel discountDataModel) async {
    try {
      await discountRef
          .doc(discountDataModel.id)
          .update(discountDataModel.toMap());
      Get.back();
      Get.back();
      clearController();
      showInSnackBar("Discount Data Edited Successfully",
          isSuccess: true, title: "The Medic");
    } catch (e) {
      print("Error : $e");
    }
  }

  Stream<List<DiscountDataModel>> fetchDiscountData() {
    var data = discountRef.snapshots().map((event) {
      return event.docs.map((e) {
        return DiscountDataModel.fromMap(e.data() as Map<String, dynamic>);
      }).toList();
    });
    return data;
  }

  clearController() {
    disCodeController.clear();
    disPriceController.clear();
    disPerController.clear();
    disTypeController.clear();
    disNameController.clear();
    discountType = "".obs;
  }
}
