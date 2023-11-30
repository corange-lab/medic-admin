import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:medic_admin/controller/order_controller.dart';
import 'package:medic_admin/model/order_data.dart';
import 'package:medic_admin/model/order_with_medicine.dart';
import 'package:medic_admin/screen/order_details.dart';
import 'package:medic_admin/theme/colors.dart';
import 'package:medic_admin/utils/app_font.dart';
import 'package:medic_admin/utils/assets.dart';
import 'package:medic_admin/utils/string.dart';

class OrderScreen extends StatelessWidget {
  OrderController controller = Get.put(OrderController());

  final ScrollController scrollController = ScrollController();

  OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.primaryColor,
        title: Text(
          "Orders",
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
              color: Colors.white,
              fontSize: 16,
              fontFamily: AppFont.fontMedium),
        ),
      ),
      body: StreamBuilder(
        stream: controller.fetchOrders(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
                child: CupertinoActivityIndicator(
              color: AppColors.primaryColor,
              radius: 15,
            ));
          } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            List<OrderData> orders = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
              child: ListView.builder(
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
                                  color: AppColors.txtGrey.withOpacity(0.2))
                            ]),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "Customer Name:",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium!
                                          .copyWith(
                                              fontFamily: AppFont.fontMedium),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    StreamBuilder(
                                      stream: controller.fetchUsernameFromId(
                                          orders[index].creatorId!),
                                      builder: (context, snapshot) {
                                        if (snapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          return const Center(
                                              child:
                                                  CupertinoActivityIndicator());
                                        } else if (snapshot.hasData) {
                                          String userName = snapshot.data!;
                                          return Text(
                                            userName,
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleLarge!
                                                .copyWith(
                                                    fontFamily:
                                                        AppFont.fontSemiBold,
                                                    color:
                                                        AppColors.primaryColor),
                                          );
                                        } else {
                                          return Text(
                                            "Medic User",
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleLarge!
                                                .copyWith(
                                                    fontFamily:
                                                        AppFont.fontSemiBold,
                                                    color:
                                                        AppColors.primaryColor),
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
                                              fontFamily: AppFont.fontMedium),
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
                                              fontFamily: AppFont.fontSemiBold,
                                              color: AppColors.primaryColor),
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
                                              fontFamily: AppFont.fontMedium),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      DateFormat('d MMM yyyy hh:mm a')
                                          .format(orders[index].orderDate!),
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge!
                                          .copyWith(
                                              fontFamily: AppFont.fontSemiBold,
                                              color: AppColors.primaryColor),
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
                                          fontFamily: AppFont.fontSemiBold),
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
                                          fontFamily: AppFont.fontSemiBold,
                                          color: AppColors.primaryColor),
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
                                              fontFamily: AppFont.fontMedium),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      orders[index].orderStatus ?? "Pending",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge!
                                          .copyWith(
                                              fontFamily: AppFont.fontSemiBold,
                                              color: AppColors.primaryColor),
                                    ),
                                  ],
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
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
                          .copyWith(fontSize: 15, color: AppColors.skipGrey),
                    )
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}

