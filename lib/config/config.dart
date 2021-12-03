enum LeaderboardId { oneVOne, twoVTwo, threeVThree, fourVFour }

extension LeaderboardIdExtension on LeaderboardId {
  int get id {
    switch (this) {
      case LeaderboardId.oneVOne:
        return 17;
      case LeaderboardId.twoVTwo:
        return 18;
      case LeaderboardId.threeVThree:
        return 19;
      case LeaderboardId.fourVFour:
        return 20;
    }
  }
}

class Config {
  final int maxCount = 10000;
  final String leaderboardBaseUrl = "https://aoeiv.net/api/leaderboard?game=aoe4";
  final String ratingHistoryBaseUrl = "https://aoeiv.net/api/player/ratinghistory?game=aoe4";
}
