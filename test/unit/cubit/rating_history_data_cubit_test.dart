import 'package:aoeiv_leaderboard/cubit/rating_history_data_cubit.dart';
import 'package:aoeiv_leaderboard/models/player.dart';
import 'package:aoeiv_leaderboard/models/rating.dart';
import 'package:aoeiv_leaderboard/repositories/rating_history_data_repository.dart';
import 'package:bloc_test/bloc_test.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'rating_history_data_cubit_test.mocks.dart';

@GenerateMocks([RatingHistoryDataRepository])
void main() {
  group("RatingHistoryDataCubit", () {
    final MockRatingHistoryDataRepository _mockRatingHistoryDataRepository = MockRatingHistoryDataRepository();
    late RatingHistoryDataCubit _ratingHistoryDataCubit;

    const int leaderboardId = 17;
    const int profileId = 1412;

    final Rating exampleRating = Rating(rating: 1412, streak: 2, timestamp: 123, totalLosses: 2, totalWins: 8);
    final Player examplePlayer = Player(rank: 1412, name: "T0nb3rry", totalGames: 100, totalWins: 71, totalLosses: 29, mmr: 1412, profileId: 1412);

    setUp(() {
      _ratingHistoryDataCubit = RatingHistoryDataCubit(ratingHistoryDataRepository: _mockRatingHistoryDataRepository);
    });

    group("fetchRatingHistoryData", () {
      blocTest<RatingHistoryDataCubit, RatingHistoryDataState>(
        'emits RatingHistoryDataLoading and RatingHistoryDataLoaded when fetching rating history data succeeded',
        build: () {
          when(_mockRatingHistoryDataRepository.fetchRatingHistoryData(any, any)).thenAnswer((_) async => [exampleRating]);
          when(_mockRatingHistoryDataRepository.fetchPlayerDataByProfileId(any, any)).thenAnswer((_) async => examplePlayer);

          return _ratingHistoryDataCubit;
        },
        act: (cubit) => cubit.fetchPlayerData(leaderboardId, profileId),
        expect: () => [isA<RatingHistoryDataLoading>(), isA<RatingHistoryDataLoaded>()],
      );
      blocTest<RatingHistoryDataCubit, RatingHistoryDataState>(
        'emits RatingHistoryDataLoading and RatingHistoryDataLoaded with rating history data when fetching data succeeded',
        build: () {
          when(_mockRatingHistoryDataRepository.fetchRatingHistoryData(any, any)).thenAnswer((_) async => [exampleRating]);
          when(_mockRatingHistoryDataRepository.fetchPlayerDataByProfileId(any, any)).thenAnswer((_) async => examplePlayer);

          return _ratingHistoryDataCubit;
        },
        act: (cubit) => cubit.fetchPlayerData(leaderboardId, profileId),
        expect: () => [
          const RatingHistoryDataLoading(ratingHistoryData: []),
          RatingHistoryDataLoaded(ratingHistoryData: [exampleRating])
        ],
      );
      blocTest<RatingHistoryDataCubit, RatingHistoryDataState>(
        'emits RatingHistoryDataLoading and RatingHistoryDataError when fetching rating history data failed',
        build: () {
          when(_mockRatingHistoryDataRepository.fetchRatingHistoryData(any, any)).thenThrow(Error);

          return _ratingHistoryDataCubit;
        },
        act: (cubit) => cubit.fetchPlayerData(leaderboardId, profileId),
        expect: () => [isA<RatingHistoryDataLoading>(), isA<RatingHistoryDataError>()],
      );
    });
  });
}
