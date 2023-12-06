import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medic_admin/screen/orders_screen.dart';
import 'package:medic_admin/shared_components/header_text.dart';
import 'package:medic_admin/utils/app_font.dart';

class HeaderAllOrder extends StatelessWidget {
  const HeaderAllOrder({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const HeaderText("Orders"),
        const Spacer(),
        const SizedBox(width: 10),
        viewAllButton(context),
      ],
    );
  }

  Widget viewAllButton(BuildContext context) {
    return TextButton(
        onPressed: () {
          Get.to(() => OrderScreen(fromHome: true,));
        },
        child: Text(
          "View All",
          style: Theme.of(context)
              .textTheme
              .titleMedium!
              .copyWith(fontFamily: AppFont.fontSemiBold),
        ));
  }
}
