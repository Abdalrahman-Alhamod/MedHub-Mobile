import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:pharmacy_warehouse_store_mobile/core/assets/app_images.dart';
import 'package:pharmacy_warehouse_store_mobile/src/Cubits/Cart/cart_cubit.dart';
import 'package:pharmacy_warehouse_store_mobile/src/model/product.dart';
import 'package:pharmacy_warehouse_store_mobile/src/view/helpers/show_custome_dialog.dart';
import 'package:pharmacy_warehouse_store_mobile/src/view/helpers/show_loading_dialog.dart';
import 'package:pharmacy_warehouse_store_mobile/src/view/helpers/show_snack_bar.dart';
import 'package:pharmacy_warehouse_store_mobile/src/view/widgets/custome_button.dart';
import 'package:pharmacy_warehouse_store_mobile/src/view/widgets/product_list_tile.dart';
import 'package:pharmacy_warehouse_store_mobile/src/view/widgets/show_image.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CartCubit, CartState>(
      listener: (context, state) {
        if (state is CartPurchaseLoading) {
          Get.until((route) => !Get.isBottomSheetOpen!);
          showLoadingDialog();
        } else if (state is CartPurchaseSuccess) {
          Get.until((route) => !Get.isDialogOpen!);
          showSnackBar("purchaseSuccessful".tr, SnackBarMessageType.success);
        } else if (state is CartPurchaseFailure) {
          Get.until((route) => !Get.isDialogOpen!);
          showSnackBar(state.errorMessage, SnackBarMessageType.error);
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: BlocProvider.of<CartCubit>(context).cartProducts.isEmpty
              ? const Center(
                  child: ShowImage(
                    imagePath: AppImages.emptyCart,
                    height: 500,
                    width: 500,
                  ),
                )
              : const _CartProductsView(),
          bottomNavigationBar:
              BlocProvider.of<CartCubit>(context).cartProducts.isEmpty
                  ? null
                  : const _BottomPriceAndPurchaseBar(),
        );
      },
    );
  }
}

class _CartProductsView extends StatelessWidget {
  const _CartProductsView();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        List<Product> products =
            BlocProvider.of<CartCubit>(context).cartProducts;
        return Padding(
          padding: const EdgeInsets.only(top: 8, right: 16, left: 16),
          child: ListView.builder(
            itemCount: products.length,
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            //physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
                child: ProductListTile(
                  product: products[index],
                  isCartProduct: true,
                ),
              );
            },
          ),
        );
      },
    );
  }
}

class _BottomPriceAndPurchaseBar extends StatelessWidget {
  const _BottomPriceAndPurchaseBar();

  @override
  Widget build(BuildContext context) {
    var theme = context.theme;
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        int totalPrice = BlocProvider.of<CartCubit>(context).totalPrice;
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                offset: Offset(0, -2),
                blurRadius: 25,
                spreadRadius: 5,
              ),
            ],
          ),
          height: 125,
          child: Padding(
            padding: const EdgeInsets.only(right: 16, left: 16),
            child: Column(
              children: [
                SizedBox(
                  width: 450,
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        "totalPrice".tr,
                        style: theme.textTheme.titleLarge,
                      ),
                      Text(
                        "$totalPrice ${"SP".tr}",
                        style: theme.textTheme.titleLarge!
                            .copyWith(color: Colors.green),
                      ),
                    ],
                  ),
                ),
                CustomeButton(
                  title: "purchase".tr,
                  onTap: () async {
                    showCustomeDialog(
                      title: "confirmPurchase".tr,
                      content:
                          "${"youOrderTotalPriceIs".tr} $totalPrice ${"SP".tr}",
                      onConfirm: () async {
                        await BlocProvider.of<CartCubit>(context)
                            .purchaseCart();
                      },
                    );
                  },
                  width: 450,
                  height: 65,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
