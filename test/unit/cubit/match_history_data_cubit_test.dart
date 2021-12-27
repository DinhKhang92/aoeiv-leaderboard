import 'package:aoeiv_leaderboard/cubit/match_history_data_cubit.dart';
import 'package:aoeiv_leaderboard/exceptions/fetch_data_exception.dart';
import 'package:aoeiv_leaderboard/models/match.dart';
import 'package:aoeiv_leaderboard/repositories/match_history_data_repository.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../test_utils.dart';
import 'match_history_data_cubit_test.mocks.dart';

@GenerateMocks([MatchHistoryDataRepository])
void main() {
  final MockMatchHistoryDataRepository _mockMatchHistoryDataRepository = MockMatchHistoryDataRepository();
  late MatchHistoryDataCubit _matchHistoryDataCubit;

  setUp(() {
    _matchHistoryDataCubit = MatchHistoryDataCubit(matchHistoryDataRepository: _mockMatchHistoryDataRepository);
  });

  group("MatchHistoryDataCubit", () {
    blocTest<MatchHistoryDataCubit, MatchHistoryDataState>(
      "emits MatchHistoryDataLoading and MatchHistoryDataLoaded when fetching match history data succeeded ",
      build: () {
        final Match matchOneVOne = Match.fromJSON(exampleOneVOneMatch);
        final Match matchTwoVTwo = Match.fromJSON(exampleTwoVTwoMatch);
        when(_mockMatchHistoryDataRepository.fetchMatchHistoryData(123123)).thenAnswer((_) async => [matchOneVOne, matchTwoVTwo]);
        when(_mockMatchHistoryDataRepository.filterMatches(17, [matchOneVOne, matchTwoVTwo])).thenReturn([matchOneVOne]);
        when(_mockMatchHistoryDataRepository.getCivDistributionByProfileId([matchOneVOne], 123123)).thenReturn({"0": 0, "1": 0, "2": 0, "3": 0, "4": 0, "5": 0, "6": 1, "7": 0});
        return _matchHistoryDataCubit;
      },
      act: (cubit) => cubit.fetchMatchHistoryData(17, 123123),
      expect: () => [isA<MatchHistoryDataLoading>(), isA<MatchHistoryDataLoaded>()],
    );
    blocTest<MatchHistoryDataCubit, MatchHistoryDataState>(
      "emits MatchHistoryDataLoading and MatchHistoryDataError when fetching match history data failed ",
      build: () {
        when(_mockMatchHistoryDataRepository.fetchMatchHistoryData(123123)).thenThrow(FetchDataException("failed"));
        return _matchHistoryDataCubit;
      },
      act: (cubit) => cubit.fetchMatchHistoryData(17, 123123),
      expect: () => [isA<MatchHistoryDataLoading>(), isA<MatchHistoryDataError>()],
    );
  });
}
