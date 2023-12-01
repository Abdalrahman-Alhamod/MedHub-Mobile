import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmacy_warehouse_store_mobile/core/assets/app_images.dart';
import 'package:pharmacy_warehouse_store_mobile/core/data/app_data.dart';
import 'package:pharmacy_warehouse_store_mobile/src/view/widgets/custome_text_field.dart';
import 'package:pharmacy_warehouse_store_mobile/src/view/widgets/product_card.dart';

class ProductsListScreen extends StatelessWidget {
  const ProductsListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
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
                onChanged: (value) {},
                validator: null,
                keyboardType: TextInputType.text,
                prefixIcon: Icons.search,
                onTap: () {},
                isClearable: true,
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
      child: ListView.builder(
        itemCount: 10,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: ProductCard(
              product: AppData.products[0],
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
    var theme = context.theme;
    return SizedBox(
      height: 60,
      width: double.infinity,
      child: ListView.builder(
        itemCount: AppData.categories.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Container(
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
                  child: Text(AppData.categories[index].name,
                      style: theme.textTheme.titleMedium!.copyWith(
                          color: const Color.fromARGB(255, 34, 77, 112)))),
            ),
          );
        },
      ),
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
