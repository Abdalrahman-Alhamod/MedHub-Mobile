import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:pharmacy_warehouse_store_mobile/src/Cubits/Products/products_cubit.dart';

void showSearchByDialog() {
  Get.dialog(
    Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(16.0),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10.0,
              offset: Offset(0.0, 10.0),
            ),
          ],
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                "searchBy".tr,
                style: const TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 24.0),
              buildLanguageRadio(SearchConstraints.name, "name".tr),
              const SizedBox(height: 16.0),
              buildLanguageRadio(
                  SearchConstraints.scientificName, "scientificName".tr),
              const SizedBox(height: 16.0),
              buildLanguageRadio(
                  SearchConstraints.description, "description".tr),
              const SizedBox(height: 16.0),
              buildLanguageRadio(SearchConstraints.brand, "brand".tr),
              const SizedBox(height: 16.0),
            ],
          ),
        ),
      ),
    ),
    barrierDismissible: true,
  );
}

Widget buildLanguageRadio(String constraints, String label) {
  String currentConstraints =
      BlocProvider.of<ProductsCubit>(Get.context!).searchByConstraints;
  bool isSelected = currentConstraints == constraints;

  return RadioListTile(
    title: Text(
      label,
      style: Get.theme.textTheme.titleLarge,
    ),
    value: isSelected,
    groupValue: true,
    onChanged: (value) {
      BlocProvider.of<ProductsCubit>(Get.context!).searchByConstraints =
          constraints;
      Get.back();
    },
    fillColor: MaterialStateProperty.all(Colors.lightBlueAccent),
  );
}
