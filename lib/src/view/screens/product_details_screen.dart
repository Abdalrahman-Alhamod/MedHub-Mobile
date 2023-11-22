import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pharmacy_warehouse_store_mobile/core/assets/app_images.dart';
import 'package:pharmacy_warehouse_store_mobile/core/assets/app_products_images.dart';
import 'package:pharmacy_warehouse_store_mobile/core/assets/app_vectors.dart';
import 'package:pharmacy_warehouse_store_mobile/core/constants/app_colors.dart';
import 'package:pharmacy_warehouse_store_mobile/core/data/app_data.dart';
import 'package:pharmacy_warehouse_store_mobile/src/view/widgets/custome_button.dart';
import 'package:pharmacy_warehouse_store_mobile/src/view/widgets/custome_card.dart';

import '../../model/product.dart';
import '../widgets/custome_icon_button.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Product product = AppData.products[0];
    final theme = context.theme;
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            SizedBox(
              height: 300.h,
              child: Stack(
                children: [
                  // Container - product background
                  Positioned.fill(
                    child: SvgPicture.asset(
                      AppVector.container,
                      fit: BoxFit.fill,
                      color: Colors.grey.shade300,
                    ),
                  ),

                  // Back button
                  Positioned(
                    top: 24.h,
                    left: 24.w,
                    right: 24.w,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CustomIconButton(
                          onPressed: () {},
                          icon: SvgPicture.asset(
                            AppVector.backArrowIcon,
                            fit: BoxFit.none,
                            matchTextDirection: true,
                            color: Colors.white,
                          ),
                          backgroundColor: AppColors.primaryColor,
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                      top: 30.h,
                      left: 0,
                      right: 0,
                      child: Image.asset(
                        AppProductsImages.amoxil,
                        width: 300.w,
                        height: 275.h,
                      ))
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    20.verticalSpace,
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.w),
                      child: Text(
                        product.name,
                        style: theme.textTheme.displaySmall,
                      ),
                    ),
                    5.verticalSpace,
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.w),
                      child: Text(
                        product.scientificName,
                        style: theme.textTheme.displayMedium,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 50.w),
                  child: Text(
                    r"$" + product.price.toString(),
                    style: theme.textTheme.displaySmall!.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryColor),
                  ),
                ),
              ],
            ),
            10.verticalSpace,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Text(
                product.description,
                style: theme.textTheme.bodyLarge,
              ),
            ),
            10.verticalSpace,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: GridView(
                shrinkWrap: true,
                primary: false,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8.w,
                  mainAxisSpacing: 8.h,
                  mainAxisExtent: 100.h,
                ),
                children: [
                  CustomeCard(
                    title: product.brand,
                    subtitle: "Brand",
                    icon: const Icon(Icons.business,
                        color: Colors.teal), // Example color
                  ),
                  CustomeCard(
                    title: product.expirationDate.toString(),
                    subtitle: "Expiration",
                    icon: const Icon(Icons.date_range,
                        color: Colors.red), // Example color
                  ),
                  CustomeCard(
                    title: product.inStock.toString(),
                    subtitle: "In Stock",
                    icon: const Icon(Icons.warehouse,
                        color: Colors.green), // Example color
                  ),
                  CustomeCard(
                    title: product.type.name.toUpperCase(),
                    subtitle: "Category",
                    icon: const Icon(Icons.category,
                        color: Colors.orange), // Example color
                  ),
                ],
              ),
            ),
            10.verticalSpace,
            Row(
              children: [
                CustomeButton(
                  title: "Add to Cart",
                  onTap: () {},
                  width: 260.w,
                ),
                Container(
                  // padding: EdgeInsets.fromLTRB(16.w, 12.h, 10.w, 12.h),
                  decoration: BoxDecoration(
                    color: theme.scaffoldBackgroundColor,
                    borderRadius: BorderRadius.circular(16.r),
                    border: Border.all(color: theme.dividerColor),
                  ),
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.favorite,
                      color: Colors.red,
                      size: 55,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
