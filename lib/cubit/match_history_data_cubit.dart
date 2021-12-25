import 'package:aoeiv_leaderboard/config/config.dart';
import 'package:aoeiv_leaderboard/models/match.dart';
import 'package:aoeiv_leaderboard/models/match_player.dart';
import 'package:aoeiv_leaderboard/repositories/match_history_data_repository.dart';
import 'package:aoeiv_leaderboard/utils/map_leaderboard_id_to_num_players.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'match_history_data_state.dart';

class MatchHistoryDataCubit extends Cubit<MatchHistoryDataState> {
  final MatchHistoryDataRepository matchHistoryDataRepository;
  MatchHistoryDataCubit({required this.matchHistoryDataRepository}) : super(const MatchHistoryDataInitial(matches: [], civilizationDistribution: {}, totalCount: 1));

  Future<void> fetchMatchHistoryData(int leaderboardId, int profileId) async {
    try {
      emit(MatchHistoryDataLoading(matches: state.filteredMatches, civilizationDistribution: state.civilizationDistribution, totalCount: state.totalCount));
      final List<Match> matches = await matchHistoryDataRepository.fetchMatchHistoryData(profileId);
      final List<Match> filteredMatches = matches.where((Match match) => match.numPlayers == mapLeaderboardIdToNumPlayers(leaderboardId)).toList();

      final List<MatchPlayer> playerInMatches = filteredMatches.map((Match match) => match.matchPlayers.firstWhere((MatchPlayer player) => player.profileId == profileId)).toList();
      final int abbasidDynastyCount = playerInMatches.where((MatchPlayer player) => player.civilizationId == CivilizationId.abbasidDynasty.id).toList().length;
      final int chineseCount = playerInMatches.where((MatchPlayer player) => player.civilizationId == CivilizationId.chinese.id).toList().length;
      final int delhiSultanateCount = playerInMatches.where((MatchPlayer player) => player.civilizationId == CivilizationId.delhiSultanate.id).toList().length;
      final int englishCount = playerInMatches.where((MatchPlayer player) => player.civilizationId == CivilizationId.english.id).toList().length;
      final int frenchCount = playerInMatches.where((MatchPlayer player) => player.civilizationId == CivilizationId.french.id).toList().length;
      final int holyRomanEmpireCount = playerInMatches.where((MatchPlayer player) => player.civilizationId == CivilizationId.holyRomanEmpire.id).toList().length;
      final int mongolsCount = playerInMatches.where((MatchPlayer player) => player.civilizationId == CivilizationId.mongols.id).toList().length;
      final int rusCount = playerInMatches.where((MatchPlayer player) => player.civilizationId == CivilizationId.rus.id).toList().length;

      final Map civilizationDistribution = {
        "${CivilizationId.abbasidDynasty.id}": abbasidDynastyCount,
        "${CivilizationId.chinese.id}": chineseCount,
        "${CivilizationId.delhiSultanate.id}": delhiSultanateCount,
        "${CivilizationId.english.id}": englishCount,
        "${CivilizationId.french.id}": frenchCount,
        "${CivilizationId.holyRomanEmpire.id}": holyRomanEmpireCount,
        "${CivilizationId.mongols.id}": mongolsCount,
        "${CivilizationId.rus.id}": rusCount,
      };

      emit(MatchHistoryDataLoaded(matches: filteredMatches, civilizationDistribution: civilizationDistribution, totalCount: filteredMatches.length));
    } catch (e) {
      emit(MatchHistoryDataError());
    }
  }
}
