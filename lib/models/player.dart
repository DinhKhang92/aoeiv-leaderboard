class Player {
  final int rank;
  final String name;
  final int totalGames;
  final int totalWins;
  final int totalLosses;
  final int mmr;
  late final int winRate;

  Player({
    required this.rank,
    required this.name,
    required this.totalGames,
    required this.totalWins,
    required this.totalLosses,
    required this.mmr,
  });

  factory Player.fromJson(Map json) => Player(
        rank: json['rank'],
        name: json['name'],
        totalGames: json['games'],
        totalWins: json['wins'],
        totalLosses: json['losses'],
        mmr: json['rating'],
      );

  set setWinRate(int rate) => winRate = rate;
}
