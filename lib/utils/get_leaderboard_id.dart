import 'package:aoeiv_leaderboard/config/config.dart';

int getLeaderboardId(int index) {
  if (index == 0) {
    return LeaderboardId.oneVOne.id;
  } else if (index == 1) {
    return LeaderboardId.twoVTwo.id;
  } else if (index == 2) {
    return LeaderboardId.threeVThree.id;
  } else if (index == 3) {
    return LeaderboardId.fourVFour.id;
  } else {
    return LeaderboardId.oneVOne.id;
  }
}
