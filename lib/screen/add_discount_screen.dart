// ignore_for_file: must_be_immutable, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:medic_admin/controller/discount_controller.dart';
import 'package:medic_admin/model/discount_data_model.dart';
import 'package:medic_admin/theme/colors.dart';
import 'package:medic_admin/utils/app_font.dart';
import 'package:medic_admin/utils/assets.dart';
import 'package:medic_admin/utils/string.dart';
import 'package:medic_admin/widgets/app_dialogue.dart';

class AddDiscount extends StatelessWidget {
  DiscountDataModel? discountData;

  DiscountController controller = Get.put(DiscountController());

  AddDiscount({super.key, this.discountData});

  @override
  Widget build(BuildContext context) {
    if (discountData != null) {
      controller.disNameController.text = discountData?.discountName ?? "";
      controller.disPerController.text =
          discountData!.percentage!.toStringAsFixed(2);
      controller.disPriceController.text =
          discountData!.amount!.toStringAsFixed(2);
      controller.disCodeController.text = discountData?.code ?? "";
      controller.discountType.value = discountData?.type ?? "";
    } else {
      controller.clearController();
    }

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.primaryColor,
        title: Text(
          "Add Discount",
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
              color: Colors.white,
              fontSize: 16,
              fontFamily: AppFont.fontMedium),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  ConstString.discountName,
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(fontFamily: AppFont.fontMedium),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                  controller: controller.disNameController,
                  decoration: InputDecoration(
                    hintText: ConstString.enterDiscountName,
                    hintStyle: TextStyle(
                        fontFamily: AppFont.fontMedium,
                        color: AppColors.phoneGrey,
                        fontSize: 14),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.lineGrey)),
                    disabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.lineGrey)),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.lineGrey)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.lineGrey)),
                    errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.lineGrey)),
                    focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.lineGrey)),
                  )),
              const SizedBox(
                height: 20,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  ConstString.discountType,
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(fontFamily: AppFont.fontMedium),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Obx(() => Container(
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
                          "Select Discount Type",
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall!
                              .copyWith(fontSize: 15, color: AppColors.txtGrey),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        icon: SvgPicture.asset(
                          AppIcons.arrowDown,
                          color: AppColors.primaryColor,
                        ),
                        underline: const SizedBox(),
                        borderRadius: BorderRadius.circular(10),
                        dropdownColor: AppColors.white,
                        onChanged: (value) {
                          controller.discountType.value = value!;
                        },
                        items: controller.disTypeList.isNotEmpty
                            ? controller.disTypeList.map((String items) {
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
                        value: controller.disTypeList
                                .contains(controller.discountType.value)
                            ? controller.discountType.value
                            : null,
                      ),
                    )),
              ),
              const SizedBox(
                height: 20,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  ConstString.discountPercentage,
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(fontFamily: AppFont.fontMedium),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                  controller: controller.disPerController,
                  decoration: InputDecoration(
                    hintText: ConstString.enterDiscountPer,
                    hintStyle: TextStyle(
                        fontFamily: AppFont.fontMedium,
                        color: AppColors.phoneGrey,
                        fontSize: 14),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.lineGrey)),
                    disabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.lineGrey)),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.lineGrey)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.lineGrey)),
                    errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.lineGrey)),
                    focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.lineGrey)),
                  )),
              const SizedBox(
                height: 20,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  ConstString.discountPrice,
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(fontFamily: AppFont.fontMedium),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                  controller: controller.disPriceController,
                  decoration: InputDecoration(
                    hintText: ConstString.enterDiscountPrice,
                    hintStyle: TextStyle(
                        fontFamily: AppFont.fontMedium,
                        color: AppColors.phoneGrey,
                        fontSize: 14),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.lineGrey)),
                    disabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.lineGrey)),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.lineGrey)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.lineGrey)),
                    errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.lineGrey)),
                    focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.lineGrey)),
                  )),
              const SizedBox(
                height: 20,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  ConstString.discountCode,
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(fontFamily: AppFont.fontMedium),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                  controller: controller.disCodeController,
                  decoration: InputDecoration(
                    hintText: ConstString.enterDiscountCode,
                    hintStyle: TextStyle(
                        fontFamily: AppFont.fontMedium,
                        color: AppColors.phoneGrey,
                        fontSize: 14),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.lineGrey)),
                    disabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.lineGrey)),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.lineGrey)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.lineGrey)),
                    errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.lineGrey)),
                    focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.lineGrey)),
                  )),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () async {
                    if (controller.validateData()) {
                      showProgressDialogue(context);
                      String id = controller.discountRef.doc().id;

                      if (discountData == null) {
                        DiscountDataModel discountDataModel = DiscountDataModel(
                            id: id,
                            discountName:
                                controller.disNameController.text.trim(),
                            type: controller.discountType.value,
                            percentage: double.parse(
                                controller.disPerController.text.trim()),
                            amount: double.parse(
                                controller.disPriceController.text.trim()),
                            code: controller.disCodeController.text.trim());

                        await controller.addDiscountData(discountDataModel);
                      } else {
                        DiscountDataModel discountDataModel = DiscountDataModel(
                            id: discountData!.id,
                            discountName:
                                controller.disNameController.text.trim(),
                            type: controller.discountType.value,
                            percentage: double.parse(
                                controller.disPerController.text.trim()),
                            amount: double.parse(
                                controller.disPriceController.text.trim()),
                            code: controller.disCodeController.text.trim());

                        await controller.addDiscountData(discountDataModel);
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryColor,
                      fixedSize: const Size(double.infinity, 50),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30))),
                  child: Text(
                    discountData == null
                        ? ConstString.addDiscount
                        : ConstString.editDiscount,
                    style: Theme.of(context).textTheme.displayMedium!.copyWith(
                          color: Colors.white,
                        ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
