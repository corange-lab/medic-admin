import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:medic_admin/model/order_data.dart';
import 'package:medic_admin/model/user_address.dart';
import 'package:medic_admin/model/user_model.dart';

class OrderController extends GetxController {
  final String? currentUser = FirebaseAuth.instance.currentUser?.uid;

  RxString orderStatus = "Placed".obs;

  RxList<String> orderStatusList = [
    "Placed",
    "Confirm",
    "Shipped",
    "Completed",
    "Rejected",
    "Cancelled",
    "Refund",
    // "Inactive",
    "Return",
    // "Reorder"
  ].obs;

  final CollectionReference addRef =
      FirebaseFirestore.instance.collection('addresses');
  final CollectionReference orderRef =
      FirebaseFirestore.instance.collection('orders');
  final CollectionReference userRef =
      FirebaseFirestore.instance.collection('users');

  Stream<List<OrderData>> fetchOrders() {
    return orderRef
        .orderBy('orderDate', descending: true)
        .snapshots()
        .map((QuerySnapshot query) {
      List<OrderData> orders = [];
      for (var doc in query.docs) {
        orders.add(OrderData.fromMap(doc.data() as Map<String, dynamic>));
      }
      return orders;
    });
  }

  Future<List<String?>> fetchMedicineNameFromIds(
      List<String> medicineIds) async {
    List<String?> genericNames = [];
    for (String id in medicineIds) {
      var snapshot = await FirebaseFirestore.instance
          .collection('medicines')
          .doc(id)
          .get();
      if (snapshot.exists && snapshot.data()!.containsKey('genericName')) {
        genericNames.add(snapshot.data()?['genericName'] as String?);
      } else {
        genericNames.add(null);
      }
    }
    return genericNames;
  }

  List<int> getQuantitiesList(
      List<String> medicineIds, Map<String, int> medicineQuantities) {
    return medicineIds.map((id) => medicineQuantities[id] ?? 0).toList();
  }

  Stream<UserModel?> fetchUserById(String userid) {
    return userRef.doc(userid).snapshots().map((snapshot) {
      if (snapshot.exists && snapshot.data() != null) {
        return UserModel.fromMap(snapshot.data() as Map<String, dynamic>);
      } else {
        return null;
      }
    });
  }

  Stream<String> fetchUsernameFromId(String id) {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(id)
        .snapshots()
        .map((snapshot) {
      if (snapshot.exists && snapshot.data()!.containsKey('name')) {
        return snapshot.data()!['name'] as String;
      } else {
        return 'Unknown User';
      }
    });
  }

  Stream<UserAddress?>? fetchAddressById(String addressId, String userId) {
    try {
      return addRef.doc(userId).snapshots().map((snapshot) {
        if (snapshot.exists && snapshot.data() != null) {
          List<dynamic> addresses = snapshot.get('addresses');
          var addressMap =
              addresses.firstWhere((address) => address['id'] == addressId);
          if (addressMap != null) {
            return UserAddress.fromMap(addressMap);
          }
        }
        return null;
      });
    } catch (e) {
      print("Error: $e");
      return null;
    }
  }

  Future<void> updateOrderStatus(String orderId, String newStatus) async {
    await FirebaseFirestore.instance.collection('orders').doc(orderId).update({
      'orderStatus': newStatus,
    });
  }
}
