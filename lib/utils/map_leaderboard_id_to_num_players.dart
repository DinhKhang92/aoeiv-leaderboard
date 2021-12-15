import 'package:aoeiv_leaderboard/config/config.dart';

int mapLeaderboardIdToNumPlayers(int leaderboardId) {
  if (leaderboardId == LeaderboardId.oneVOne.id) {
    return 2;
  } else if (leaderboardId == LeaderboardId.twoVTwo.id) {
    return 4;
  } else if (leaderboardId == LeaderboardId.threeVThree.id) {
    return 6;
  } else if (leaderboardId == LeaderboardId.fourVFour.id) {
    return 8;
  } else {
    return 2;
  }
}
