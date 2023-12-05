import 'package:flutter/material.dart';
import 'package:medic_admin/theme/colors.dart';
import 'package:medic_admin/utils/app_font.dart';

class HeaderText extends StatelessWidget {
  const HeaderText(this.data, {Key? key}) : super(key: key);

  final String data;
  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: Theme.of(context).textTheme.titleMedium!.copyWith(color: AppColors.darkPrimaryColor,fontFamily: AppFont.fontBold,fontSize: 18),
    );
  }
}
