enum LeaderboardId { qmOneVOne, qmTwoVTwo, qmThreeVThree, qmFourVFour }

extension LeaderboardIdExtension on LeaderboardId {
  String get leaderboard {
    switch (this) {
      case LeaderboardId.qmOneVOne:
        return "qm_1v1";
      case LeaderboardId.qmTwoVTwo:
        return "qm_2v2";
      case LeaderboardId.qmThreeVThree:
        return "qm_3v3";
      case LeaderboardId.qmFourVFour:
        return "qm_4v4";
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
  final int leaderboardCount = 1000;
  final int matchHistoryCount = 1000;
  final String leaderboardBaseUrl = "https://aoe4world.com/api/v0/leaderboards";
  final String ratingHistoryBaseUrl = "https://aoeiv.net/api/player/ratinghistory?game=aoe4";
  final String matchHistoryBaseUrl = "https://aoeiv.net/api/player/matches?game=aoe4";
}
