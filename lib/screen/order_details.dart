// ignore_for_file: must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:medic_admin/controller/order_controller.dart';
import 'package:medic_admin/model/order_data.dart';
import 'package:medic_admin/model/user_address.dart';
import 'package:medic_admin/model/user_model.dart';
import 'package:medic_admin/theme/colors.dart';
import 'package:medic_admin/utils/app_font.dart';
import 'package:medic_admin/utils/assets.dart';
import 'package:medic_admin/utils/string.dart';
import 'package:medic_admin/utils/utils.dart';

class OrderDetails extends StatelessWidget {
  OrderController controller = Get.put(OrderController());

  OrderData? orderData;

  final scrollController = ScrollController();

  OrderDetails(this.orderData, {super.key});

  @override
  Widget build(BuildContext context) {
    List<String> medicineIdList = orderData!.medicineId.values.toList();
    List<int> medicineQuantityList = controller.getQuantitiesList(
        medicineIdList, orderData!.medicineQuantities!);
    controller.orderStatus.value = orderData?.orderStatus ?? "Placed";
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.primaryColor,
        title: Text(
          "Order Details",
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
              color: Colors.white,
              fontSize: 16,
              fontFamily: AppFont.fontMedium),
        ),
      ),
      body: Scrollbar(
        controller: scrollController,
        child: SingleChildScrollView(
          controller: scrollController,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    StreamBuilder(
                      stream:
                          controller.fetchUsernameFromId(orderData!.creatorId!),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const CupertinoActivityIndicator();
                        } else if (snapshot.hasData) {
                          String username = snapshot.data!;
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                ConstString.patient,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall!
                                    .copyWith(
                                        color: AppColors.txtGrey,
                                        fontFamily: AppFont.fontMedium,
                                        fontSize: 13),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                username,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(
                                        color: AppColors.primaryColor,
                                        fontFamily: AppFont.fontBold,
                                        fontSize: 16),
                              ),
                            ],
                          );
                        } else {
                          return const Text("No User");
                        }
                      },
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          ConstString.orderNo,
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall!
                              .copyWith(
                                  color: AppColors.txtGrey,
                                  fontFamily: AppFont.fontMedium,
                                  fontSize: 13),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          "#${orderData?.id!}",
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(
                                  color: AppColors.primaryColor,
                                  fontFamily: AppFont.fontBold,
                                  fontSize: 16),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        ConstString.orderItem,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(
                                color: AppColors.darkPrimaryColor,
                                fontFamily: AppFont.fontBold),
                      ),
                      Text(
                        ConstString.quantity,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(
                                color: AppColors.darkPrimaryColor,
                                fontFamily: AppFont.fontBold),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                FutureBuilder(
                  future: controller.fetchMedicineNameFromIds(medicineIdList),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CupertinoActivityIndicator();
                    } else if (snapshot.hasData) {
                      List<String?> medicineNames = snapshot.data!;
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: medicineNames.length,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "${medicineNames[index]}",
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge!
                                      .copyWith(
                                          color: AppColors.primaryColor,
                                          fontFamily: AppFont.fontSemiBold),
                                ),
                                Text(
                                  "${medicineQuantityList[index]}",
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge!
                                      .copyWith(
                                          color: AppColors.primaryColor,
                                          fontFamily: AppFont.fontSemiBold),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    } else {
                      return Text(
                        "No Items In Order",
                        style: Theme.of(context).textTheme.titleMedium,
                      );
                    }
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    ConstString.addressDetail,
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: AppColors.darkPrimaryColor,
                        fontFamily: AppFont.fontBold),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      border: Border.all(color: AppColors.lineGrey),
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    child: StreamBuilder(
                      stream: controller.fetchAddressById(
                          orderData!.addressId!, orderData!.creatorId!),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const CupertinoActivityIndicator();
                        } else if (snapshot.hasData) {
                          UserAddress add = snapshot.data!;
                          String address =
                              "${add.address}, ${add.area}, ${add.landmark}";
                          return Row(
                            children: [
                              SvgPicture.asset(
                                AppIcons.pin,
                                color: AppColors.txtGrey,
                                height: 15,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Text(
                                  address,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall!
                                      .copyWith(
                                          color: AppColors.txtGrey,
                                          fontSize: 12),
                                ),
                              ),
                            ],
                          );
                        } else {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Unknown Place",
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          );
                        }
                      },
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    ConstString.orderStatus,
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: AppColors.darkPrimaryColor,
                        fontFamily: AppFont.fontBold),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Obx(() => Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color: AppColors.white,
                                border: Border.all(color: AppColors.lineGrey),
                                borderRadius: BorderRadius.circular(10)),
                            child: DropdownButton(
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .copyWith(fontSize: 15),
                              hint: Text(
                                "Select Order Status",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall!
                                    .copyWith(
                                        fontSize: 15, color: AppColors.txtGrey),
                              ),
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              icon: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SvgPicture.asset(
                                  AppIcons.arrowDown,
                                  color: AppColors.primaryColor,
                                ),
                              ),
                              underline: const SizedBox(),
                              borderRadius: BorderRadius.circular(10),
                              dropdownColor: AppColors.white,
                              onChanged: (String? newValue) {
                                if (newValue != null) {
                                  controller.orderStatus.value = newValue;
                                }
                              },
                              items: controller.orderStatusList.isNotEmpty
                                  ? controller.orderStatusList
                                      .map((String items) {
                                      return DropdownMenuItem(
                                        value: items,
                                        child: Text(
                                          items,
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium!
                                              .copyWith(fontSize: 15),
                                        ),
                                      );
                                    }).toList()
                                  : null,
                              value: controller.orderStatusList
                                      .contains(controller.orderStatus.value)
                                  ? controller.orderStatus.value
                                  : null,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          ElevatedButton(
                              onPressed: () {
                                controller
                                    .updateOrderStatus(orderData!.id!,
                                        controller.orderStatus.value)
                                    .then((value) {
                                  showInSnackBar("Status Applied Successfully",
                                      isSuccess: true, title: "The Medic");
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.primaryColor,
                                  fixedSize: const Size(130, 40),
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10))),
                              child: Text(
                                ConstString.applyStatus,
                                style: Theme.of(context)
                                    .textTheme
                                    .displayMedium!
                                    .copyWith(
                                      color: Colors.white,
                                    ),
                              ))
                        ],
                      )),
                ),
                const SizedBox(
                  height: 20,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    ConstString.billDetail,
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: AppColors.darkPrimaryColor,
                        fontFamily: AppFont.fontBold),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Container(
                  height: 250,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: AppColors.lineGrey)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                ConstString.orderItem,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall!
                                    .copyWith(
                                        color: AppColors.txtGrey,
                                        fontFamily: AppFont.fontMedium,
                                        fontSize: 13),
                              ),
                              Text(
                                "${orderData?.quantity ?? 1} Item",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall!
                                    .copyWith(
                                        color: AppColors.darkPrimaryColor,
                                        fontFamily: AppFont.fontMedium,
                                        fontSize: 13),
                              ),
                            ],
                          ),
                          Divider(
                            height: 10,
                            color: AppColors.lineGrey,
                            thickness: 1,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                ConstString.cartValue,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall!
                                    .copyWith(
                                        color: AppColors.txtGrey,
                                        fontFamily: AppFont.fontMedium,
                                        fontSize: 13),
                              ),
                              Text(
                                "LE ${orderData!.subTotal ?? 0}",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall!
                                    .copyWith(
                                        color: AppColors.darkPrimaryColor,
                                        fontFamily: AppFont.fontMedium,
                                        fontSize: 13),
                              ),
                            ],
                          ),
                          Divider(
                            height: 10,
                            color: AppColors.lineGrey,
                            thickness: 1,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                ConstString.shipping,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall!
                                    .copyWith(
                                        color: AppColors.txtGrey,
                                        fontFamily: AppFont.fontMedium,
                                        fontSize: 13),
                              ),
                              Text(
                                "SLL ${orderData?.shippingCharge ?? 100}",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall!
                                    .copyWith(
                                        color: AppColors.darkPrimaryColor,
                                        fontFamily: AppFont.fontMedium,
                                        fontSize: 13),
                              ),
                            ],
                          ),
                          Divider(
                            height: 10,
                            color: AppColors.lineGrey,
                            thickness: 1,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                ConstString.discount,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall!
                                    .copyWith(
                                        color: AppColors.txtGrey,
                                        fontFamily: AppFont.fontMedium,
                                        fontSize: 13),
                              ),
                              Text(
                                "SLL ${orderData?.discountAmount?.toStringAsFixed(1) ?? 0}",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall!
                                    .copyWith(
                                        color: AppColors.darkPrimaryColor,
                                        fontFamily: AppFont.fontMedium,
                                        fontSize: 13),
                              ),
                            ],
                          ),
                          Divider(
                            height: 10,
                            color: AppColors.lineGrey,
                            thickness: 1,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                ConstString.total,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall!
                                    .copyWith(
                                        color: AppColors.txtGrey,
                                        fontFamily: AppFont.fontMedium,
                                        fontSize: 13),
                              ),
                              Text(
                                "SLL ${orderData?.totalAmount ?? 00}",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall!
                                    .copyWith(
                                        color: AppColors.primaryColor,
                                        fontFamily: AppFont.fontMedium,
                                        fontSize: 13),
                              ),
                            ],
                          ),
                        ]),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
