import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pharmacy_warehouse_store_mobile/core/assets/app_vectors.dart';
import 'package:pharmacy_warehouse_store_mobile/core/constants/app_colors.dart';
import 'package:pharmacy_warehouse_store_mobile/src/Cubits/Cart/cart_cubit.dart';
import 'package:pharmacy_warehouse_store_mobile/src/Cubits/Favourite/favourite_cubit.dart';
import 'package:pharmacy_warehouse_store_mobile/src/view/helpers/show_loading_dialog.dart';
import 'package:pharmacy_warehouse_store_mobile/src/view/helpers/show_snack_bar.dart';
import 'package:pharmacy_warehouse_store_mobile/src/view/screens/navigation%20bar/home_screen.dart';
import 'package:pharmacy_warehouse_store_mobile/src/view/widgets/custome_button.dart';
import 'package:pharmacy_warehouse_store_mobile/src/view/widgets/custome_card.dart';

import '../../model/product.dart';
import '../widgets/custome_icon_button.dart';

class ProductDetailsScreen extends StatelessWidget {
  ProductDetailsScreen({super.key});
  final Product product = Get.arguments;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocListener<CartCubit, CartState>(
          listener: (context, state) {
            if (state is CartAddLoading) {
              Get.until((route) => !Get.isBottomSheetOpen!);
              showLoadingDialog();
            } else if (state is CartAddSuccess) {
              Get.until((route) => !Get.isDialogOpen!);
              showSnackBar(
                  "addedToCartSuccessfully".tr, SnackBarMessageType.success);
            } else if (state is CartAddFailure) {
              Get.until((route) => !Get.isDialogOpen!);
              showSnackBar(
                  "failedToAddToTheCart".tr, SnackBarMessageType.error);
            }
          },
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
                        top: 15.h,
                        left: 0,
                        right: 0,
                        child: _ProductImage(
                          product: product,
                        )),
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
                      SizedBox(
                          width: 230, child: _ProductName(product: product)),
                      5.verticalSpace,
                      SizedBox(
                          width: 230,
                          child: _ProductScientificName(product: product)),
                    ],
                  ),
                  Expanded(child: _ProductPrice(product: product)),
                ],
              ),
              10.verticalSpace,
              SizedBox(
                  height: 100, child: _ProductDescription(product: product)),
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
                      title: product.inStock == 0
                          ? "unavailable".tr
                          : product.inStock.toString(),
                      subtitle: "inStock".tr,
                      icon: const Icon(Icons.warehouse,
                          color: Colors.green, size: 30),
                      titleColor: product.inStock == 0
                          ? Colors.red
                          : AppColors.primaryColor, // Example color
                    ),
                    CustomeCard(
                      title: product.category.name,
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
              _Buttons(
                product: product,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _Buttons extends StatelessWidget {
  const _Buttons({required this.product});
  final Product product;
  @override
  Widget build(BuildContext context) {
    var theme = context.theme;
    bool isFav = product.isFavorite;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomeButton(
            title: "addToCart".tr,
            onTap: () {
              Get.bottomSheet(
                _QuantityCounter(
                  product: product,
                ),
                backgroundColor: Colors.transparent,
                isScrollControlled: true,
              );
            },
            width: 260.w,
            height: 70.h,
            isEnabled: product.inStock != 0,
          ),
          Container(
            // padding: EdgeInsets.fromLTRB(16.w, 12.h, 10.w, 12.h),
            decoration: BoxDecoration(
              color: theme.scaffoldBackgroundColor,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: theme.dividerColor),
            ),
            child: BlocConsumer<FavouriteCubit, FavouriteState>(
              listener: (context, state) {
                if (state is FavourateToggleLoading) {
                  showLoadingDialog();
                } else if (state is FavoureteToggleFailure) {
                  if (Get.isDialogOpen!) Get.back();
                  showSnackBar(state.errorMessage, SnackBarMessageType.error);
                } else if (state is FavourateToggleSuccess) {
                  if (Get.isDialogOpen!) Get.back();
                  isFav = !isFav;
                }
              },
              builder: (context, state) => IconButton(
                onPressed: () {
                  BlocProvider.of<FavouriteCubit>(context)
                      .toggleFavourate(product: product);
                  product.isFavorite = !product.isFavorite;
                },
                icon: Icon(
                  Icons.favorite,
                  color: isFav ? Colors.red : Colors.grey,
                  size: 70.h - 15,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _QuantityCounter extends StatefulWidget {
  const _QuantityCounter({required this.product});
  final Product product;

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
        backgroundColor: Colors.white, // Match with scaffold background color
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
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(horizontal: 16),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(
                color: AppColors.primaryColor.withOpacity(.5),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(
                color: AppColors.primaryColor,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(
                color: Colors.red,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(color: Colors.red, width: 2),
            ),
            fillColor: Colors.grey.shade200,
            filled: true,
            floatingLabelStyle: const TextStyle(color: AppColors.primaryColor),
            errorStyle: const TextStyle(color: Colors.red),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Get.back(result: null);
            },
            child: Text(
              "cancel".tr,
              style: Get.theme.textTheme.labelLarge!.copyWith(
                color: Colors.red, // Match with primary color
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
                color: AppColors.primaryColor, // Match with primary color
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
    var theme = context.theme;
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                "quantity".tr,
                style: theme.textTheme.titleLarge,
                textAlign: TextAlign.center,
              ),
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
                      icon: const Icon(
                        Icons.remove,
                        color: Colors.red,
                      ),
                      color: theme.primaryColor,
                      style: IconButton.styleFrom(
                        backgroundColor: Colors.white,
                        shadowColor: Colors.grey,
                        elevation: 5,
                      ),
                    ),
                    const SizedBox(width: 20),
                    Text(
                      quantity.toString(),
                      style: theme.textTheme.titleLarge!.copyWith(
                        fontWeight: FontWeight.bold,
                        color: theme.primaryColor,
                      ),
                    ),
                    const SizedBox(width: 20),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          quantity++;
                        });
                      },
                      icon: const Icon(
                        Icons.add,
                        color: Colors.green,
                      ),
                      color: theme.primaryColor,
                      style: IconButton.styleFrom(
                        backgroundColor: Colors.white,
                        shadowColor: Colors.grey,
                        elevation: 5,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          CustomeButton(
            title: "add".tr,
            onTap: () {
              if (_quantity > 0) {
                BlocProvider.of<CartCubit>(context)
                    .addToCart(product: widget.product, quantity: _quantity);
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
  });

  final Product product;

  @override
  Widget build(BuildContext context) {
    var theme = context.theme;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: AutoSizeText(
        product.description,
        style: theme.textTheme.bodyLarge,
        maxLines: 4,
      ),
    );
  }
}

class _ProductPrice extends StatelessWidget {
  const _ProductPrice({
    required this.product,
  });

  final Product product;

  @override
  Widget build(BuildContext context) {
    var theme = context.theme;
    return Padding(
      padding: EdgeInsets.only(right: 25.w, left: 25.w, top: 20.h),
      child: AutoSizeText(
        "${product.price} ${"SP".tr}",
        style: theme.textTheme.displayLarge!.copyWith(
            fontWeight: FontWeight.bold, color: AppColors.primaryColor),
        maxLines: 1,
      ),
    );
  }
}

class _ProductScientificName extends StatelessWidget {
  const _ProductScientificName({
    required this.product,
  });

  final Product product;

  @override
  Widget build(BuildContext context) {
    var theme = context.theme;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: AutoSizeText(
        product.scientificName,
        style: theme.textTheme.displayMedium,
        maxLines: 1,
      ),
    );
  }
}

class _ProductName extends StatelessWidget {
  const _ProductName({
    required this.product,
  });

  final Product product;

  @override
  Widget build(BuildContext context) {
    var theme = context.theme;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: AutoSizeText(
        product.name,
        style: theme.textTheme.displaySmall,
        maxLines: 1,
      ),
    );
  }
}

class _ProductImage extends StatelessWidget {
  const _ProductImage({required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Image.network(
      product.image,
      width: 250.w,
      height: 250.h,
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
            Get.off(() => const HomeScreen());
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
