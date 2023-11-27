import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pharmacy_warehouse_store_mobile/core/assets/app_products_images.dart';
import 'package:pharmacy_warehouse_store_mobile/core/assets/app_vectors.dart';
import 'package:pharmacy_warehouse_store_mobile/core/constants/app_colors.dart';
import 'package:pharmacy_warehouse_store_mobile/src/view/helpers/show_snack_bar.dart';
import 'package:pharmacy_warehouse_store_mobile/src/view/widgets/custome_button.dart';
import 'package:pharmacy_warehouse_store_mobile/src/view/widgets/custome_card.dart';

import '../../model/product.dart';
import '../widgets/custome_icon_button.dart';

class ProductDetailsScreen extends StatelessWidget {
  ProductDetailsScreen({super.key});
  final Product product = Get.arguments;
  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            SizedBox(
              height: 280.h,
              child: Stack(
                children: [
                  // Container - product background
                  const Positioned.fill(
                    child: _ProductImageBackground(),
                  ),

                  Positioned(
                      top: 20.h,
                      left: 0,
                      right: 0,
                      child: const _ProductImage()),
                  // Back button
                  Positioned(
                    top: 24.h,
                    left: 24.w,
                    right: 24.w,
                    child: const _AppBar(),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    20.verticalSpace,
                    _ProductName(product: product, theme: theme),
                    5.verticalSpace,
                    _ProductScientificName(product: product, theme: theme),
                  ],
                ),
                _ProductPrice(product: product, theme: theme),
              ],
            ),
            10.verticalSpace,
            _ProductDescription(product: product, theme: theme),
            10.verticalSpace,
            //// Product Details Cards
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
                    subtitle: "brand".tr,
                    icon: const Icon(Icons.business,
                        color: Colors.teal, size: 30), // Example color
                  ),
                  CustomeCard(
                    title: product.expirationDate.toString(),
                    subtitle: "expiration".tr,
                    icon: const Icon(Icons.date_range,
                        color: Colors.red, size: 30), // Example color
                  ),
                  CustomeCard(
                    title: product.inStock.toString(),
                    subtitle: "inStock".tr,
                    icon: const Icon(Icons.warehouse,
                        color: Colors.green, size: 30), // Example color
                  ),
                  CustomeCard(
                    title: product.type.toString(),
                    subtitle: "category".tr,
                    icon: Icon(
                      Icons.category,
                      color: Colors.orange,
                      size: 30.h,
                    ), // Example color
                  ),
                ],
              ),
            ),
            10.verticalSpace,
            _Buttons(theme: theme)
          ],
        ),
      ),
    );
  }
}

class _Buttons extends StatefulWidget {
  const _Buttons({
    required this.theme,
  });

  final ThemeData theme;

  @override
  State<_Buttons> createState() => _ButtonsState();
}

