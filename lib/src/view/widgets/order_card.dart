import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmacy_warehouse_store_mobile/core/assets/app_images.dart';
import 'package:pharmacy_warehouse_store_mobile/src/model/order.dart';
import 'package:pharmacy_warehouse_store_mobile/src/view/screens/order_details_screen.dart';
import 'package:pharmacy_warehouse_store_mobile/src/view/widgets/show_image.dart';

class OrderCard extends StatelessWidget {
  const OrderCard({super.key, required this.order});
  final Order order;

  @override
  Widget build(BuildContext context) {
    var theme = context.theme;
    return GestureDetector(
      onTap: () {
        Get.off(() => const OrderDetailsScreen(), arguments: order.id);
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(0, 0),
              blurRadius: 10,
              spreadRadius: 1,
            )
          ],
        ),
        height: 250,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _CategorySpecText(
                  content: 'orderID'.tr,
                  imagePath: AppImages.orderID,
                ),
                const SizedBox(
                  height: 20,
                ),
                _CategorySpecText(
                  content: 'totalBill'.tr,
                  imagePath: AppImages.orderBill,
                ),
                const SizedBox(
                  height: 20,
                ),
                _CategorySpecText(
                  content: 'status'.tr,
                  imagePath: AppImages.orderStatus,
                ),
                const SizedBox(
                  height: 20,
                ),
                _CategorySpecText(
                  content: 'date'.tr,
                  imagePath: AppImages.orderDate,
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "#${order.id}",
                  style: theme.textTheme.titleLarge,
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: 140,
                  child: AutoSizeText(
                    "${order.bill} ${"SP".tr}",
                    style: theme.textTheme.titleLarge,
                    textAlign: TextAlign.end,
                    maxLines: 1,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                _OrderStatusText(
                  status: order.status,
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  order.date,
                  style: theme.textTheme.titleLarge,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _OrderStatusText extends StatelessWidget {
  const _OrderStatusText({required this.status});
  final String status;
  @override
  Widget build(BuildContext context) {
    var theme = context.theme;
    Color color = Colors.black;
    OrderStatus orderStatus = OrderStatus();
    if (status == orderStatus.Preparing) {
      color = Colors.orange;
    } else if (status == orderStatus.Delivering) {
      color = Colors.blueGrey;
    } else if (status == orderStatus.Recieved) {
      color = Colors.green;
    } else if (status == orderStatus.Refused) {
      color = Colors.red;
    }
    return Text(
      status,
      style: theme.textTheme.titleLarge!.copyWith(color: color),
    );
  }
}

class _CategorySpecText extends StatelessWidget {
  const _CategorySpecText({required this.content, required this.imagePath});

  final String content;
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    var theme = context.theme;
    return Row(
      children: [
        ShowImage(
          imagePath: imagePath,
          height: 30,
          width: 30,
        ),
        const SizedBox(
          width: 10,
        ),
        Text(
          content,
          style: theme.textTheme.titleLarge!.copyWith(
              fontWeight: FontWeight.bold, color: Colors.grey.shade500),
        ),
      ],
    );
  }
}
