import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:medic_admin/model/medicine_data.dart';
import 'package:medic_admin/model/prescription_model.dart';
import 'package:medic_admin/utils/utils.dart';

class PrescriptionController extends GetxController {
  final CollectionReference presRef =
      FirebaseFirestore.instance.collection('prescriptions');
  final CollectionReference mediRef =
      FirebaseFirestore.instance.collection('medicines');

  RxString selectedMedicine = "".obs;
  RxList selectMedicineList = [].obs;
  RxString selectMedicineId = "".obs;

  Stream<List<PrescriptionData>> fetchPrescription() {
    return presRef.snapshots().map((snapshot) {
      List<PrescriptionData> prescriptionList = [];
      for (QueryDocumentSnapshot userDoc in snapshot.docs) {
        final userData = userDoc.data() as Map<String, dynamic>?;
        if (userData != null && userData.containsKey('prescriptions')) {
          List<Map<String, dynamic>> prescriptionMapList =
              List<Map<String, dynamic>>.from(userData['prescriptions']);
          prescriptionList.addAll(prescriptionMapList
              .map((presMap) => PrescriptionData.fromMap(presMap))
              .toList());
        } else {
          print('No prescriptions field found in document ${userDoc.id}');
        }
      }
      return prescriptionList;
    });
  }

  Stream<List<MedicineData>> fetchMedicine() {
    return mediRef.snapshots().map((event) {
      return event.docs.map((e) {
        return MedicineData.fromMap(e.data() as Map<String, dynamic>);
      }).toList();
    });
  }


  Future<void> addMedicineToPrescriptionItem(
      String documentId, int itemIndex, List medicineList) async {
    DocumentReference prescriptionRef =
    presRef.doc(documentId);

    prescriptionRef.get().then((DocumentSnapshot snapshot) {
      if (!snapshot.exists) {
        throw Exception("Prescription Document does not exist!");
      }

      List<dynamic> prescriptionList = snapshot.get('prescriptions');

      if (itemIndex < 0 || itemIndex >= prescriptionList.length) {
        throw Exception("Prescription Item does not exist at index $itemIndex!");
      }

      Map<String, dynamic> prescriptionItem = prescriptionList[itemIndex];

      prescriptionItem['medicineList'] = medicineList;

      prescriptionList[itemIndex] = prescriptionItem;

      return prescriptionRef.update({'prescriptions': prescriptionList});
    }).then((_) {
      Get.back();
      Get.back();
      showInSnackBar("Medicine list added successfully.",isSuccess: true);
      selectMedicineList = [].obs;
      selectedMedicine = "".obs;
    }).catchError((error) {
      showInSnackBar("Error updating document: $error");
    });
  }


  Future<void> approvePrescription(
      String userId, String prescriptionId, bool status) async {
    try {
      DocumentSnapshot userData = await presRef.doc(userId).get();

      if (userData.exists) {
        List<Map<String, dynamic>> prescriptionList =
            List<Map<String, dynamic>>.from(
                (userData.data() as Map<String, dynamic>)['prescriptions'] ??
                    []);

        for (var i = 0; i < prescriptionList.length; i++) {
          if (prescriptionList[i]['id'] == prescriptionId) {
            prescriptionList[i]['isApproved'] = status;
            break;
          }
        }

        await presRef.doc(userId).update({'prescriptions': prescriptionList});

        if (status) {
          showInSnackBar("Prescription Approved Successfully",
              title: "Prescription", isSuccess: true);
        } else {
          showInSnackBar("Prescription Denied Successfully",
              title: "Prescription", isSuccess: false);
        }
      } else {
        print("User Document doesn't exist.");
      }
    } catch (e) {
      print("Error updating isApproved : $e");
    }
  }
}
