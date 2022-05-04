import 'package:aoeiv_leaderboard/config/config.dart';

int mapLeaderboardIdToIndex(String leaderboard) {
  if (leaderboard == LeaderboardId.qmOneVOne.leaderboard) {
    return 0;
  } else if (leaderboard == LeaderboardId.qmTwoVTwo.leaderboard) {
    return 1;
  } else if (leaderboard == LeaderboardId.qmThreeVThree.leaderboard) {
    return 2;
  } else if (leaderboard == LeaderboardId.qmFourVFour.leaderboard) {
    return 3;
  } else {
    return 0;
  }
}
