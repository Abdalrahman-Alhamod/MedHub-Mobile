import 'package:flutter/material.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:get/get.dart';
import 'package:pharmacy_warehouse_store_mobile/core/constants/app_colors.dart';
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
  final PageController _pageController = PageController();

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
          onPressed: () {},
          icon: Icon(
            Icons.menu,
            size: 32,
            color: Colors.lime.shade700,
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
        child: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() => _index = index);
          },
          children: HomeScreen.screen,
        ),
      ),
      bottomNavigationBar: BottomNavyBar(
        selectedIndex: _index,
        onItemSelected: (index) {
          setState(() {
            _index = index;
            _pageController.animateToPage(
              index,
              duration: const Duration(milliseconds: 300),
              curve: Curves.ease,
            );
          });
        },
        items: <BottomNavyBarItem>[
          BottomNavyBarItem(
            title: Text("favourite".tr),
            icon: const Icon(Icons.favorite),
            activeColor: Colors.red,
          ),
          BottomNavyBarItem(
            title: Text("search".tr),
            icon: const Icon(Icons.search),
            activeColor: Colors.green,
          ),
          BottomNavyBarItem(
            title: Text("home".tr),
            icon: const Icon(Icons.home),
            activeColor: AppColors.primaryColor,
          ),
          BottomNavyBarItem(
            title: Text("cart".tr),
            icon: const Icon(Icons.shopping_cart),
            activeColor: Colors.pink,
          ),
          BottomNavyBarItem(
            title: Text("orders".tr),
            icon: const Icon(Icons.receipt),
            activeColor: Colors.purple,
          ),
        ],
      ),
    );
  }
}
