import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medic_admin/model/order_data.dart';
import 'package:medic_admin/model/user_model.dart';
import 'package:medic_admin/shared_components/card_task.dart';
import 'package:medic_admin/shared_components/list_task_assigned.dart';
import 'package:medic_admin/shared_components/list_task_date.dart';
import 'package:medic_admin/shared_components/selection_button.dart';
import 'package:medic_admin/shared_components/task_progress.dart';

class DashboardController extends GetxController {
  final dataTask = const TaskProgressData(totalTask: 5, totalCompleted: 1);

  Rx<UserModel?> loggedInUser = UserModel.newUser().obs;

  String? get currentUserId => FirebaseAuth.instance.currentUser?.uid;

  RxInt selectedMenuIndex = 0.obs;

  final CollectionReference _usersCollection =
      FirebaseFirestore.instance.collection('users');
  final CollectionReference orderRef =
      FirebaseFirestore.instance.collection('orders');

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    _fetchUser();
    fetchUser();
  }

  Future<void> _fetchUser({
    void Function(UserModel? userModel)? onSuccess,
  }) async {
    try {
      streamUser(currentUserId!).listen((updatedUserData) {
        loggedInUser.value = updatedUserData;
        if (onSuccess != null) {
          onSuccess(updatedUserData);
        }
      });
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> fetchUser({
    void Function(UserModel userModel)? onSuccess,
  }) async {
    try {
      streamUser(currentUserId!).listen((updatedUserData) {
        loggedInUser.value = updatedUserData;
        if (onSuccess != null && updatedUserData != null) {
          onSuccess(updatedUserData);
        }
      });
    } catch (e) {
      log(e.toString());
    }
  }

  Stream<UserModel?> streamUser(String id) {
    return _usersCollection.doc(id).snapshots().map((documentSnapshot) {
      if (documentSnapshot.data() == null) {
        return null;
      }
      return UserModel.fromMap(
          documentSnapshot.data()! as Map<String, dynamic>);
    });
  }

  String getMobileNo() {
    if (loggedInUser.value?.mobileNo == null) {
      return '';
    }

    int? countryCode = loggedInUser.value?.countryCode;
    String? mobileNo = loggedInUser.value?.mobileNo ?? '';
    return '+${countryCode ?? ''} $mobileNo';
  }

  String get loggedUserName {
    return loggedInUser.value?.name ?? '';
  }

  Future<double> calculateTotalRevenue() async {
    double totalRevenue = 0.0;

    try {
      QuerySnapshot querySnapshot = await orderRef.get();

      for (var doc in querySnapshot.docs) {
        var data = doc.data();
        if (data is Map<String, dynamic>) {
          OrderData order = OrderData.fromMap(data);
          totalRevenue += order.totalAmount ?? 0.0;
        }
      }
    } catch (e) {
      print("Error fetching orders: $e");
    }

    return totalRevenue;
  }

  final taskInProgress = [
    CardTaskData(
      label: "New Order",
      jobDesk: "",
      dueDate: DateTime.now().add(const Duration(minutes: 50)),
    ),
    CardTaskData(
      label: "In Process Order",
      jobDesk: "",
      dueDate: DateTime.now().add(const Duration(hours: 4)),
    ),
    CardTaskData(
      label: "Completed Order",
      jobDesk: "",
      dueDate: DateTime.now().add(const Duration(days: 2)),
    ),
    CardTaskData(
      label: "All Order",
      jobDesk: "",
      dueDate: DateTime.now().add(const Duration(minutes: 50)),
    )
  ];

  void onPressedProfil() {}

  void onSelectedMainMenu(int index, SelectionButtonData value) {
    selectedMenuIndex.value = index;
    Get.back();
  }

  void onSelectedTaskMenu(int index, String label) {}

  void searchTask(String value) {}

  void onPressedTask(int index, ListTaskAssignedData data) {}

  void onPressedAssignTask(int index, ListTaskAssignedData data) {}

  void onPressedMemberTask(int index, ListTaskAssignedData data) {}

  void onPressedCalendar() {}

  void onPressedTaskGroup(int index, ListTaskDateData data) {}

  void openDrawer(GlobalKey<ScaffoldState> scaffoldKey) {
    if (scaffoldKey.currentState != null) {
      scaffoldKey.currentState!.openDrawer();
    }
  }
}
