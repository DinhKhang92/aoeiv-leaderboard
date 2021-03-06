// Mocks generated by Mockito 5.0.17 from annotations
// in aoeiv_leaderboard/test/unit/cubit/match_history_data_cubit_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i4;

import 'package:aoeiv_leaderboard/models/match.dart' as _i5;
import 'package:aoeiv_leaderboard/providers/match_history_data_provider.dart'
    as _i2;
import 'package:aoeiv_leaderboard/repositories/match_history_data_repository.dart'
    as _i3;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

class _FakeMatchHistoryDataProvider_0 extends _i1.Fake
    implements _i2.MatchHistoryDataProvider {}

/// A class which mocks [MatchHistoryDataRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockMatchHistoryDataRepository extends _i1.Mock
    implements _i3.MatchHistoryDataRepository {
  MockMatchHistoryDataRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.MatchHistoryDataProvider get matchHistoryDataProvider =>
      (super.noSuchMethod(Invocation.getter(#matchHistoryDataProvider),
              returnValue: _FakeMatchHistoryDataProvider_0())
          as _i2.MatchHistoryDataProvider);
  @override
  _i4.Future<List<_i5.Match>> fetchMatchHistoryData(int? profileId) => (super
          .noSuchMethod(Invocation.method(#fetchMatchHistoryData, [profileId]),
              returnValue: Future<List<_i5.Match>>.value(<_i5.Match>[]))
      as _i4.Future<List<_i5.Match>>);
  @override
  List<_i5.Match> filterMatches(int? leaderboardId, List<_i5.Match>? matches) =>
      (super.noSuchMethod(
          Invocation.method(#filterMatches, [leaderboardId, matches]),
          returnValue: <_i5.Match>[]) as List<_i5.Match>);
  @override
  Map<String, int> getCivDistributionByProfileId(
          List<_i5.Match>? matches, int? profileId) =>
      (super.noSuchMethod(
          Invocation.method(
              #getCivDistributionByProfileId, [matches, profileId]),
          returnValue: <String, int>{}) as Map<String, int>);
}
