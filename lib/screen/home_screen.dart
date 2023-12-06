// ignore_for_file: must_be_immutable

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:medic_admin/constans/app_constants.dart';
import 'package:medic_admin/controller/auth_controller.dart';
import 'package:medic_admin/controller/dashboard_controller.dart';
import 'package:medic_admin/controller/medicine_controller.dart';
import 'package:medic_admin/controller/order_controller.dart';
import 'package:medic_admin/model/order_data.dart';
import 'package:medic_admin/screen/add_medicine.dart';
import 'package:medic_admin/screen/category_add.dart';
import 'package:medic_admin/screen/discount_screen.dart';
import 'package:medic_admin/screen/order_details.dart';
import 'package:medic_admin/screen/orders_screen.dart';
import 'package:medic_admin/screen/prescription_screen.dart';
import 'package:medic_admin/screen/view_category.dart';
import 'package:medic_admin/screen/view_medicine.dart';
import 'package:medic_admin/shared_components/header_text.dart';
import 'package:medic_admin/shared_components/responsive_builder.dart';
import 'package:medic_admin/shared_components/search_field.dart';
import 'package:medic_admin/theme/colors.dart';
import 'package:medic_admin/utils/string.dart';
import 'package:medic_admin/widgets/header_all_order.dart';
import 'package:medic_admin/widgets/main_menu.dart';
import 'package:medic_admin/utils/app_font.dart';
import 'package:medic_admin/utils/assets.dart';
import 'package:medic_admin/utils/helpers/app_helpers.dart';
import 'package:medic_admin/widgets/app_dialogue.dart';
import 'package:medic_admin/widgets/task_in_progress.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final AuthController _authController = Get.find();
  DashboardController controller = Get.put(DashboardController());
  MedicineController medicineController = Get.put(MedicineController());
  OrderController orderController = Get.put(OrderController());

  final GlobalKey<ScaffoldState> globalScaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: globalScaffoldKey,
      backgroundColor: AppColors.white,
      drawer: ResponsiveBuilder.isDesktop(context)
          ? null
          : Drawer(
              child: SafeArea(
                child: SingleChildScrollView(child: _buildSidebar(context)),
              ),
            ),
      body: SafeArea(
        child: ResponsiveBuilder(
          mobileBuilder: (context, constraints) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Obx(() => selectionContent(
                      onPressedMenu: () {
                        controller.openDrawer(globalScaffoldKey);
                      },
                      context: context)),
                ],
              ),
            );
          },
          tabletBuilder: (context, constraints) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  flex: constraints.maxWidth > 800 ? 8 : 7,
                  child: SingleChildScrollView(
                    controller: ScrollController(),
                    child: Obx(() => selectionContent(
                        onPressedMenu: () {
                          controller.openDrawer(globalScaffoldKey);
                        },
                        context: context)),
                  ),
                ),
              ],
            );
          },
          desktopBuilder: (context, constraints) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  flex: constraints.maxWidth > 1350 ? 3 : 4,
                  child: SingleChildScrollView(
                    controller: ScrollController(),
                    child: _buildSidebar(context),
                  ),
                ),
                Flexible(
                  flex: constraints.maxWidth > 1350 ? 10 : 9,
                  child: Obx(() => selectionContent(context: context)),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget selectionContent({Function()? onPressedMenu, BuildContext? context}) {
    switch (controller.selectedMenuIndex.value) {
      case 0:
        return _buildTaskContent(onPressedMenu: onPressedMenu);
      case 1:
        return CategoryAdd(
          onPressedMenu: onPressedMenu,
        );
      case 2:
        return ViewCategory(
          onPressedMenu: onPressedMenu,
        );
      case 3:
        return AddMedicine(
          onPressedMenu: onPressedMenu,
        );
      case 4:
        return ViewMedicine(
          onPressedMenu: onPressedMenu,
        );
      case 5:
        return OrderScreen(
          fromHome: false,
          onPressedMenu: onPressedMenu,
        );
      case 6:
        return PrescriptionScreen(
          onPressedMenu: onPressedMenu,
        );
      case 7:
        return DiscountScreen(
          onPressedMenu: onPressedMenu,
        );
      case 8:
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          showLogOutDialogue(context!);
        });
        return _buildTaskContent(onPressedMenu: onPressedMenu);
      default:
        return _buildTaskContent(onPressedMenu: onPressedMenu);
    }
  }

  void showLogOutDialogue(BuildContext context) {
    logoutDialogue(context, _authController);
  }

  Widget _buildSidebar(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: ListTile(
            leading: Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.primaryColor,
              ),
            ),
            title: Text(
              controller.loggedInUser.value?.name ?? "Medic Admin",
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: AppColors.primaryColor,
                  fontFamily: AppFont.fontSemiBold,
                  fontSize: 16),
            ),
            // subtitle: Text(
            //   controller.getMobileNo(),
            //   style: Theme.of(context)
            //       .textTheme
            //       .titleMedium!
            //       .copyWith(fontFamily: AppFont.fontMedium),
            // ),
          ),
        ),
        const SizedBox(height: 15),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: MainMenu(onSelected: controller.onSelectedMainMenu),
        ),
      ],
    );
  }

  Widget _buildTaskContent({Function()? onPressedMenu}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kSpacing),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: kSpacing),
            Row(
              children: [
                if (onPressedMenu != null)
                  Padding(
                    padding: const EdgeInsets.only(right: kSpacing / 2),
                    child: IconButton(
                      onPressed: onPressedMenu,
                      icon: Icon(
                        Icons.menu,
                        color: AppColors.txtGrey,
                      ),
                    ),
                  ),
                Expanded(
                  child: SearchField(
                    onSearch: controller.searchTask,
                    hintText: "Search Task .. ",
                  ),
                ),
              ],
            ),
            const SizedBox(height: kSpacing),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                HeaderText(
                  DateTime.now().formatdMMMMY(),
                ),
                FutureBuilder(
                  future: controller.calculateTotalRevenue(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CupertinoActivityIndicator());
                    } else if (snapshot.hasData) {
                      double revanue = snapshot.data!;
                      return Text(
                        "Total Revanue : $revanue",
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            fontFamily: AppFont.fontSemiBold,
                            fontSize: 18,
                            color: AppColors.primaryColor),
                      );
                    } else {
                      return SizedBox();
                    }
                  },
                )
              ],
            ),
            const SizedBox(height: kSpacing),
            TaskInProgress(
              data: controller.taskInProgress,
            ),
            const SizedBox(height: kSpacing * 2),
            const HeaderAllOrder(),
            const SizedBox(height: kSpacing),
            StreamBuilder(
              stream: orderController.fetchDashboardOrders(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CupertinoActivityIndicator());
                } else if (snapshot.hasData) {
                  List<OrderData> orders = snapshot.data!;
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 15),
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: orders.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Get.to(() => OrderDetails(orders[index]));
                          },
                          child: Container(
                              margin: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 5),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 15),
                              decoration: BoxDecoration(
                                  color: AppColors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                        blurRadius: 2,
                                        spreadRadius: 2,
                                        offset: const Offset(1, 3),
                                        color:
                                            AppColors.txtGrey.withOpacity(0.2))
                                  ]),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            "Customer Name:",
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleMedium!
                                                .copyWith(
                                                    fontFamily:
                                                        AppFont.fontMedium),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          StreamBuilder(
                                            stream: orderController
                                                .fetchUsernameFromId(
                                                    orders[index].creatorId!),
                                            builder: (context, snapshot) {
                                              if (snapshot.connectionState ==
                                                  ConnectionState.waiting) {
                                                return const Center(
                                                    child:
                                                        CupertinoActivityIndicator());
                                              } else if (snapshot.hasData) {
                                                String userName =
                                                    snapshot.data!;
                                                return Text(
                                                  userName,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleLarge!
                                                      .copyWith(
                                                          fontFamily: AppFont
                                                              .fontSemiBold,
                                                          color: AppColors
                                                              .primaryColor),
                                                );
                                              } else {
                                                return Text(
                                                  "Medic User",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleLarge!
                                                      .copyWith(
                                                          fontFamily: AppFont
                                                              .fontSemiBold,
                                                          color: AppColors
                                                              .primaryColor),
                                                );
                                              }
                                            },
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "Order No:",
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleMedium!
                                                .copyWith(
                                                    fontFamily:
                                                        AppFont.fontMedium),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            "${orders[index].id}",
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleLarge!
                                                .copyWith(
                                                    fontFamily:
                                                        AppFont.fontSemiBold,
                                                    color:
                                                        AppColors.primaryColor),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "Order Date:",
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleMedium!
                                                .copyWith(
                                                    fontFamily:
                                                        AppFont.fontMedium),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            DateFormat('d MMM yyyy hh:mm a')
                                                .format(
                                                    orders[index].orderDate!),
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleLarge!
                                                .copyWith(
                                                    fontFamily:
                                                        AppFont.fontSemiBold,
                                                    color:
                                                        AppColors.primaryColor),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "Status :",
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleMedium!
                                                .copyWith(
                                                    fontFamily:
                                                        AppFont.fontMedium),
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            orders[index].orderStatus ??
                                                "Pending",
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleLarge!
                                                .copyWith(
                                                    fontFamily:
                                                        AppFont.fontSemiBold,
                                                    color:
                                                        AppColors.primaryColor),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        "SLL",
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleLarge!
                                            .copyWith(
                                                fontFamily:
                                                    AppFont.fontSemiBold),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        "${orders[index].totalAmount ?? 0}",
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleLarge!
                                            .copyWith(
                                                fontSize: 20,
                                                fontFamily:
                                                    AppFont.fontSemiBold,
                                                color: AppColors.primaryColor),
                                      ),
                                    ],
                                  )
                                ],
                              )),
                        );
                      },
                    ),
                  );
                } else {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(AppImages.emptyBin),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            ConstString.noOrder,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                    fontSize: 15, color: AppColors.skipGrey),
                          )
                        ],
                      ),
                    ),
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }

  Widget orderDataItems() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 5,
      itemBuilder: (context, index) {
        return const ListTile(
          leading: Icon(Icons.add),
          title: Text("order Data"),
          trailing: Icon(Icons.more_vert),
        );
      },
    );
  }
}