class _ButtonsState extends State<_Buttons> {
  bool isFav = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomeButton(
            title: "addToCart".tr,
            onTap: () {
              Get.bottomSheet(
                _QuantityCounter(theme: widget.theme),
                backgroundColor: Colors.transparent,
                isScrollControlled: true,
              );
            },
            width: 260.w,
            height: 70.h,
          ),
          Container(
            // padding: EdgeInsets.fromLTRB(16.w, 12.h, 10.w, 12.h),
            decoration: BoxDecoration(
              color: widget.theme.scaffoldBackgroundColor,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: widget.theme.dividerColor),
            ),
            child: IconButton(
              onPressed: () {
                setState(() {
                  isFav = !isFav;
                });
              },
              icon: Icon(
                Icons.favorite,
                color: isFav ? Colors.red : Colors.grey,
                size: 70.h - 15,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _QuantityCounter extends StatefulWidget {
  const _QuantityCounter({
    required this.theme,
  });

  final ThemeData theme;

  @override
  State<_QuantityCounter> createState() => _QuantityCounterState();
}

class _QuantityCounterState extends State<_QuantityCounter> {
  late int _quantity;

  int get quantity => _quantity;

  set quantity(int newQuantity) {
    if (newQuantity >= 0) {
      setState(() {
        _quantity = newQuantity;
      });
    }
  }

  @override
  void initState() {
    _quantity = 0;
    super.initState();
  }

  Future<void> _showQuantityDialog() async {
    int? newQuantity;

    await Get.dialog<int>(
      AlertDialog(
        backgroundColor: Get.theme
            .scaffoldBackgroundColor, // Match with scaffold background color
        title: Text(
          "enterQuantity".tr,
          style: Get.theme.textTheme.titleLarge,
        ),
        content: TextField(
          keyboardType: TextInputType.number,
          controller: TextEditingController(text: _quantity.toString()),
          onChanged: (String value) {
            if (int.tryParse(value) != null) {
              newQuantity = int.parse(value);
            }
          },
        ),
        actions: [
          TextButton(
            onPressed: () {
              Get.back(result: null);
            },
            child: Text(
              "cancel".tr,
              style: Get.theme.textTheme.labelLarge!.copyWith(
                color: Get.theme.primaryColor, // Match with primary color
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Get.back(result: newQuantity);
            },
            child: Text(
              "confirm".tr,
              style: Get.theme.textTheme.labelLarge!.copyWith(
                color: Get.theme.primaryColor, // Match with primary color
              ),
            ),
          ),
        ],
      ),
    );

    if (newQuantity != null) {
      quantity = newQuantity!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16.0),
          topRight: Radius.circular(16.0),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "quantity".tr,
            style: widget.theme.textTheme.titleLarge,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 30),
          GestureDetector(
            onTap: _showQuantityDialog,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {
                    setState(() {
                      quantity--;
                    });
                  },
                  icon: const Icon(Icons.remove),
                  color: widget.theme.primaryColor,
                ),
                const SizedBox(width: 20),
                Text(
                  quantity.toString(),
                  style: widget.theme.textTheme.titleLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: widget.theme.primaryColor,
                  ),
                ),
                const SizedBox(width: 20),
                IconButton(
                  onPressed: () {
                    setState(() {
                      quantity++;
                    });
                  },
                  icon: const Icon(Icons.add),
                  color: widget.theme.primaryColor,
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          CustomeButton(
            title: "add".tr,
            onTap: () {
              Get.back();
              if (_quantity > 0) {
                showSnackBar(
                    "addedSuccessfully".tr, SnackBarMessageType.success);
              }
            },
            width: double.infinity,
            height: 50.0,
          ),
        ],
      ),
    );
  }
}

class _ProductDescription extends StatelessWidget {
  const _ProductDescription({
    required this.product,
    required this.theme,
  });

  final Product product;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Text(
        product.description,
        style: theme.textTheme.bodyLarge,
      ),
    );
  }
}

class _ProductPrice extends StatelessWidget {
  const _ProductPrice({
    required this.product,
    required this.theme,
  });

  final Product product;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 30.w, left: 30.w, top: 20.h),
      child: Text(
        "${product.price} ${"SP".tr}",
        style: theme.textTheme.displayLarge!.copyWith(
            fontWeight: FontWeight.bold, color: AppColors.primaryColor),
      ),
    );
  }
}

class _ProductScientificName extends StatelessWidget {
  const _ProductScientificName({
    required this.product,
    required this.theme,
  });

  final Product product;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Text(
        product.scientificName,
        style: theme.textTheme.displayMedium,
      ),
    );
  }
}

class _ProductName extends StatelessWidget {
  const _ProductName({
    required this.product,
    required this.theme,
  });

  final Product product;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Text(
        product.name,
        style: theme.textTheme.displaySmall,
      ),
    );
  }
}

class _ProductImage extends StatelessWidget {
  const _ProductImage();

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      AppProductsImages.amoxil,
      width: 300.w,
      height: 275.h,
    );
  }
}

class _AppBar extends StatelessWidget {
  const _AppBar();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        CustomIconButton(
          onPressed: () {
            Get.back();
          },
          icon: SvgPicture.asset(
            AppVector.backArrowIcon,
            fit: BoxFit.none,
            matchTextDirection: true,
            // ignore: deprecated_member_use
            color: Colors.white,
          ),
          backgroundColor: AppColors.primaryColor,
        ),
      ],
    );
  }
}

class _ProductImageBackground extends StatelessWidget {
  const _ProductImageBackground();

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      AppVector.container,
      fit: BoxFit.fill,
      // ignore: deprecated_member_use
      color: Colors.grey.shade300,
    );
  }
}
