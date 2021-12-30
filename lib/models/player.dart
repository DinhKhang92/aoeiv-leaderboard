import 'package:equatable/equatable.dart';

class PlayerField {
  static const String id = '_id';
  static const String timestamp = 'timestamp';
  static const String rank = 'rank';
  static const String name = 'name';
  static const String games = 'games';
  static const String wins = 'wins';
  static const String losses = 'losses';
  static const String rating = 'rating';
  static const String profileId = 'profile_id';
  static const String winRate = 'win_rate';
  static const String previousRating = 'previous_rating';
}

class Player extends Equatable {
  final int rank;
  final String name;
  final int totalGames;
  final int totalWins;
  final int totalLosses;
  final int mmr;
  final int profileId;
  final int winRate;
  final int? previousRating;

  const Player({
    required this.rank,
    required this.name,
    required this.totalGames,
    required this.totalWins,
    required this.totalLosses,
    required this.mmr,
    required this.profileId,
    required this.winRate,
    this.previousRating,
  });

  @override
  List<Object?> get props => [rank, name, totalGames, totalWins, totalLosses, mmr, profileId, winRate, previousRating];

  factory Player.fromJson(Map json) => Player(
        rank: json['rank'],
        name: json['name'],
        totalGames: json['games'],
        totalWins: json['wins'],
        totalLosses: json['losses'],
        mmr: json['rating'],
        profileId: json['profile_id'],
        previousRating: json['previous_rating'] == Null ? null : json['previous_rating'],
        winRate: (json['wins'] / json['games'] * 100).round(),
      );

  Map<String, dynamic> toMap() {
    return {
      PlayerField.rank: rank,
      PlayerField.name: name,
      PlayerField.games: totalGames,
      PlayerField.wins: totalWins,
      PlayerField.losses: totalLosses,
      PlayerField.rating: mmr,
      PlayerField.profileId: profileId,
      PlayerField.previousRating: previousRating,
      PlayerField.winRate: winRate,
    };
  }
}
