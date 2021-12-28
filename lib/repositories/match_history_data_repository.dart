import 'package:aoeiv_leaderboard/config/config.dart';
import 'package:aoeiv_leaderboard/models/match.dart';
import 'package:aoeiv_leaderboard/models/match_player.dart';
import 'package:aoeiv_leaderboard/providers/match_history_data_provider.dart';
import 'package:aoeiv_leaderboard/utils/map_leaderboard_id_to_rating_type_id.dart';
import 'package:http/http.dart';

class MatchHistoryDataRepository {
  final Config _config = Config();
  final Client _client = Client();
  final MatchHistoryDataProvider matchHistoryDataProvider;
  MatchHistoryDataRepository({required this.matchHistoryDataProvider});

  Future<List<Match>> fetchMatchHistoryData(int profileId) async {
    final String url = "${_config.matchHistoryBaseUrl}&profile_id=$profileId&count=${_config.matchHistoryCount}";

    final List jsonData = await matchHistoryDataProvider.fetchMatchHistoryData(_client, url);
    return jsonData.map((matchHistory) => Match.fromJSON(matchHistory)).toList();
  }

  List<Match> filterMatches(int leaderboardId, List<Match> matches) => matches.where((Match match) => match.ratingTypeId == mapLeaderboardIdToRatingTypeId(leaderboardId)).toList();

  Map<String, int> getCivDistributionByProfileId(List<Match> matches, int profileId) {
    final List<MatchPlayer> playerInMatches = matches.map((Match match) => match.matchPlayers.firstWhere((MatchPlayer player) => player.profileId == profileId)).toList();
    final int abbasidDynastyCount = playerInMatches.where((MatchPlayer player) => player.civilizationId == CivilizationId.abbasidDynasty.id).toList().length;
    final int chineseCount = playerInMatches.where((MatchPlayer player) => player.civilizationId == CivilizationId.chinese.id).toList().length;
    final int delhiSultanateCount = playerInMatches.where((MatchPlayer player) => player.civilizationId == CivilizationId.delhiSultanate.id).toList().length;
    final int englishCount = playerInMatches.where((MatchPlayer player) => player.civilizationId == CivilizationId.english.id).toList().length;
    final int frenchCount = playerInMatches.where((MatchPlayer player) => player.civilizationId == CivilizationId.french.id).toList().length;
    final int holyRomanEmpireCount = playerInMatches.where((MatchPlayer player) => player.civilizationId == CivilizationId.holyRomanEmpire.id).toList().length;
    final int mongolsCount = playerInMatches.where((MatchPlayer player) => player.civilizationId == CivilizationId.mongols.id).toList().length;
    final int rusCount = playerInMatches.where((MatchPlayer player) => player.civilizationId == CivilizationId.rus.id).toList().length;

    final Map<String, int> civilizationDistribution = {
      "${CivilizationId.abbasidDynasty.id}": abbasidDynastyCount,
      "${CivilizationId.chinese.id}": chineseCount,
      "${CivilizationId.delhiSultanate.id}": delhiSultanateCount,
      "${CivilizationId.english.id}": englishCount,
      "${CivilizationId.french.id}": frenchCount,
      "${CivilizationId.holyRomanEmpire.id}": holyRomanEmpireCount,
      "${CivilizationId.mongols.id}": mongolsCount,
      "${CivilizationId.rus.id}": rusCount,
    };

    return civilizationDistribution;
  }
}
