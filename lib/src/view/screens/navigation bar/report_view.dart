import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../Cubits/Report/report_cubit.dart';
import '../../helpers/show_loading_dialog.dart';
import '../../helpers/show_snack_bar.dart';

class ReportView extends StatelessWidget {
  const ReportView({super.key});

  @override
  Widget build(BuildContext context) {
    DateTime startDate = DateTime.now().subtract(const Duration(days: 1)),
        endDate = DateTime.now();
    var startDateString = startDate.toString().split(" ").first.obs;
    var endDateString = endDate.toString().split(" ").first.obs;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: BlocListener<ReportCubit, ReportState>(
        listener: (context, state) {
          if (state is ReportFetchLoading) {
            showLoadingDialog();
          } else if (state is ReportFetchSuccess) {
            Get.until((route) => !Get.isDialogOpen!);
            showSnackBar(
                "Report exported Successfully".tr, SnackBarMessageType.success);
          } else if (state is ReportFetchNetworkFailure) {
            Get.until((route) => !Get.isDialogOpen!);
            showSnackBar(state.errorMessage, SnackBarMessageType.error);
          } else if (state is ReportFetchFailure) {
            Get.until((route) => !Get.isDialogOpen!);
            showSnackBar(state.errorMessage, SnackBarMessageType.error);
          }
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Export Report as PDF".tr,
              style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 55,
                      child: Center(
                        child: Text(
                          "Start Date".tr,
                          style: const TextStyle(
                              fontSize: 20, color: Colors.black),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 55,
                      child: Center(
                        child: Text(
                          "End Date".tr,
                          style: const TextStyle(
                              fontSize: 20, color: Colors.black),
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          onPressed: () async {
                            final DateTime? picked = await showDatePicker(
                              context: context,
                              initialDate: startDate,
                              firstDate: DateTime(2023),
                              lastDate: DateTime.now()
                                  .subtract(const Duration(days: 1)),
                            );
                            if (picked != null && picked != startDate) {
                              startDate = picked;
                              startDateString.value =
                                  startDate.toString().split(" ").first;
                            }
                          },
                          icon: const Icon(
                            Icons.date_range,
                            size: 40,
                            color: AppColors.primaryColor,
                          ),
                        ),
                        Obx(
                          () => Text(
                            startDateString.string,
                            style: const TextStyle(
                                fontSize: 20, color: Colors.grey),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () async {
                            final DateTime? picked = await showDatePicker(
                              context: context,
                              initialDate:
                                  startDate.add(const Duration(days: 1)),
                              firstDate: startDate.add(const Duration(days: 1)),
                              lastDate: DateTime.now(),
                            );
                            if (picked != null && picked != endDate) {
                              endDate = picked;
                              endDateString.value =
                                  endDate.toString().split(" ").first;
                            }
                          },
                          icon: const Icon(
                            Icons.date_range,
                            size: 40,
                            color: AppColors.primaryColor,
                          ),
                        ),
                        Obx(
                          () => Text(
                            endDateString.string,
                            style: const TextStyle(
                                fontSize: 20, color: Colors.grey),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 70,
              width: 150,
              child: MaterialButton(
                onPressed: () async {
                  // ignore: use_build_context_synchronously
                  BlocProvider.of<ReportCubit>(context)
                      .getReport(startDate: startDate, endDate: endDate);
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                  side: const BorderSide(color: AppColors.primaryColor),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.ios_share,
                      size: 40,
                      color: AppColors.primaryColor,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Export".tr,
                      style: const TextStyle(fontSize: 20),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