//StreamBuilder<List<OrderWithMedicines>>(
//         stream: controller.ordersWithMedicines(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             // return OrderDetailShimmer(itemCount: snapshot.data?.length);
//             return Center(
//                 child: CupertinoActivityIndicator(
//               color: AppColors.primaryColor,
//               radius: 15,
//             ));
//           }
//           if (snapshot.hasError) {
//             return Text('Error: ${snapshot.error}');
//           }
//           if (!snapshot.hasData || snapshot.data!.isEmpty) {
//             return const Text('No orders found');
//           }
//
//           List<OrderWithMedicines> ordersWithMedicines = snapshot.data!;
//
//           List<Widget> medicineAddressDateWidgets = [];
//           for (var order in ordersWithMedicines) {
//             for (var medicine in order.medicines) {
//               medicineAddressDateWidgets.add(GestureDetector(
//                 onTap: () {
//                   // Get.to(() => OrderDetailScreen(
//                   //       orderId: order.orderData.id,
//                   //       isTrue: true,
//                   //       medicineId: medicine.id,
//                   //     ));
//                 },
//                 child: Padding(
//                   padding:
//                       const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
//                   child: Column(
//                     children: [
//                       const SizedBox(
//                         height: 15,
//                       ),
//                       Row(
//                         children: [
//                           SizedBox(
//                             height: 70,
//                             width: 100,
//                             child: ClipRRect(
//                               borderRadius: BorderRadius.circular(10),
//                               child: CachedNetworkImage(
//                                 imageUrl: medicine.image ?? "",
//                                 errorWidget: (context, url, error) =>
//                                     const Icon(Icons.error),
//                                 progressIndicatorBuilder:
//                                     (context, url, downloadProgress) =>
//                                         SizedBox(
//                                   width: 30,
//                                   height: 30,
//                                   child: Center(
//                                       child: LoadingIndicator(
//                                     colors: [AppColors.primaryColor],
//                                     indicatorType: Indicator.ballScale,
//                                     strokeWidth: 1,
//                                   )),
//                                 ),
//                                 fit: BoxFit.cover,
//                               ),
//                             ),
//                           ),
//                           const SizedBox(
//                             width: 10,
//                           ),
//                           Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 "${medicine.genericName}",
//                                 style: Theme.of(context)
//                                     .textTheme
//                                     .titleMedium!
//                                     .copyWith(fontFamily: AppFont.fontBold),
//                               ),
//                               const SizedBox(
//                                 height: 5,
//                               ),
//                               Text(
//                                 "15 Capsule(s) in Bottle",
//                                 style: Theme.of(context)
//                                     .textTheme
//                                     .titleSmall!
//                                     .copyWith(color: AppColors.txtGrey),
//                               ),
//                               const SizedBox(
//                                 height: 5,
//                               ),
//                               Text(
//                                 "SLL ${medicine.medicinePrice}",
//                                 style: Theme.of(context)
//                                     .textTheme
//                                     .titleMedium!
//                                     .copyWith(
//                                         fontFamily: AppFont.fontMedium,
//                                         fontSize: 12),
//                               ),
//                             ],
//                           )
//                         ],
//                       ),
//                       Divider(
//                         height: 30,
//                         color: AppColors.lineGrey,
//                         thickness: 1,
//                       ),
//                       Row(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Expanded(
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 // Text(
//                                 //   "${order.address!.address}, ${order.address!.area}, ${order.address!.landmark}",
//                                 //   style: Theme.of(context)
//                                 //       .textTheme
//                                 //       .titleSmall!
//                                 //       .copyWith(
//                                 //           color: AppColors.txtGrey,
//                                 //           fontSize: 12),
//                                 // ),
//                                 const SizedBox(
//                                   height: 5,
//                                 ),
//                                 Text(
//                                   order.orderData.orderDate != null
//                                       ? DateFormat('d MMM yyyy hh:mm a')
//                                           .format(order.orderData.orderDate!)
//                                       : 'Date not available',
//                                   style: Theme.of(context)
//                                       .textTheme
//                                       .titleSmall!
//                                       .copyWith(
//                                           color: AppColors.txtGrey,
//                                           fontSize: 12),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           Icon(
//                             Icons.arrow_forward_ios,
//                             size: 13,
//                             color: AppColors.txtGrey,
//                           )
//                         ],
//                       ),
//                       const SizedBox(
//                         height: 10,
//                       ),
//                       Row(
//                         children: [
//                           Expanded(
//                             child: ElevatedButton(
//                                 onPressed: () {},
//                                 style: ElevatedButton.styleFrom(
//                                     backgroundColor: AppColors.decsGrey,
//                                     fixedSize: const Size(200, 45),
//                                     elevation: 0,
//                                     shape: RoundedRectangleBorder(
//                                         borderRadius:
//                                             BorderRadius.circular(30))),
//                                 child: Text(
//                                   ConstString.cancle,
//                                   style: Theme.of(context)
//                                       .textTheme
//                                       .displayMedium!
//                                       .copyWith(
//                                         color: AppColors.txtGrey,
//                                       ),
//                                 )),
//                           ),
//                           const SizedBox(
//                             width: 15,
//                           ),
//                           Expanded(
//                             child: ElevatedButton(
//                                 onPressed: () {},
//                                 style: ElevatedButton.styleFrom(
//                                     backgroundColor: AppColors.primaryColor,
//                                     fixedSize: const Size(200, 45),
//                                     elevation: 0,
//                                     shape: RoundedRectangleBorder(
//                                         borderRadius:
//                                             BorderRadius.circular(30))),
//                                 child: Text(
//                                   ConstString.completed,
//                                   style: Theme.of(context)
//                                       .textTheme
//                                       .displayMedium!
//                                       .copyWith(
//                                         color: Colors.white,
//                                       ),
//                                 )),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ));
//             }
//           }
//
//           return Padding(
//             padding: const EdgeInsets.symmetric(vertical: 10),
//             child: Scrollbar(
//               controller: scrollController,
//               radius: Radius.circular(10),
//               thumbVisibility: true,
//               trackVisibility: true,
//               interactive: true,
//               child: ListView(
//                 controller: scrollController,
//                 children: medicineAddressDateWidgets,
//               ),
//             ),
//           );
//         },
//       )