// drawer: Drawer(
//   backgroundColor: AppColors.white,
//   child: ListView(
//     children: [
//       UserAccountsDrawerHeader(
//         accountName: Text(controller.loggedInUser.value?.name ?? ""),
//         currentAccountPicture:
//             SvgPicture.asset(AppImages.medic_white_text),
//         currentAccountPictureSize: const Size(120, 120),
//         accountEmail: Text(controller.getMobileNo()),
//         decoration: BoxDecoration(color: AppColors.primaryColor),
//       ),
//       ListTile(
//           onTap: () {
//             Get.to(() => CategoryAdd());
//           },
//           leading: const Icon(Icons.add),
//           title: const Text("Add Category")),
//       ListTile(
//           onTap: () {
//             Get.to(() => const ViewCategory());
//           },
//           leading: const Icon(Icons.view_agenda_outlined),
//           title: const Text("View Category")),
//       ListTile(
//           onTap: () {
//             Get.to(() => AddMedicine());
//           },
//           leading: const Icon(Icons.add),
//           title: const Text("Add Medicine")),
//       ListTile(
//           onTap: () {
//             Get.to(() => ViewMedicine());
//           },
//           leading: const Icon(Icons.view_agenda_outlined),
//           title: const Text("View Medicine")),
//       ListTile(
//           onTap: () {
//             Get.to(() => OrderScreen());
//           },
//           leading: const Icon(Icons.list),
//           title: const Text("Orders")),
//       ListTile(
//           onTap: () {
//             Get.to(() => PrescriptionScreen());
//           },
//           leading: const Icon(Icons.list),
//           title: const Text("Prescription")),
//       ListTile(
//           onTap: () {
//             Get.to(() => DiscountScreen());
//           },
//           leading: const Icon(Icons.star),
//           title: const Text("Discount")),
//       ListTile(
//           onTap: () async {
//             await logoutDialogue(context, _authController);
//           },
//           leading: const Icon(Icons.logout),
//           title: const Text("Log Out")),
//     ],
//   ),
// ),
