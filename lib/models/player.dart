class Player {
  final int rank;
  final String name;
  final int totalGames;
  final int totalWins;
  final int totalLosses;
  final int mmr;
  final int profileId;
  final int? previousRating;

  late final int winRate;

  Player({
    required this.rank,
    required this.name,
    required this.totalGames,
    required this.totalWins,
    required this.totalLosses,
    required this.mmr,
    required this.profileId,
    this.previousRating,
  });

  factory Player.fromJson(Map json) => Player(
        rank: json['rank'],
        name: json['name'],
        totalGames: json['games'],
        totalWins: json['wins'],
        totalLosses: json['losses'],
        mmr: json['rating'],
        profileId: json['profile_id'],
        previousRating: json['previous_rating'],
      );

  set setWinRate(int rate) => winRate = rate;
}
