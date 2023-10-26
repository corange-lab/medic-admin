import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:medic_admin/controller/prescription_controller.dart';
import 'package:medic_admin/model/prescription_model.dart';
import 'package:medic_admin/theme/colors.dart';
import 'package:medic_admin/utils/app_font.dart';

class PrescriptionScreen extends StatelessWidget {
  PrescriptionController controller = Get.put(PrescriptionController());

  PrescriptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.primaryColor,
        title: Text(
          "Prescription Screen",
          style: Theme.of(context)
              .textTheme
              .titleMedium!
              .copyWith(color: Colors.white),
        ),
      ),
      body: StreamBuilder(
        stream: controller.fetchPrescription(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
                child: SizedBox(
              height: 35,
              width: 35,
              child: LoadingIndicator(
                colors: [AppColors.primaryColor],
                indicatorType: Indicator.ballScale,
                strokeWidth: 1,
              ),
            ));
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                "${snapshot.error}",
                style: Theme.of(context).textTheme.titleMedium,
              ),
            );
          } else if (snapshot.hasData) {
            List<PrescriptionData> prescriptionList = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: ListView.builder(
                itemCount: prescriptionList.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: AppColors.lineGrey)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        child: Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "${prescriptionList[index].title}",
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge
                                      ?.copyWith(
                                          color: AppColors.primaryColor,
                                          fontFamily: AppFont.fontBold),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            SizedBox(
                              height: 200,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount:
                                    prescriptionList[index].images?.length,
                                itemBuilder: (context, ind) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: Container(
                                      width: 200,
                                      decoration: BoxDecoration(
                                          color: AppColors.tilePrimaryColor,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: CachedNetworkImage(
                                        imageUrl: prescriptionList[index]
                                                .images?[ind] ??
                                            '',
                                        errorWidget: (context, url, error) {
                                          return const Icon(Icons.error);
                                        },
                                        progressIndicatorBuilder:
                                            (context, url, downloadProgress) =>
                                                SizedBox(
                                          width: 120,
                                          child: Center(
                                              child: SizedBox(
                                            height: 35,
                                            width: 35,
                                            child: LoadingIndicator(
                                              colors: [AppColors.primaryColor],
                                              indicatorType:
                                                  Indicator.ballScale,
                                              strokeWidth: 1,
                                            ),
                                          )),
                                        ),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Row(
                                children: [
                                  prescriptionList[index].isApproved!
                                      ? ElevatedButton(
                                          onPressed: () async {
                                            String userId =
                                                prescriptionList[index].userId!;
                                            String prescriptionId =
                                                prescriptionList[index].id!;
                                            await controller
                                                .approvePrescription(userId,
                                                    prescriptionId, false);
                                          },
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor: AppColors.red,
                                              fixedSize: const Size(100, 40),
                                              elevation: 0,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          30))),
                                          child: const Text("Denied"))
                                      : ElevatedButton(
                                          onPressed: () async {
                                            String userId =
                                                prescriptionList[index].userId!;
                                            String prescriptionId =
                                                prescriptionList[index].id!;
                                            await controller
                                                .approvePrescription(userId,
                                                    prescriptionId, true);
                                          },
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor: AppColors.green,
                                              fixedSize: const Size(100, 40),
                                              elevation: 0,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          30))),
                                          child: const Text("Approved")),
                                  const SizedBox(
                                    width: 15,
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          } else {
            return const Center(child: Text("No Data Found"));
          }
        },
      ),
    );
  }
}
