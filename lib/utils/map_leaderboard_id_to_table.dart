import 'package:aoeiv_leaderboard/utils/aoe_database.dart';

String mapLeaderboardIdToTable(int leaderboardId) {
  switch (leaderboardId) {
    case 17:
      return AoeDatabaseTable.oneVOne;
    case 18:
      return AoeDatabaseTable.twoVTwo;
    case 19:
      return AoeDatabaseTable.threeVThree;
    case 20:
      return AoeDatabaseTable.fourVFour;
    default:
      return AoeDatabaseTable.oneVOne;
  }
}
