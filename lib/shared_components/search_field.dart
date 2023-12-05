import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:medic_admin/constans/app_constants.dart';
import 'package:medic_admin/theme/colors.dart';
import 'package:medic_admin/utils/app_font.dart';

class SearchField extends StatelessWidget {
  SearchField({
    this.onSearch,
    this.hintText,
    Key? key,
  }) : super(key: key);

  final controller = TextEditingController();
  final Function(String value)? onSearch;
  final String? hintText;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        prefixIcon: const Icon(EvaIcons.search),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(width: .1),
        ),
        border: const UnderlineInputBorder(
          borderSide: BorderSide(width: .1),
        ),
        disabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(width: .1),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(width: .1),
        ),
        errorBorder: const UnderlineInputBorder(
          borderSide: BorderSide(width: .1),
        ),
        focusedErrorBorder: const UnderlineInputBorder(
          borderSide: BorderSide(width: .1),
        ),
        hintText: hintText ?? "search..",
        hintStyle: Theme.of(context).textTheme.titleMedium!.copyWith(
            fontFamily: AppFont.fontMedium,
            fontSize: 16,
            color: AppColors.txtGrey),
      ),
      onEditingComplete: () {
        FocusScope.of(context).unfocus();
        if (onSearch != null) onSearch!(controller.text);
      },
      textInputAction: TextInputAction.search,
      style: Theme.of(context).textTheme.titleMedium!.copyWith(
          fontFamily: AppFont.fontMedium,
          fontSize: 16,
          color: AppColors.txtGrey),
    );
  }
}
