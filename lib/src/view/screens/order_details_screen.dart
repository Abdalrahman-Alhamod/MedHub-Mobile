import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:pharmacy_warehouse_store_mobile/core/assets/app_images.dart';
import 'package:pharmacy_warehouse_store_mobile/core/constants/app_colors.dart';
import 'package:pharmacy_warehouse_store_mobile/src/Cubits/Orders/orders_cubit.dart';
import 'package:pharmacy_warehouse_store_mobile/src/model/order.dart';
import 'package:pharmacy_warehouse_store_mobile/src/view/helpers/show_snack_bar.dart';
import 'package:pharmacy_warehouse_store_mobile/src/view/screens/navigation%20bar/home_screen.dart';
import 'package:pharmacy_warehouse_store_mobile/src/view/widgets/product_list_tile.dart';
import 'package:pharmacy_warehouse_store_mobile/src/view/widgets/show_image.dart';

class OrderDetailsScreen extends StatelessWidget {
  const OrderDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<OrdersCubit>(context).getOrder(id: Get.arguments as int);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "orderDetails".tr,
          style: const TextStyle(
              fontWeight: FontWeight.bold, fontSize: 24, color: Colors.white),
        ),
        backgroundColor: Colors.lightBlueAccent,
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Get.off(() => const HomeScreen());
            },
            icon: const Icon(Icons.arrow_back)),
      ),
      body: BlocConsumer<OrdersCubit, OrdersState>(
        listener: (context, state) {
          if (state is OrderFetchFailure) {
            showSnackBar(state.errorMessage, SnackBarMessageType.error);
          } else if (state is OrderNetworkFailure) {
            showSnackBar(state.errorMessage, SnackBarMessageType.error);
          }
        },
        builder: (context, state) {
          if (state is OrderFetchSuccess) {
            Order order = state.order;
            return _OrderProductsSuccessView(order: order);
          } else if (state is OrdersFetchLoading) {
            return const Center(
              child: CircularProgressIndicator(
                color: AppColors.primaryColor,
              ),
            );
          } else if (state is OrderFetchFailure) {
            return const Center(
              child: ShowImage(
                imagePath: AppImages.error,
                height: 500,
                width: 500,
              ),
            );
          } else if (state is OrderNetworkFailure) {
            return const Center(
              child: ShowImage(
                imagePath: AppImages.error404,
                height: 500,
                width: 500,
              ),
            );
          }
          return const Center(
            child: CircularProgressIndicator(
              color: AppColors.primaryColor,
            ),
          );
        },
      ),
    );
  }
}

class _OrderProductsSuccessView extends StatelessWidget {
  const _OrderProductsSuccessView({required this.order});
  final Order order;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, right: 16, left: 16),
      child: ListView.builder(
        itemCount: order.orderedProducts.length,
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        //physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: ProductListTile(
              product: order.orderedProducts[index].product,
              quantity: order.orderedProducts[index].orderedQuantity,
            ),
          );
        },
      ),
    );
  }
}
