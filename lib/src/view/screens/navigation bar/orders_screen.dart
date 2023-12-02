import 'package:flutter/material.dart';
import 'package:pharmacy_warehouse_store_mobile/core/assets/app_images.dart';
import 'package:pharmacy_warehouse_store_mobile/src/view/widgets/show_image.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: ShowImage(
          imagePath: AppImages.emptyOrders,
          height: 600,
          width: 600,
        ),
      ),
    );
  }
}
