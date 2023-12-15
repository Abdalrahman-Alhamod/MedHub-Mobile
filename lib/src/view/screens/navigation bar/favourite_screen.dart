import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmacy_warehouse_store_mobile/core/assets/app_images.dart';
import 'package:pharmacy_warehouse_store_mobile/core/constants/app_colors.dart';
import 'package:pharmacy_warehouse_store_mobile/src/Cubits/Products/products_cubit.dart';
import 'package:pharmacy_warehouse_store_mobile/src/model/product.dart';
import 'package:pharmacy_warehouse_store_mobile/src/view/helpers/show_snack_bar.dart';
import 'package:pharmacy_warehouse_store_mobile/src/view/widgets/product_card.dart';
import 'package:pharmacy_warehouse_store_mobile/src/view/widgets/show_image.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<ProductsCubit>(context).getFavourites();
    return Scaffold(
      body: BlocConsumer<ProductsCubit, ProductsState>(
        listener: (context, state) {
          if (state is ProductsFetchFailure) {
            showSnackBar(state.errorMessage, SnackBarMessageType.error);
          } else if (state is ProductNetworkFailure) {
            showSnackBar(state.errorMessage, SnackBarMessageType.error);
          }
        },
        builder: (context, state) {
          if (state is ProductsFetchSuccess) {
            var products = state.products;
            return _ProductsSuccessView(products: products);
          } else if (state is ProductsFetchLoading) {
            return const Center(
              child: CircularProgressIndicator(
                color: AppColors.primaryColor,
              ),
            );
          } else if (state is ProductsNotFound) {
            return const Center(
              child: ShowImage(
                imagePath: AppImages.noData,
                height: 500,
                width: 500,
              ),
            );
          } else if (state is ProductsFetchFailure) {
            return const Center(
              child: ShowImage(
                imagePath: AppImages.error,
                height: 500,
                width: 500,
              ),
            );
          } else if (state is ProductNetworkFailure) {
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

class _ProductsSuccessView extends StatelessWidget {
  const _ProductsSuccessView({
    required this.products,
  });

  final List<Product> products;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, right: 16, left: 16),
      child: GridView.builder(
        itemCount: products.length,
        clipBehavior: Clip.none,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // 1
          childAspectRatio: 0.72, // 4
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemBuilder: (context, index) {
          return ProductCard(
            product: products[index],
          );
        },
      ),
    );
  }
}
