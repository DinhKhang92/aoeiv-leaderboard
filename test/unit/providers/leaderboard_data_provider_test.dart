import 'package:aoeiv_leaderboard/models/player.dart';
import 'package:aoeiv_leaderboard/providers/leaderboard_data_provider.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';

import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'rating_history_data_provider_test.mocks.dart';

@GenerateMocks([Client])
void main() {
  MockClient _mockClient = MockClient();
  final LeaderboardDataProvider _leaderboardDataProvider = LeaderboardDataProvider();

  const String exampleLeaderboardData =
      '{"total":55169,"leaderboard_id":17,"start":1,"count":1,"leaderboard":[{"profile_id":5486218,"rank":1,"rating":1964,"steam_id":"76561198102726188","icon":null,"name":"LucifroN7","clan":null,"country":null,"previous_rating":1956,"highest_rating":1964,"streak":14,"lowest_streak":-2,"highest_streak":14,"games":138,"wins":114,"losses":24,"drops":0,"last_match_time":1639581793}]}';
  const String exampleFoundPlayersData =
      '{"total":55167,"leaderboard_id":17,"start":1,"count":1,"leaderboard":[{"profile_id":5150581,"rank":4774,"rating":1241,"steam_id":"76561197984714726","icon":null,"name":"T0nb3rry","clan":null,"country":null,"previous_rating":null,"highest_rating":1241,"streak":-1,"lowest_streak":-1,"highest_streak":-1,"games":10,"wins":8,"losses":2,"drops":0,"last_match_time":1638145606}]}';
  const String exampleLeaderboardDataByProfileId =
      '{"total":55167,"leaderboard_id":17,"start":1,"count":1,"leaderboard":[{"profile_id":5150581,"rank":4774,"rating":1241,"steam_id":"76561197984714726","icon":null,"name":"T0nb3rry","clan":null,"country":null,"previous_rating":null,"highest_rating":1241,"streak":-1,"lowest_streak":-1,"highest_streak":-1,"games":10,"wins":8,"losses":2,"drops":0,"last_match_time":1638145606}]}';

  setUp(() {
    _mockClient = MockClient();
  });
  group("LeaderboardDataProvider", () {
    group("fetchLeaderboardData", () {
      const String url = "https://aoeiv.net/api/leaderboard?game=aoe4&leaderboard_id=17&start=1&count=1000";
      test("it returns a future list of players if request succeeded", () {
        when(_mockClient.get(Uri.parse(url))).thenAnswer((_) async => Response(exampleLeaderboardData, 200));

        expect(_leaderboardDataProvider.fetchLeaderboardData(_mockClient, 17), isA<Future<List<Player>>>());
      });
      test("it throws an Exception if request failed", () {
        when(_mockClient.get(Uri.parse(url))).thenAnswer((_) async => Response('failed', 500));

        expect(_leaderboardDataProvider.fetchLeaderboardData(_mockClient, 17), throwsException);
      });
    });
    group("searchPlayer", () {
      const String url = "https://aoeiv.net/api/leaderboard?game=aoe4&leaderboard_id=17&search=T0nb3rr&count=1000";
      test("it returns a future list of players if request succeeded", () {
        when(_mockClient.get(Uri.parse(url))).thenAnswer((_) async => Response(exampleFoundPlayersData, 200));

        expect(_leaderboardDataProvider.searchPlayer(_mockClient, 17, "T0nb3rr"), isA<Future<List<Player>>>());
      });
      test("it throws an Exception if request failed", () {
        when(_mockClient.get(Uri.parse(url))).thenAnswer((_) async => Response('failed', 500));

        expect(_leaderboardDataProvider.searchPlayer(_mockClient, 17, "T0nb3rr"), throwsException);
      });
    });
    group("fetchPlayerDataByProfileId", () {
      const String url = "https://aoeiv.net/api/leaderboard?game=aoe4&leaderboard_id=17&profile_id=123123";
      test("it returns a future list of players if request succeeded", () {
        when(_mockClient.get(Uri.parse(url))).thenAnswer((_) async => Response(exampleLeaderboardDataByProfileId, 200));

        expect(_leaderboardDataProvider.fetchPlayerDataByProfileId(_mockClient, 17, 123123), isA<Future<Player>>());
      });
      test("it throws an Exception if request failed", () {
        when(_mockClient.get(Uri.parse(url))).thenAnswer((_) async => Response('failed', 500));

        expect(_leaderboardDataProvider.fetchPlayerDataByProfileId(_mockClient, 17, 123123), throwsException);
      });
    });
  });
}
