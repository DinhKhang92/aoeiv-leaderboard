import 'package:aoeiv_leaderboard/providers/match_history_data_provider.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';

import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'rating_history_data_provider_test.mocks.dart';

@GenerateMocks([Client])
void main() {
  MockClient _mockClient = MockClient();
  final MatchHistoryDataProvider _matchHistoryDataProvider = MatchHistoryDataProvider();

  const String exampleMatchHistoryData =
      '[{"match_id":"15646784","lobby_id":"109775240933565796","version":"9369","name":"AUTOMATCH","num_players":2,"num_slots":2,"map_size":0,"map_type":7,"ranked":false,"rating_type_id":15,"server":"eastus","started":1639532075,"players":[{"profile_id":8094494,"name":"TheFishKingIRL","clan":null,"country":null,"slot":1,"slot_type":1,"rating":1281,"rating_change":null,"color":null,"team":1,"civ":7,"won":null},{"profile_id":283233,"name":"ashleylynn","clan":null,"country":null,"slot":2,"slot_type":1,"rating":1206,"rating_change":null,"color":null,"team":2,"civ":6,"won":null}]},{"match_id":"15645300","lobby_id":"109775240933533747","version":"9369","name":"AUTOMATCH","num_players":2,"num_slots":2,"map_size":0,"map_type":5,"ranked":false,"rating_type_id":15,"server":"eastus","started":1639531322,"players":[{"profile_id":519858,"name":"Lovoh","clan":null,"country":null,"slot":1,"slot_type":1,"rating":1167,"rating_change":null,"color":null,"team":1,"civ":6,"won":null},{"profile_id":283233,"name":"ashleylynn","clan":null,"country":null,"slot":2,"slot_type":1,"rating":1206,"rating_change":null,"color":null,"team":2,"civ":6,"won":null}]}]';

  setUp(() {
    _mockClient = MockClient();
  });
  group("MatchHistoryDataProvider", () {
    group("fetchMatchHistoryData", () {
      const String url = "https://aoeiv.net/api/player/matches?game=aoe4&profile_id=123123&count=1000";
      test("it returns a future list of players if request succeeded", () {
        when(_mockClient.get(Uri.parse(url))).thenAnswer((_) async => Response(exampleMatchHistoryData, 200));

        expect(_matchHistoryDataProvider.fetchMatchHistoryData(_mockClient, url), isA<Future<List>>());
      });
      test("it throws an Exception if request failed", () {
        when(_mockClient.get(Uri.parse(url))).thenAnswer((_) async => Response('failed', 500));

        expect(_matchHistoryDataProvider.fetchMatchHistoryData(_mockClient, url), throwsException);
      });
    });
  });
}
