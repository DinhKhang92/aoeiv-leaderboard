import 'package:aoeiv_leaderboard/config/config.dart';

String mapIndexToLeaderboard(int index) {
  if (index == 0) {
    return LeaderboardId.qmOneVOne.leaderboard;
  } else if (index == 1) {
    return LeaderboardId.qmTwoVTwo.leaderboard;
  } else if (index == 2) {
    return LeaderboardId.qmThreeVThree.leaderboard;
  } else if (index == 3) {
    return LeaderboardId.qmFourVFour.leaderboard;
  } else {
    return LeaderboardId.qmOneVOne.leaderboard;
  }
}
