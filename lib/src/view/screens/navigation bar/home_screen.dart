import 'package:flutter/material.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:get/get.dart';
import 'package:pharmacy_warehouse_store_mobile/core/constants/app_colors.dart';
import 'package:pharmacy_warehouse_store_mobile/src/controller/user_controller.dart';
import 'package:pharmacy_warehouse_store_mobile/src/view/screens/navigation bar/cart_screen.dart';
import 'package:pharmacy_warehouse_store_mobile/src/view/screens/navigation bar/favourite_screen.dart';
import 'package:pharmacy_warehouse_store_mobile/src/view/screens/navigation bar/orders_screen.dart';
import 'package:pharmacy_warehouse_store_mobile/src/view/screens/navigation bar/products_list_screen.dart';
import 'package:pharmacy_warehouse_store_mobile/src/view/screens/navigation bar/search_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

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
  int _index = 2;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: const Text(
          'MedHub',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () async {
            UserController().logout();
          },
          icon: const Icon(
            Icons.logout,
            size: 32,
            color: AppColors.secondaryColor,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.notifications,
              size: 32,
              color: Colors.yellow.shade700,
            ),
          ),
        ],
      ),
      body: SizedBox.expand(
        child: HomeScreen.screen[_index],
      ),
      bottomNavigationBar: BottomNavyBar(
        selectedIndex: _index,
        containerHeight: 70,
        onItemSelected: (index) {
          setState(() {
            _index = index;
          });
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
  }
}
