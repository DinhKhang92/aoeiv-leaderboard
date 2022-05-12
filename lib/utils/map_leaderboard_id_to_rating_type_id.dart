import 'package:aoeiv_leaderboard/config/config.dart';

int mapLeaderboardIdToRatingTypeId(String leaderboard) {
  if (leaderboard == LeaderboardId.qmOneVOne.leaderboard) {
    return 15;
  } else if (leaderboard == LeaderboardId.qmTwoVTwo.leaderboard) {
    return 16;
  } else if (leaderboard == LeaderboardId.qmThreeVThree.leaderboard) {
    return 17;
  } else if (leaderboard == LeaderboardId.qmFourVFour.leaderboard) {
    return 18;
  } else {
    return 22;
  }
}
