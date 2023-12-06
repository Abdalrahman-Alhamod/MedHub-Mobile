import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmacy_warehouse_store_mobile/src/model/product.dart';
import 'package:pharmacy_warehouse_store_mobile/src/view/screens/product_details_screen.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    var theme = context.theme;
    return GestureDetector(
      onTap: () {
        Get.off(() => ProductDetailsScreen(), arguments: product);
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
              image: DecorationImage(
                image: NetworkImage(
                  product.image,
                ),
                fit: BoxFit.fill,
              ),
            ),
          ),
          Container(
            height: 70,
            width: 180,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                  bottomRight: Radius.circular(8),
                  bottomLeft: Radius.circular(8)),
              color: theme.primaryColor,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width: 90,
                      child: AutoSizeText(
                        product.name,
                        style: theme.textTheme.bodyLarge!.copyWith(
                          color: Colors.white,
                          overflow: TextOverflow.ellipsis,
                        ),
                        maxLines: 1,
                        minFontSize: 6,
                      ),
                    ),
                    SizedBox(
                      width: 90,
                      child: AutoSizeText(
                        product.scientificName,
                        style: theme.textTheme.bodyMedium!.copyWith(
                          color: Colors.white,
                          overflow: TextOverflow.ellipsis,
                        ),
                        maxLines: 1,
                        minFontSize: 6,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: 70,
                  child: AutoSizeText(
                    "${product.price.toString()} ${"SP".tr}",
                    style: theme.textTheme.bodyMedium!.copyWith(
                        color: const Color.fromARGB(255, 181, 255, 183)),
                    minFontSize: 8,
                    maxLines: 1,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
