import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:medic_admin/controller/order_controller.dart';
import 'package:medic_admin/model/order_data.dart';
import 'package:medic_admin/screen/add_category.dart';
import 'package:medic_admin/screen/add_medicine.dart';
import 'package:medic_admin/screen/discount_screen.dart';
import 'package:medic_admin/screen/orders_screen.dart';
import 'package:medic_admin/theme/colors.dart';
import 'package:medic_admin/utils/app_font.dart';
import 'package:medic_admin/utils/helpers/app_helpers.dart';

class CardTaskData {
  final String label;
  final String jobDesk;
  final DateTime dueDate;

  const CardTaskData({
    required this.label,
    required this.jobDesk,
    required this.dueDate,
  });
}

class CardTask extends StatelessWidget {
  CardTask({
    required this.data,
    required this.primary,
    required this.onPrimary,
    required this.index,
    Key? key,
  }) : super(key: key);

  final CardTaskData data;
  final Color primary;
  final Color onPrimary;
  final int index;

  OrderController controller = Get.put(OrderController());

  Stream<List<OrderData>> _selectedStream() {
    switch (index) {
      case 0:
        return controller.fetchNewOrders();
      case 1:
        return controller.fetchProcessOrders();
      case 2:
        return controller.fetchCompletedOrders();
      default:
        return controller.fetchAllOrders();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Material(
        child: InkWell(
          onTap: () {},
          child: Container(
            width: 250,
            height: 250,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [primary, primary.withOpacity(.7)],
                begin: AlignmentDirectional.topCenter,
                end: AlignmentDirectional.bottomCenter,
              ),
            ),
            child: _BackgroundDecoration(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    _buildLabel(context),
                    const Spacer(
                      flex: 5,
                    ),
                    StreamBuilder(
                      stream: _selectedStream(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                              child: const CupertinoActivityIndicator());
                        } else if (snapshot.hasData &&
                            snapshot.data!.isNotEmpty) {
                          return Text(
                            "Total Orders : ${snapshot.data!.length}",
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                    fontFamily: AppFont.fontSemiBold,
                                    fontSize: 16,
                                    color: AppColors.white),
                          );
                        } else {
                          return Text(
                            "No Order Found!",
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                    fontFamily: AppFont.fontSemiBold,
                                    fontSize: 16,
                                    color: AppColors.white),
                          );
                        }
                      },
                    ),
                    const Spacer(flex: 2),
                    _doneButton(context),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(BuildContext context) {
    return Text(
      data.label,
      style: Theme.of(context).textTheme.titleLarge!.copyWith(
          fontFamily: AppFont.fontBold, color: AppColors.white, fontSize: 20),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildJobdesk() {
    return Container(
      decoration: BoxDecoration(
        color: onPrimary.withOpacity(.3),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Text(
        data.jobDesk,
        style: TextStyle(
          color: onPrimary,
          fontSize: 10,
          letterSpacing: 1,
        ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Widget _buildDate() {
    return _IconLabel(
      color: onPrimary,
      iconData: EvaIcons.calendarOutline,
      label: DateFormat('d MMM').format(data.dueDate),
    );
  }

  Widget _buildHours() {
    return _IconLabel(
      color: onPrimary,
      iconData: EvaIcons.clockOutline,
      label: data.dueDate.dueDate(),
    );
  }

  Widget _doneButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        if (index == 0) {
          Get.to(() => OrderScreen(
                fromHome: true,
                index: index,
              ));
        } else if (index == 1) {
          Get.to(() => OrderScreen(
                fromHome: true,
                index: index,
              ));
        } else if (index == 2) {
          Get.to(() => OrderScreen(
                fromHome: true,
                index: index,
              ));
        } else {
          Get.to(() => OrderScreen(
                fromHome: true,
                index: index,
              ));
        }
      },
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        primary: onPrimary,
        onPrimary: primary,
      ),
      // icon: const Icon(EvaIcons.checkmarkCircle2Outline),
      child: Text(
        "View",
        style: Theme.of(context).textTheme.titleMedium!.copyWith(
            fontFamily: AppFont.fontSemiBold, color: AppColors.txtGrey),
      ),
    );
  }
}

class _IconLabel extends StatelessWidget {
  const _IconLabel({
    required this.color,
    required this.iconData,
    required this.label,
    Key? key,
  }) : super(key: key);

  final Color color;
  final IconData iconData;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          iconData,
          color: color,
          size: 18,
        ),
        const SizedBox(width: 5),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: color.withOpacity(.8),
          ),
        )
      ],
    );
  }
}

class _BackgroundDecoration extends StatelessWidget {
  const _BackgroundDecoration({required this.child, Key? key})
      : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: Alignment.topRight,
          child: Transform.translate(
            offset: const Offset(25, -25),
            child: CircleAvatar(
              radius: 50,
              backgroundColor: Colors.white.withOpacity(.1),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomLeft,
          child: Transform.translate(
            offset: const Offset(-70, 70),
            child: CircleAvatar(
              radius: 100,
              backgroundColor: Colors.white.withOpacity(.1),
            ),
          ),
        ),
        child,
      ],
    );
  }
}
