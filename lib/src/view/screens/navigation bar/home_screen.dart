import 'package:flutter/material.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:pharmacy_warehouse_store_mobile/core/constants/app_colors.dart';
import 'package:pharmacy_warehouse_store_mobile/src/Cubits/Auth/Logout/logout_cubit.dart';
import 'package:pharmacy_warehouse_store_mobile/src/Cubits/BottomNavBar/bottom_nav_bar_cubit.dart';
import 'package:pharmacy_warehouse_store_mobile/src/Cubits/Orders/orders_cubit.dart';
import 'package:pharmacy_warehouse_store_mobile/src/Locale/local_controller.dart';
import 'package:pharmacy_warehouse_store_mobile/src/view/helpers/show_loading_dialog.dart';
import 'package:pharmacy_warehouse_store_mobile/src/view/helpers/show_snack_bar.dart';
import 'package:pharmacy_warehouse_store_mobile/src/view/screens/auth/login_screen.dart';
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
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomNavBarCubit, BottomNavBarState>(
      builder: (context, state) {
        return Scaffold(
          appBar: const CustomAppBar(),
          body: SizedBox.expand(
            child: HomeScreen
                .screen[BlocProvider.of<BottomNavBarCubit>(context).index],
          ),
          bottomNavigationBar: BottomNavyBar(
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

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({Key? key}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(56.0);

  @override
  Widget build(BuildContext context) {
    return BlocListener<LogoutCubit, LogoutState>(
      listener: (context, state) {
        if (state is LogoutLoading) {
          showLoadingDialog();
        } else if (state is LogoutSuccess) {
          Get.until((route) => !Get.isDialogOpen!);
          showSnackBar("logedOutSuccess".tr, SnackBarMessageType.success);
          Get.off(() => LoginScreen());
        } else if (state is LogoutFailure) {
          Get.until((route) => !Get.isDialogOpen!);
          showSnackBar(state.errorMessage, SnackBarMessageType.error);
        }
      },
      child: AppBar(
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
            BlocProvider.of<LogoutCubit>(context).logout();
          },
          icon: const Icon(
            Icons.logout,
            size: 32,
            color: AppColors.secondaryColor,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              AppLocalController().toggleLang();
              // BlocProvider.of<OrdersCubit>(context).getOrders();
            },
            icon: Icon(
              Icons.translate,
              size: 32,
              color: Colors.grey.shade300,
            ),
          ),
        ],
      ),
    );
  }
}
