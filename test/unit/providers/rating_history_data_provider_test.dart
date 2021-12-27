import 'package:aoeiv_leaderboard/providers/rating_history_data_provider.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'rating_history_data_provider_test.mocks.dart';

@GenerateMocks([Client])
void main() {
  MockClient _mockClient = MockClient();
  final RatingHistoryDataProvider _ratingHistoryDataProvider = RatingHistoryDataProvider();

  const String url = "https://aoeiv.net/api/player/ratinghistory?game=aoe4&leaderboard_id=17&profile_id=123123&count=1000";
  const String exampleRatingHistoryData = '[{"rating":1206,"num_wins":65,"num_losses":62,"streak":2,"drops":1,"timestamp":1639534264}]';

  group("RatingHistoryDataProvider", () {
    setUp(() {
      _mockClient = MockClient();
    });

    group('fetchRatingHistoryData', () {
      test("it returns a future list of rating if request succeeded", () {
        when(_mockClient.get(Uri.parse(url))).thenAnswer((_) async => Response(exampleRatingHistoryData, 200));

        expect(_ratingHistoryDataProvider.fetchRatingHistoryData(_mockClient, url), isA<Future<List>>());
      });
      test("it throws an Exception if request failed", () {
        when(_mockClient.get(Uri.parse(url))).thenAnswer((_) async => Response('failed', 500));

        expect(_ratingHistoryDataProvider.fetchRatingHistoryData(_mockClient, url), throwsException);
      });
    });
  });
}
