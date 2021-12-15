import 'package:aoeiv_leaderboard/config/config.dart';

int mapLeaderboardIdToIndex(int leaderboardId) {
  if (leaderboardId == LeaderboardId.oneVOne.id) {
    return 0;
  } else if (leaderboardId == LeaderboardId.twoVTwo.id) {
    return 1;
  } else if (leaderboardId == LeaderboardId.threeVThree.id) {
    return 2;
  } else if (leaderboardId == LeaderboardId.fourVFour.id) {
    return 3;
  } else {
    return 0;
  }
}
