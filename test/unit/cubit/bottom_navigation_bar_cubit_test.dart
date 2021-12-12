import 'package:aoeiv_leaderboard/cubit/bottom_navigation_bar_cubit.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("BottomNavigationBarCubit", () {
    BottomNavigationBarCubit _bottomNavigationBarCubit = BottomNavigationBarCubit();

    setUp(() {
      _bottomNavigationBarCubit = BottomNavigationBarCubit();
    });

    test('emits index 0 after initializing', () {
      expect(_bottomNavigationBarCubit.state, 0);
    });

    blocTest<BottomNavigationBarCubit, int>(
      'emits index of 2 after setting it',
      build: () => _bottomNavigationBarCubit,
      act: (cubit) => cubit.setIndex(2),
      expect: () => [2],
    );
  });
}
