import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:pharmacy_warehouse_store_mobile/core/assets/app_images.dart';
import 'package:pharmacy_warehouse_store_mobile/core/assets/app_vectors.dart';
import 'package:pharmacy_warehouse_store_mobile/core/constants/app_colors.dart';
import 'package:pharmacy_warehouse_store_mobile/src/Cubits/Auth/Logout/logout_cubit.dart';
import 'package:pharmacy_warehouse_store_mobile/src/Cubits/User/user_cubit.dart';
import 'package:pharmacy_warehouse_store_mobile/src/model/user.dart';
import 'package:pharmacy_warehouse_store_mobile/src/view/helpers/select_lang_dialog.dart';
import 'package:pharmacy_warehouse_store_mobile/src/view/helpers/show_loading_dialog.dart';
import 'package:pharmacy_warehouse_store_mobile/src/view/helpers/show_snack_bar.dart';
import 'package:pharmacy_warehouse_store_mobile/src/view/screens/auth/login_screen.dart';
import 'package:pharmacy_warehouse_store_mobile/src/view/screens/drawer/statistics_screen.dart';
import 'package:pharmacy_warehouse_store_mobile/src/view/screens/navigation%20bar/home_screen.dart';
import 'package:pharmacy_warehouse_store_mobile/src/view/widgets/custome_icon_button.dart';
import 'package:pharmacy_warehouse_store_mobile/src/view/widgets/show_image.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<UserCubit>(context).getUser();
    return Scaffold(
      body: BlocListener<LogoutCubit, LogoutState>(
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
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                  AppImages.startWallpaper), // Replace with your image asset
              fit: BoxFit.cover,
            ),
          ),
          height: double.infinity,
          width: double.infinity,
          child: SafeArea(
            child: Stack(
              children: [
                const _AppBar(),
                BlocConsumer<UserCubit, UserState>(
                  listener: (context, state) {
                    if (state is UserFetchFailure) {
                      showSnackBar(
                          state.errorMessage, SnackBarMessageType.error);
                    } else if (state is UserNetworkFailure) {
                      showSnackBar(
                          state.errorMessage, SnackBarMessageType.error);
                    }
                  },
                  builder: (context, state) {
                    if (state is UserFetchSuccess) {
                      User user = state.user;
                      return _ProfileSuccessView(
                        user: user,
                      );
                    } else if (state is UserFetchLoading) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: AppColors.primaryColor,
                        ),
                      );
                    } else if (state is UserFetchFailure) {
                      return const Center(
                        child: ShowImage(
                          imagePath: AppImages.error,
                          height: 500,
                          width: 500,
                        ),
                      );
                    } else if (state is UserNetworkFailure) {
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ProfileSuccessView extends StatelessWidget {
  const _ProfileSuccessView({required this.user});
  final User user;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _UserDetails(
          user: user,
        ),
        const SizedBox(
          height: 80,
        ),
        _ProfileOptionsListTile(
          title: "statistics".tr,
          icon: Icons.assessment,
          onTap: () {
            Get.to(() => const StatisticsScreen());
          },
        ),
        const SizedBox(
          height: 20,
        ),
        _ProfileOptionsListTile(
          title: "language".tr,
          icon: Icons.language,
          onTap: () {
            showSelectLangDialog();
          },
        ),
        const SizedBox(
          height: 20,
        ),
        _ProfileOptionsListTile(
          title: "logout".tr,
          icon: Icons.logout,
          onTap: () {
            BlocProvider.of<LogoutCubit>(context).logout();
          },
        ),
      ],
    );
  }
}

class _UserDetails extends StatelessWidget {
  const _UserDetails({required this.user});
  final User user;
  @override
  Widget build(BuildContext context) {
    var theme = context.theme;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const CircleAvatar(
          backgroundColor: Colors.lightBlueAccent,
          radius: 100,
          //backgroundImage: AssetImage(AppImages.emptyCart),
          child: Icon(
            Icons.account_circle,
            size: 200,
            color: Colors.white,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Text(
          user.name,
          style: theme.textTheme.headlineLarge,
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.storefront,
              size: 50,
              color: Colors.lightBlueAccent,
            ),
            const SizedBox(
              width: 20,
            ),
            Text(
              user.pharmacyName,
              style: theme.textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              width: 20,
            ),
            const Icon(
              Icons.storefront,
              size: 50,
              color: Colors.lightBlueAccent,
            ),
          ],
        ),
      ],
    );
  }
}

class _ProfileOptionsListTile extends StatelessWidget {
  const _ProfileOptionsListTile(
      {required this.title, required this.icon, required this.onTap});

  final IconData icon;
  final String title;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    var theme = context.theme;
    return SizedBox(
      width: 350,
      child: ListTile(
          leading: Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: Colors.lightBlueAccent,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Icon(
              icon,
              size: 40,
              color: Colors.white,
            ),
          ),
          title: SizedBox(
            child: Text(
              title,
              style: theme.textTheme.headlineLarge,
            ),
          ),
          subtitle:
              const SizedBox.shrink(), // No subtitle, you can customize this
          onTap: onTap),
    );
  }
}

class _AppBar extends StatelessWidget {
  const _AppBar();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Row(
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
            backgroundColor: Colors.lightBlueAccent,
          ),
        ],
      ),
    );
  }
}
