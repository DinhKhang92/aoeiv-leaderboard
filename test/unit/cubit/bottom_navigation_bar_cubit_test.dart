import 'package:aoeiv_leaderboard/cubit/bottom_navigation_bar_cubit.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("BottomNavigationBarCubit", () {
    BottomNavigationBarCubit _bottomNavigationBarCubit = BottomNavigationBarCubit();

    setUp(() {
      _bottomNavigationBarCubit = BottomNavigationBarCubit();
    });

    test('initial index is set to 0', () {
      expect(_bottomNavigationBarCubit.state, 0);
    });

    blocTest<BottomNavigationBarCubit, int>(
      'emits BottomNavigationBarState with index of 2 when setting it',
      build: () => _bottomNavigationBarCubit,
      act: (cubit) => cubit.setIndex(2),
      expect: () => [2],
    );
  });
}
