import 'package:flutter/material.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:pharmacy_warehouse_store_mobile/core/constants/app_colors.dart';
import 'package:pharmacy_warehouse_store_mobile/src/Cubits/BottomNavBar/bottom_nav_bar_cubit.dart';
import 'package:pharmacy_warehouse_store_mobile/src/view/screens/drawer/profile_screen.dart';
import 'package:pharmacy_warehouse_store_mobile/src/view/screens/navigation bar/cart_screen.dart';
import 'package:pharmacy_warehouse_store_mobile/src/view/screens/navigation bar/favourite_screen.dart';
import 'package:pharmacy_warehouse_store_mobile/src/view/screens/navigation bar/orders_screen.dart';
import 'package:pharmacy_warehouse_store_mobile/src/view/screens/navigation bar/products_list_screen.dart';
import 'package:pharmacy_warehouse_store_mobile/src/view/screens/navigation bar/search_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static const List<Widget> screen = [
    FavouriteScreen(),
    SearchScreen(),
    ProductsListScreen(),
    CartScreen(),
    OrdersScreen(),
  ];

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomNavBarCubit, BottomNavBarState>(
      builder: (context, state) {
        return Scaffold(
          appBar: const _HomeAppBar(),
          body: SizedBox.expand(
            child: HomeScreen
                .screen[BlocProvider.of<BottomNavBarCubit>(context).index],
          ),
          bottomNavigationBar: BottomNavyBar(
            backgroundColor: Colors.white,
            selectedIndex: BlocProvider.of<BottomNavBarCubit>(context).index,
            containerHeight: 70,
            onItemSelected: (index) {
              BlocProvider.of<BottomNavBarCubit>(context)
                  .navigate(index: index);
            },
            items: <BottomNavyBarItem>[
              BottomNavyBarItem(
                title: Text("favourite".tr),
                icon: const Icon(
                  Icons.favorite,
                  size: 32,
                ),
                activeColor: AppColors.primaryColor,
                inactiveColor: Colors.grey,
              ),
              BottomNavyBarItem(
                title: Text("search".tr),
                icon: const Icon(
                  Icons.search,
                  size: 32,
                ),
                activeColor: AppColors.primaryColor,
                inactiveColor: Colors.grey,
              ),
              BottomNavyBarItem(
                title: Text("home".tr),
                icon: const Icon(
                  Icons.home,
                  size: 32,
                ),
                activeColor: AppColors.primaryColor,
                inactiveColor: Colors.grey,
              ),
              BottomNavyBarItem(
                title: Text(
                  "cart".tr,
                ),
                icon: const Icon(
                  Icons.shopping_cart,
                  size: 32,
                ),
                activeColor: AppColors.primaryColor,
                inactiveColor: Colors.grey,
              ),
              BottomNavyBarItem(
                title: Text("orders".tr),
                icon: const Icon(
                  Icons.receipt,
                  size: 32,
                ),
                activeColor: AppColors.primaryColor,
                inactiveColor: Colors.grey,
              ),
            ],
          ),
        );
      },
    );
  }
}

class _HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const _HomeAppBar();

  @override
  Size get preferredSize => const Size.fromHeight(56.0);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      title: const Text(
        'MedHub',
        style: TextStyle(
          color: AppColors.primaryColor,
          fontWeight: FontWeight.bold,
          fontSize: 24,
        ),
      ),
      actions: [
        IconButton(
          onPressed: () async {
            Get.off(() => const ProfileScreen());
          },
          icon: const Icon(
            Icons.account_circle,
            size: 40,
            color: AppColors.primaryColor,
          ),
        ),
      ],
    );
  }
}
