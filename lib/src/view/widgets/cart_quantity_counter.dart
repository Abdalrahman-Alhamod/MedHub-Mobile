import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:pharmacy_warehouse_store_mobile/src/Cubits/Cart/cart_cubit.dart';
import 'package:pharmacy_warehouse_store_mobile/src/model/product.dart';

class CartQuantityCounter extends StatelessWidget {
  const CartQuantityCounter({super.key, required this.product});
  final Product product;

  @override
  Widget build(BuildContext context) {
    var theme = context.theme;
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              height: 40,
              width: 40,
              child: IconButton(
                padding: const EdgeInsets.all(0.0),
                onPressed: () {
                  BlocProvider.of<CartCubit>(context)
                      .decreaseProductAmount(product: product);
                },
                icon: const Icon(
                  Icons.remove,
                  color: Colors.red,
                  size: 40,
                ),
                style: IconButton.styleFrom(
                  backgroundColor: Colors.white,
                  shadowColor: Colors.grey,
                  elevation: 5,
                ),
              ),
            ),
            Text(
              product.quantity.toString(),
              style: theme.textTheme.titleLarge!.copyWith(
                fontWeight: FontWeight.bold,
                color: theme.primaryColor,
              ),
              maxLines: 1,
            ),
            SizedBox(
              height: 40,
              width: 40,
              child: IconButton(
                padding: const EdgeInsets.all(0.0),
                onPressed: () {
                  BlocProvider.of<CartCubit>(context)
                      .increaseProductAmount(product: product);
                },
                icon: const Icon(
                  Icons.add,
                  color: Colors.green,
                  size: 40,
                ),
                style: IconButton.styleFrom(
                  backgroundColor: Colors.white,
                  shadowColor: Colors.grey,
                  elevation: 5,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
