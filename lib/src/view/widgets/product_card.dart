import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmacy_warehouse_store_mobile/core/assets/app_products_images.dart';
import 'package:pharmacy_warehouse_store_mobile/src/model/product.dart';
import 'package:pharmacy_warehouse_store_mobile/src/view/screens/product_details_screen.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({super.key, required this.theme, required this.product});

  final ThemeData theme;
  final Product product;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => ProductDetailsScreen(), arguments: product);
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: 180,
            width: 180,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(8), topLeft: Radius.circular(8)),
              color: Colors.grey.shade300,
              image: const DecorationImage(
                image: AssetImage(
                  AppProductsImages.amoxil,
                ),
                fit: BoxFit.fill,
              ),
            ),
          ),
          Container(
            height: 50,
            width: 180,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                  bottomRight: Radius.circular(8),
                  bottomLeft: Radius.circular(8)),
              color: theme.primaryColor,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      product.name,
                      style: theme.textTheme.bodyMedium!
                          .copyWith(color: Colors.white),
                    ),
                    Text(
                      product.scientificName,
                      style: theme.textTheme.bodySmall!
                          .copyWith(color: Colors.white),
                    ),
                  ],
                ),
                Text(
                  "${product.price.toString()} ${"SP".tr}",
                  style: theme.textTheme.bodyMedium!
                      .copyWith(color: Colors.blueGrey.shade900),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
