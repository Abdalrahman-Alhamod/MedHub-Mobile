import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmacy_warehouse_store_mobile/main.dart';

class SimpleBlocObserver implements BlocObserver {
  @override
  void onEvent(Bloc bloc, Object? event) {}

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {}

  @override
  void onChange(BlocBase bloc, Change change) {
    logger.w('change = $change');
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {}

  @override
  void onClose(BlocBase bloc) {
    logger.w('close = $bloc');
  }

  @override
  void onCreate(BlocBase bloc) {
    logger.w('create = $bloc');
  }
}
