// Mocks generated by Mockito 5.0.17 from annotations
// in aoeiv_leaderboard/test/unit/cubit/favorites_cubit_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i5;

import 'package:aoeiv_leaderboard/models/favorite.dart' as _i6;
import 'package:aoeiv_leaderboard/models/player.dart' as _i3;
import 'package:aoeiv_leaderboard/providers/leaderboard_data_provider.dart'
    as _i2;
import 'package:aoeiv_leaderboard/repositories/favorites_data_repository.dart'
    as _i4;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

class _FakeLeaderboardDataProvider_0 extends _i1.Fake
    implements _i2.LeaderboardDataProvider {}

class _FakePlayer_1 extends _i1.Fake implements _i3.Player {}

/// A class which mocks [FavoritesDataRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockFavoritesDataRepository extends _i1.Mock
    implements _i4.FavoritesDataRepository {
  MockFavoritesDataRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.LeaderboardDataProvider get leaderboardDataProvider =>
      (super.noSuchMethod(Invocation.getter(#leaderboardDataProvider),
              returnValue: _FakeLeaderboardDataProvider_0())
          as _i2.LeaderboardDataProvider);
  @override
  _i5.Future<void> initDb() =>
      (super.noSuchMethod(Invocation.method(#initDb, []),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i5.Future<void>);
  @override
  _i5.Future<List<_i6.Favorite>> updateFavorites(
          int? leaderboardId, int? profileId, String? name) =>
      (super.noSuchMethod(
          Invocation.method(#updateFavorites, [leaderboardId, profileId, name]),
          returnValue:
              Future<List<_i6.Favorite>>.value(<_i6.Favorite>[])) as _i5
          .Future<List<_i6.Favorite>>);
  @override
  _i5.Future<List<_i6.Favorite>> loadFavorites() =>
      (super.noSuchMethod(Invocation.method(#loadFavorites, []),
              returnValue: Future<List<_i6.Favorite>>.value(<_i6.Favorite>[]))
          as _i5.Future<List<_i6.Favorite>>);
  @override
  _i5.Future<_i3.Player> fetchLeaderboardDataByProfileId(
          int? leaderboardId, int? profileId) =>
      (super.noSuchMethod(
              Invocation.method(
                  #fetchLeaderboardDataByProfileId, [leaderboardId, profileId]),
              returnValue: Future<_i3.Player>.value(_FakePlayer_1()))
          as _i5.Future<_i3.Player>);
}
