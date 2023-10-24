import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:medic_admin/model/prescription_model.dart';
import 'package:medic_admin/utils/utils.dart';

class PrescriptionController extends GetxController {
  final CollectionReference presRef =
      FirebaseFirestore.instance.collection('prescriptions');

  //import 'package:cloud_firestore/cloud_firestore.dart';
  //
  // Stream<List<PrescriptionData>> streamAllPrescriptions() {
  //   // Reference to the prescription collection
  //   CollectionReference prescriptionRef = FirebaseFirestore.instance.collection('prescription');
  //
  //   // Return a stream of List<PrescriptionData>
  //   return prescriptionRef.snapshots().map((snapshot) {
  //     List<PrescriptionData> prescriptionsList = [];
  //     for (QueryDocumentSnapshot userDoc in snapshot.docs) {
  //       if (userDoc.data().containsKey('prescriptions')) { // Check if the 'prescriptions' key exists
  //         List<Map<String, dynamic>> prescriptionsMapList = List<Map<String, dynamic>>.from(userDoc['prescriptions']);
  //         prescriptionsList.addAll(prescriptionsMapList.map((prescriptionMap) => PrescriptionData.fromMap(prescriptionMap)).toList());
  //       }
  //     }
  //     return prescriptionsList;
  //   });
  // }

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
      print('Fetched ${prescriptionList.length} prescriptions.');
      return prescriptionList;
    });
  }

  //Future<void> updateIsApproved(String userId, String prescriptionId, bool newStatus) async {
  //   try {
  //     // Fetch the user's prescriptions
  //     DocumentSnapshot userSnapshot = await prescriptionsRef.doc(userId).get();
  //
  //     if (userSnapshot.exists) {
  //       List<Map<String, dynamic>> prescriptionsList = List<Map<String, dynamic>>.from(userSnapshot.data()?['prescriptions'] ?? []);
  //
  //       // Locate the specific prescription using the prescriptionId
  //       for (var i = 0; i < prescriptionsList.length; i++) {
  //         if (prescriptionsList[i]['id'] == prescriptionId) {
  //           prescriptionsList[i]['isApproved'] = newStatus;
  //           break;
  //         }
  //       }
  //
  //       // Update the prescriptions array for the user
  //       await prescriptionsRef.doc(userId).update({'prescriptions': prescriptionsList});
  //     } else {
  //       print("User document doesn't exist.");
  //     }
  //   } catch (e) {
  //     print("Error updating isApproved: $e");
  //   }
  // }

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
