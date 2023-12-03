import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmacy_warehouse_store_mobile/src/model/product.dart';
import 'package:pharmacy_warehouse_store_mobile/main.dart';
part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial());
  List<Product> cartProducts = [];
  int totalPrice = 0;

  void addToCart({required Product product, required int quantity}) {
    try {
      emit(CartAddLoading());
      // Product already exist; increase quantity
      for (int i = 0; i < cartProducts.length; i++) {
        if (cartProducts[i].id == product.id) {
          if (cartProducts[i].quantity + quantity <= cartProducts[i].inStock) {
            cartProducts[i].quantity += quantity;
            totalPrice += quantity * product.price;
            emit(CartAddSuccess());
            logger.i("Current cart products :$cartProducts");
          } else {
            throw Exception();
          }
          return;
        }
      }
      // Product do not exist: add it to list
      if (quantity <= product.inStock) {
        product.quantity = quantity;
        cartProducts.add(product);
        totalPrice += product.quantity * product.price;
        emit(CartAddSuccess());
        logger.i("Current cart products :$cartProducts");
      } else {
        throw Exception();
      }
    } catch (e) {
      emit(CartAddFailure());
    }
  }

  void increaseProductAmount({required Product product}) {
    for (int i = 0; i < cartProducts.length; i++) {
      if (cartProducts[i].id == product.id) {
        if (cartProducts[i].quantity + 1 <= cartProducts[i].inStock) {
          cartProducts[i].quantity++;
          totalPrice += product.price;
          emit(CartProductsChange());
          logger.i("Current cart products :$cartProducts");
          return;
        }
      }
    }
  }

  void decreaseProductAmount({required Product product}) {
    for (int i = 0; i < cartProducts.length; i++) {
      if (cartProducts[i].id == product.id) {
        if (cartProducts[i].quantity > 0) {
          cartProducts[i].quantity--;
          if (cartProducts[i].quantity == 0) {
            cartProducts.removeAt(i);
          }
          totalPrice -= product.price;
          emit(CartProductsChange());
          logger.i("Current cart products :$cartProducts");
          return;
        }
      }
    }
  }

  Future<void> purchaseCart() async {
    try {
      emit(CartPurchaseLoading());
      await Future.delayed(const Duration(seconds: 2));
      // Api.request(
      //     url: '/cartPurchase',
      //     body: Product.toListJson(cartProducts),
      //     token: User.token,
      //     methodType: MethodType.post);
      logger.i(Product.toJsonCart(cartProducts));
      emit(CartPurchaseSuccess());
      cartProducts.clear();
    } on DioException catch (e) {
      emit(CartNetworkFailure(errorMessage: e.message.toString()));
    } catch (e) {
      logger.e(e.toString());
      emit(CartPurchaseFailure(errorMessage: e.toString()));
    }
  }
}