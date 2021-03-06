import 'package:equatable/equatable.dart';

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
        previousRating: json['previous_rating'],
        winRate: (json['wins'] / json['games'] * 100).round(),
      );
}
