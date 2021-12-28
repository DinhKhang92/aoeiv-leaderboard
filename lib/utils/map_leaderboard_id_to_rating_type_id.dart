import 'package:aoeiv_leaderboard/config/config.dart';

int mapLeaderboardIdToRatingTypeId(int leaderboardId) {
  if (leaderboardId == LeaderboardId.oneVOne.id) {
    return 15;
  } else if (leaderboardId == LeaderboardId.twoVTwo.id) {
    return 16;
  } else if (leaderboardId == LeaderboardId.threeVThree.id) {
    return 17;
  } else if (leaderboardId == LeaderboardId.fourVFour.id) {
    return 18;
  } else {
    return 22;
  }
}
