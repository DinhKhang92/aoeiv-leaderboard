// Mocks generated by Mockito 5.0.17 from annotations
// in aoeiv_leaderboard/test/unit/repositories/leaderboard_data_repository_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i3;

import 'package:aoeiv_leaderboard/providers/leaderboard_data_provider.dart'
    as _i2;
import 'package:http/http.dart' as _i4;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

/// A class which mocks [LeaderboardDataProvider].
///
/// See the documentation for Mockito's code generation for more information.
class MockLeaderboardDataProvider extends _i1.Mock
    implements _i2.LeaderboardDataProvider {
  MockLeaderboardDataProvider() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.Future<Map<dynamic, dynamic>> fetchLeaderboardData(
          _i4.Client? client, String? url) =>
      (super.noSuchMethod(
              Invocation.method(#fetchLeaderboardData, [client, url]),
              returnValue:
                  Future<Map<dynamic, dynamic>>.value(<dynamic, dynamic>{}))
          as _i3.Future<Map<dynamic, dynamic>>);
}
