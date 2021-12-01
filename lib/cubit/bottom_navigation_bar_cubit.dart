import 'package:bloc/bloc.dart';

part 'bottom_navigation_bar_state.dart';

class BottomNavigationBarCubit extends Cubit<BottomNavigationBarState> {
  BottomNavigationBarCubit() : super(const BottomNavigationBarState(index: 0));

  void setIndex(int index) => emit(BottomNavigationBarState(index: index));
}
