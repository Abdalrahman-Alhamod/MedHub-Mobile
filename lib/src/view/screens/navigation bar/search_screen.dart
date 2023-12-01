import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pharmacy_warehouse_store_mobile/core/assets/app_images.dart';
import 'package:pharmacy_warehouse_store_mobile/core/constants/app_colors.dart';
import 'package:pharmacy_warehouse_store_mobile/core/data/app_data.dart';
import 'package:pharmacy_warehouse_store_mobile/src/Cubits/ProductsCubit/products_cubit.dart';
import 'package:pharmacy_warehouse_store_mobile/src/model/product.dart';
import 'package:pharmacy_warehouse_store_mobile/src/view/helpers/show_snack_bar.dart';
import 'package:pharmacy_warehouse_store_mobile/src/view/widgets/custome_text_field.dart';
import 'package:pharmacy_warehouse_store_mobile/src/view/widgets/product_list_tile.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 8, right: 16, left: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: CustomeTextField(
                      obscureText: false,
                      hintText: "searchFor".tr,
                      onChanged: (value) {
                        BlocProvider.of<ProductsCubit>(context)
                            .searchBarContent = value;
                      },
                      onSubmit: (value) {
                        BlocProvider.of<ProductsCubit>(context).search();
                      },
                      validator: null,
                      keyboardType: TextInputType.text,
                      prefixIcon: Icons.search,
                      onTap: () {
                        BlocProvider.of<ProductsCubit>(context).search();
                      },
                      isClearable: true,
                    ),
                  ),
                  // TODO filter button
                  // IconButton(
                  //   onPressed: () {},
                  //   icon: const Icon(
                  //     Icons.filter_list_outlined,
                  //     size: 35,
                  //   ),
                  // )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              const _CategoriesCardsView(),
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
    return BlocConsumer<ProductsCubit, ProductsState>(
      listener: (context, state) {
        if (state is ProductsFetchFailure) {
          showSnackBar(state.errorMessage, SnackBarMessageType.error);
        } else if (state is NetworkFailure) {
          showSnackBar(state.errorMessage, SnackBarMessageType.error);
        }
      },
      builder: (context, state) {
        if (state is ProductsFetchSuccess) {
          var products = state.products;
          return _ProductsSuccessView(products: products);
        } else if (state is ProductsFetchLoading) {
          return SizedBox(
            height: Get.size.height - 350,
            child: const Center(
              child: CircularProgressIndicator(
                color: AppColors.primaryColor,
              ),
            ),
          );
        } else if (state is ProductsNotFound) {
          return const ShowImage(
            imagePath: AppImages.noData,
          );
        } else if (state is ProductsFetchFailure) {
          return const ShowImage(
            imagePath: AppImages.error,
          );
        } else if (state is NetworkFailure) {
          return const ShowImage(
            imagePath: AppImages.error404,
          );
        }
        return const Center();
      },
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
    return ListView.builder(
      itemCount: products.length,
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 12.0),
          child: ProductListTile(
            product: products[index],
          ),
        );
      },
    );
  }
}

class ShowImage extends StatelessWidget {
  const ShowImage({super.key, required this.imagePath});
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      width: 500,
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage(imagePath), fit: BoxFit.cover),
      ),
    );
  }
}

class _CategoriesCardsView extends StatefulWidget {
  const _CategoriesCardsView();

  @override
  State<_CategoriesCardsView> createState() => _CategoriesCardsViewState();
}

class _CategoriesCardsViewState extends State<_CategoriesCardsView> {
  int selectedIndex = 0;
  @override
  void initState() {
    BlocProvider.of<ProductsCubit>(context).choosenCategory =
        AppData.categories[selectedIndex];
    BlocProvider.of<ProductsCubit>(context).search();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var theme = context.theme;
    return SizedBox(
      height: 60,
      width: double.infinity,
      child: ListView.builder(
        itemCount: AppData.categories.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              setState(
                () {
                  selectedIndex = index;
                  BlocProvider.of<ProductsCubit>(context).choosenCategory =
                      AppData.categories[selectedIndex];
                  BlocProvider.of<ProductsCubit>(context).search();
                },
              );
            },
            child: Container(
              margin: const EdgeInsets.only(right: 8),
              decoration: BoxDecoration(
                color: index == selectedIndex
                    ? AppColors.primaryColor
                    : Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppColors.primaryColor),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Center(
                  child: Text(
                    AppData.categories[index].name,
                    style: theme.textTheme.titleMedium!.copyWith(
                      color: index == selectedIndex
                          ? Colors.white
                          : AppColors.primaryColor,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
