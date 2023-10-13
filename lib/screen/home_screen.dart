import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:medic_admin/controller/auth_controller.dart';
import 'package:medic_admin/controller/home_controller.dart';
import 'package:medic_admin/screen/add_medicine.dart';
import 'package:medic_admin/screen/view_medicine.dart';
import 'package:medic_admin/theme/colors.dart';
import 'package:medic_admin/utils/assets.dart';
import 'package:medic_admin/widgets/app_dialogue.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final AuthController _authController = Get.find();
  HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.white,
        appBar: AppBar(
          title: Text(
            "Medic",
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(color: AppColors.white),
          ),
          backgroundColor: AppColors.primaryColor,
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: () async {},
                icon: Icon(
                  Icons.import_export,
                  color: AppColors.white,
                ))
          ],
        ),
        drawer: Drawer(
          backgroundColor: AppColors.white,
          child: ListView(
            children: [
              UserAccountsDrawerHeader(
                accountName: Text(controller.loggedInUser.value?.name ?? ""),
                currentAccountPicture:
                    SvgPicture.asset(AppImages.medic_white_text),
                currentAccountPictureSize: Size(120, 120),
                accountEmail: Text(controller.getMobileNo()),
                decoration: BoxDecoration(color: AppColors.primaryColor),
              ),
              ListTile(
                  onTap: () {
                    Get.to(() => AddMedicine());
                  },
                  leading: Icon(Icons.add),
                  title: Text("Add Medicine")),
              ListTile(
                  onTap: () {
                    Get.to(() => ViewMedicine());
                  },
                  leading: Icon(Icons.view_agenda_outlined),
                  title: Text("View Medicine")),
              ListTile(
                  onTap: () async {
                    await logoutDialogue(context, _authController);
                  },
                  leading: Icon(Icons.logout),
                  title: Text("Log Out")),
            ],
          ),
        ),
        body: DataTable(columns: const [
          DataColumn(label: Text('id')),
          DataColumn(label: Text('about')),
          DataColumn(label: Text('brandName')),
          DataColumn(label: Text('categoryId')),
          DataColumn(label: Text('drugDrugInteractions')),
          DataColumn(label: Text('image')),
          DataColumn(label: Text('placeholderImage')),
          DataColumn(label: Text('ratings')),
          DataColumn(label: Text('genericName')),
          DataColumn(label: Text('description')),
          DataColumn(label: Text('benefits')),
          DataColumn(label: Text('uses')),
          DataColumn(label: Text('directionForUse')),
          DataColumn(label: Text('safetyInformation')),
        ], rows: const []));
  }
}
