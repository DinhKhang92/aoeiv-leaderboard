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

enum CivilizationId { abbasidDynasty, chinese, delhiSultanate, english, french, holyRomanEmpire, mongols, rus }

extension CivilizationIdExtension on CivilizationId {
  int get id {
    switch (this) {
      case CivilizationId.abbasidDynasty:
        return 0;
      case CivilizationId.chinese:
        return 1;
      case CivilizationId.delhiSultanate:
        return 2;
      case CivilizationId.english:
        return 3;
      case CivilizationId.french:
        return 4;
      case CivilizationId.holyRomanEmpire:
        return 5;
      case CivilizationId.mongols:
        return 6;
      case CivilizationId.rus:
        return 7;
    }
  }
}

class Config {
  final int maxCount = 1000;
  final int matchHistoryMaxCount = 1000;
  final String leaderboardBaseUrl = "https://aoeiv.net/api/leaderboard?game=aoe4";
  final String ratingHistoryBaseUrl = "https://aoeiv.net/api/player/ratinghistory?game=aoe4";
  final String matchHistoryBaseUrl = "https://aoeiv.net/api/player/matches?game=aoe4";
}
