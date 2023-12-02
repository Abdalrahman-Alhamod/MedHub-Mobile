import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:pharmacy_warehouse_store_mobile/core/assets/app_images.dart';
import 'package:pharmacy_warehouse_store_mobile/core/constants/app_colors.dart';
import 'package:pharmacy_warehouse_store_mobile/core/data/app_data.dart';
import 'package:pharmacy_warehouse_store_mobile/src/Cubits/BottomNavBarCubit/bottom_nav_bar_cubit.dart';
import 'package:pharmacy_warehouse_store_mobile/src/Cubits/CategoryCubit/category_cubit.dart';
import 'package:pharmacy_warehouse_store_mobile/src/Cubits/ProductsCubit/products_cubit.dart';
import 'package:pharmacy_warehouse_store_mobile/src/model/category.dart';
import 'package:pharmacy_warehouse_store_mobile/src/view/helpers/show_snack_bar.dart';
import 'package:pharmacy_warehouse_store_mobile/src/view/widgets/custome_text_field.dart';
import 'package:pharmacy_warehouse_store_mobile/src/view/widgets/product_card.dart';
import 'package:pharmacy_warehouse_store_mobile/src/view/widgets/show_image.dart';

class ProductsListScreen extends StatelessWidget {
  const ProductsListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    BlocProvider.of<ProductsCubit>(context).getMostPopular();
    BlocProvider.of<CategoryCubit>(context).getCategories();
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 8, right: 16, left: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomeTextField(
                obscureText: false,
                hintText: "searchFor".tr,
                onChanged: (value) {
                  BlocProvider.of<ProductsCubit>(context).searchBarContent =
                      value;
                },
                onSubmit: (value) {
                  BlocProvider.of<BottomNavBarCubit>(context)
                      .navigate(index: 1);
                  BlocProvider.of<ProductsCubit>(context).search();
                },
                validator: null,
                keyboardType: TextInputType.text,
                prefixIcon: Icons.search,
                onTap: () {
                  BlocProvider.of<BottomNavBarCubit>(context)
                      .navigate(index: 1);
                  BlocProvider.of<ProductsCubit>(context).search();
                },
                isSearchBar: true,
              ),
              const SizedBox(
                height: 20,
              ),
              const _AdsView(),
              const SizedBox(
                height: 10,
              ),
              Text(
                "categories".tr,
                style: theme.textTheme.titleLarge,
              ),
              const SizedBox(
                height: 10,
              ),
              const _CategoriesCardsView(),
              const SizedBox(
                height: 10,
              ),
              Text(
                "mostPopular".tr,
                style: theme.textTheme.titleLarge,
              ),
              const SizedBox(
                height: 10,
              ),
              const _ProductCardsView(),
              const SizedBox(
                height: 10,
              ),
              Text(
                "recentlyAdd".tr,
                style: theme.textTheme.titleLarge,
              ),
              const SizedBox(
                height: 10,
              ),
              const _ProductCardsView(),
            ],
          ),
        ),
      ),
    );
  }
}

class _ProductCardsView extends StatelessWidget {
  const _ProductCardsView();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 230,
      width: double.infinity,
      child: BlocConsumer<ProductsCubit, ProductsState>(
        listener: (context, state) {
          if (state is ProductsFetchFailure) {
            showSnackBar(state.errorMessage, SnackBarMessageType.error);
          } else if (state is ProductNetworkFailure) {
            showSnackBar(state.errorMessage, SnackBarMessageType.error);
          }
        },
        builder: (context, state) {
          if (state is ProductsFetchSuccess) {
            final products = state.products;
            return ListView.builder(
              itemCount: products.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: ProductCard(
                    product: products[index],
                  ),
                );
              },
            );
          } else if (state is ProductsFetchFailure) {
            return const ShowImage(
              imagePath: AppImages.error,
              height: 200,
              width: 200,
            );
          } else if (state is ProductNetworkFailure) {
            return const ShowImage(
              imagePath: AppImages.error404,
              height: 200,
              width: 200,
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

class _CategoriesCardsView extends StatelessWidget {
  const _CategoriesCardsView();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      width: double.infinity,
      child: BlocConsumer<CategoryCubit, CategoryState>(
        listener: (context, state) {
          if (state is CategoryFetchFailure) {
            showSnackBar(state.errorMessage, SnackBarMessageType.error);
          } else if (state is CategoryNetworkFailure) {
            showSnackBar(state.errorMessage, SnackBarMessageType.error);
          }
        },
        builder: (context, state) {
          if (state is CategoryFetchSuccess) {
            return _CategoriesCardsViewSuccess(categories: state.categories);
          } else if (state is CategoryFetchFailure) {
            return const ShowImage(
              imagePath: AppImages.error,
              height: 200,
              width: 200,
            );
          } else if (state is CategoryNetworkFailure) {
            return const ShowImage(
              imagePath: AppImages.error404,
              height: 200,
              width: 200,
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

class _CategoriesCardsViewSuccess extends StatelessWidget {
  const _CategoriesCardsViewSuccess({required this.categories});
  final List<Category> categories;
  @override
  Widget build(BuildContext context) {
    var theme = context.theme;
    return ListView.builder(
      itemCount: categories.length,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            BlocProvider.of<BottomNavBarCubit>(context).navigate(index: 1);
            BlocProvider.of<ProductsCubit>(context).choosenCategory =
                categories[index];
          },
          child: Container(
            margin: const EdgeInsets.only(right: 8),
            decoration: BoxDecoration(
              color: Colors.blueGrey,
              borderRadius: BorderRadius.circular(8),
              image: const DecorationImage(
                  image: AssetImage(AppImages.categoryWallpaper),
                  fit: BoxFit.cover),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Center(
                  child: Text(categories[index].name,
                      style: theme.textTheme.titleMedium!.copyWith(
                          color: const Color.fromARGB(255, 34, 77, 112)))),
            ),
          ),
        );
      },
    );
  }
}

class _AdsView extends StatelessWidget {
  const _AdsView();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      width: double.infinity,
      child: ListView.builder(
        itemCount: AppImages.ads.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.only(right: 8),
            width: 220,
            decoration: BoxDecoration(
              color: Colors.blueGrey,
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(
                  image: AssetImage(AppImages.ads[index]), fit: BoxFit.cover),
            ),
          );
        },
      ),
    );
  }
}
