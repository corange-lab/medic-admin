// ignore_for_file: must_be_immutable

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medic_admin/controller/discount_controller.dart';
import 'package:medic_admin/model/discount_data_model.dart';
import 'package:medic_admin/screen/add_discount_screen.dart';
import 'package:medic_admin/theme/colors.dart';
import 'package:medic_admin/utils/app_font.dart';
import 'package:medic_admin/utils/string.dart';

class DiscountScreen extends StatelessWidget {
  DiscountController controller = Get.put(DiscountController());
  Function()? onPressedMenu;

  DiscountScreen({super.key, this.onPressedMenu});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        StreamBuilder(
          stream: controller.fetchDiscountData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CupertinoActivityIndicator(
                  color: AppColors.primaryColor,
                ),
              );
            } else if (snapshot.hasError) {
              return Text("Error :${snapshot.error}");
            } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
              List<DiscountDataModel> discountList = snapshot.data!;
              return SingleChildScrollView(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  child: Column(
                    children: [
                      if (onPressedMenu != null)
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 0, vertical: 00),
                            child: IconButton(
                              onPressed: onPressedMenu,
                              icon: Icon(
                                Icons.menu,
                                color: AppColors.txtGrey,
                              ),
                            ),
                          ),
                        ),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: discountList.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Container(
                              decoration: BoxDecoration(
                                  border: Border.all(color: AppColors.lineGrey),
                                  borderRadius: BorderRadius.circular(12)),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                child: Row(
                                  children: [
                                    Text(
                                      "${discountList[index].percentage}%",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge!
                                          .copyWith(
                                              fontSize: 50,
                                              color: AppColors.primaryColor,
                                              fontFamily:
                                                  AppFont.fontExtraBold),
                                    ),
                                    const SizedBox(
                                      width: 15,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${discountList[index].discountName}",
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleLarge!
                                              .copyWith(
                                                  fontFamily:
                                                      AppFont.fontSemiBold),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          "${ConstString.discountType} ${discountList[index].type}",
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleLarge!
                                              .copyWith(
                                                  fontFamily:
                                                      AppFont.fontMedium,
                                                  color: discountList[index]
                                                              .type ==
                                                          "Activate"
                                                      ? AppColors.green
                                                      : discountList[index]
                                                                  .type ==
                                                              "Deactivate"
                                                          ? AppColors.red
                                                          : Colors.grey),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          "${ConstString.discountPrice} ${discountList[index].amount}",
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleLarge!
                                              .copyWith(
                                                  fontFamily:
                                                      AppFont.fontMedium,
                                                  fontSize: 14),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          "${ConstString.discountCode} ${discountList[index].code}",
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleLarge!
                                              .copyWith(
                                                  fontFamily:
                                                      AppFont.fontMedium,
                                                  fontSize: 14),
                                        ),
                                      ],
                                    ),
                                    const Spacer(),
                                    IconButton(
                                        onPressed: () {
                                          Get.to(() => AddDiscount(
                                                discountData:
                                                    discountList[index],
                                              ));
                                        },
                                        icon: Icon(
                                          Icons.edit,
                                          color: AppColors.primaryColor,
                                        ))
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return const Text("No Data Found");
            }
          },
        ),
        Positioned(
            bottom: 10,
            right: 10,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 50, right: 30),
              child: FloatingActionButton(
                  backgroundColor: AppColors.primaryColor,
                  onPressed: () {
                    Get.to(() => AddDiscount());
                  },
                  child: Icon(
                    Icons.add,
                    color: AppColors.white,
                  )),
            ))
      ],
    );
    // return Scaffold(
    //   backgroundColor: AppColors.white,
    //   appBar: AppBar(
    //     centerTitle: true,
    //     backgroundColor: AppColors.primaryColor,
    //     title: Text(
    //       "Discount",
    //       style: Theme.of(context).textTheme.titleMedium!.copyWith(
    //           color: Colors.white,
    //           fontSize: 16,
    //           fontFamily: AppFont.fontMedium),
    //     ),
    //   ),
    //   floatingActionButtonLocation: FloatingActionButtonLocation.endContained,
    //   floatingActionButton: Padding(
    //     padding: const EdgeInsets.only(bottom: 50, right: 30),
    //     child: FloatingActionButton(
    //         backgroundColor: AppColors.primaryColor,
    //         onPressed: () {
    //           Get.to(() => AddDiscount());
    //         },
    //         child: Icon(
    //           Icons.add,
    //           color: AppColors.white,
    //         )),
    //   ),
    // );
  }
}
