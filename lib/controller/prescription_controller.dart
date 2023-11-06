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
  RxList selectMedicineIdList = [].obs;

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

  Stream<List<PrescriptionData>> fetchPrescriptionsWithDetails() {
    return fetchPrescription().asyncMap((prescriptionList) async {
      final Map<String, String> medicineNamesCache = {};
      final Map<String, String> userNamesCache = {};

      Future<String> getMedicineNameFromId(String id) async {
        if (medicineNamesCache.containsKey(id)) {
          return medicineNamesCache[id]!;
        }

        var doc = await FirebaseFirestore.instance
            .collection('medicines')
            .doc(id)
            .get();
        var name = doc.data()?['genericName'] ?? 'Unknown Medicine';
        medicineNamesCache[id] = name;
        return name;
      }

      Future<String> getUserNameFromId(String id) async {
        if (userNamesCache.containsKey(id)) {
          return userNamesCache[id]!;
        }

        var userDoc =
            await FirebaseFirestore.instance.collection('users').doc(id).get();
        var username = userDoc.data()?['name'] ?? 'Unknown User';
        userNamesCache[id] = username;
        return username;
      }

      for (var prescription in prescriptionList) {
        if (prescription.medicineList != null) {
          for (var i = 0; i < prescription.medicineList!.length; i++) {
            String medicineName =
                await getMedicineNameFromId(prescription.medicineList![i]);
            prescription.medicineList![i] = medicineName;
          }
        }
        if (prescription.userId != null && prescription.userId!.isNotEmpty) {
          String username = await getUserNameFromId(prescription.userId!);
          prescription.userId = "${prescription.userId}+$username";
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
    DocumentReference prescriptionRef = presRef.doc(documentId);

    prescriptionRef.get().then((DocumentSnapshot snapshot) {
      if (!snapshot.exists) {
        selectMedicineList = [].obs;
        selectMedicineIdList = [].obs;
        selectedMedicine = "".obs;
        throw Exception("Prescription Document does not exist!");
      }

      List<dynamic> prescriptionList = snapshot.get('prescriptions') ?? [];

      if (itemIndex < 0 || itemIndex >= prescriptionList.length) {
        selectMedicineList = [].obs;
        selectMedicineIdList = [].obs;
        selectedMedicine = "".obs;
        throw Exception(
            "Prescription Item does not exist at index $itemIndex!");
      }

      Map<String, dynamic> prescriptionItem = prescriptionList[itemIndex];

      prescriptionItem['medicineList'] = medicineList;

      prescriptionList[itemIndex] = prescriptionItem;

      return prescriptionRef.update({'prescriptions': prescriptionList});
    }).then((_) {
      Get.back();
      Get.back();
      showInSnackBar("Medicine list added successfully.", isSuccess: true);
      selectMedicineList = [].obs;
      selectMedicineIdList = [].obs;
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
