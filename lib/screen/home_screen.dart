// ignore_for_file: must_be_immutable

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:medic_admin/controller/auth_controller.dart';
import 'package:medic_admin/controller/home_controller.dart';
import 'package:medic_admin/controller/medicine_controller.dart';
import 'package:medic_admin/model/category_data.dart';
import 'package:medic_admin/model/medicine_data.dart';
import 'package:medic_admin/screen/add_category.dart';
import 'package:medic_admin/screen/add_medicine.dart';
import 'package:medic_admin/screen/discount_screen.dart';
import 'package:medic_admin/screen/orders_screen.dart';
import 'package:medic_admin/screen/prescription_screen.dart';
import 'package:medic_admin/screen/view_category.dart';
import 'package:medic_admin/screen/view_medicine.dart';
import 'package:medic_admin/theme/colors.dart';
import 'package:medic_admin/utils/app_font.dart';
import 'package:medic_admin/utils/assets.dart';
import 'package:medic_admin/widgets/app_dialogue.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final AuthController _authController = Get.find();
  HomeController controller = Get.put(HomeController());
  MedicineController medicineController = Get.put(MedicineController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: Text(
          "Medic",
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
              color: Colors.white,
              fontSize: 16,
              fontFamily: AppFont.fontMedium),
        ),
        backgroundColor: AppColors.primaryColor,
        centerTitle: true,
      ),
      // body: Row(
      //   children: [
      //     ConstrainedBox(
      //       constraints: BoxConstraints(maxWidth: 300),
      //       child: PermanentDrawer(),
      //     ),
      //     Expanded(
      //       child: Center(
      //         child: Text('Main content area'),
      //       ),
      //     ),
      //   ],
      // ),
      drawer: Drawer(
        backgroundColor: AppColors.white,
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(controller.loggedInUser.value?.name ?? ""),
              currentAccountPicture:
                  SvgPicture.asset(AppImages.medic_white_text),
              currentAccountPictureSize: const Size(120, 120),
              accountEmail: Text(controller.getMobileNo()),
              decoration: BoxDecoration(color: AppColors.primaryColor),
            ),
            ListTile(
                onTap: () {
                  Get.to(() => AddCategory());
                },
                leading: const Icon(Icons.add),
                title: const Text("Add Category")),
            ListTile(
                onTap: () {
                  Get.to(() => const ViewCategory());
                },
                leading: const Icon(Icons.view_agenda_outlined),
                title: const Text("View Category")),
            ListTile(
                onTap: () {
                  Get.to(() => AddMedicine());
                },
                leading: const Icon(Icons.add),
                title: const Text("Add Medicine")),
            ListTile(
                onTap: () {
                  Get.to(() => ViewMedicine());
                },
                leading: const Icon(Icons.view_agenda_outlined),
                title: const Text("View Medicine")),
            ListTile(
                onTap: () {
                  Get.to(() => OrderScreen());
                },
                leading: const Icon(Icons.list),
                title: const Text("Orders")),
            ListTile(
                onTap: () {
                  Get.to(() => PrescriptionScreen());
                },
                leading: const Icon(Icons.list),
                title: const Text("Prescription")),
            ListTile(
                onTap: () {
                  Get.to(() => DiscountScreen());
                },
                leading: const Icon(Icons.star),
                title: const Text("Discount")),
            ListTile(
                onTap: () async {
                  await logoutDialogue(context, _authController);
                },
                leading: const Icon(Icons.logout),
                title: const Text("Log Out")),
          ],
        ),
      ),
    );
  }
}

class PermanentDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      // Populate your drawer with items
      child: ListView(
        children: [
          DrawerHeader(child: Text('Drawer Header')),
          ListTile(title: Text('Item 1')),
          ListTile(title: Text('Item 2')),
          // Add other drawer items...
        ],
      ),
    );
  }
}
