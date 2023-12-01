import 'package:flutter_bloc/flutter_bloc.dart';

part 'bottom_nav_bar_state.dart';

class BottomNavBarCubit extends Cubit<BottomNavBarState> {
  BottomNavBarCubit() : super(BottomNavBarInitial());
  int index = 0;
  void navigate({required int index}) {
    this.index = index;
    emit(PageNavigation());
  }
}
