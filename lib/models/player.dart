import 'package:equatable/equatable.dart';

class Player extends Equatable {
  final int rank;
  final String name;
  final int gamesCount;
  final int winsCount;
  final int lossesCount;
  final int mmr;
  final int profileId;
  final int winRate;
  final int? previousRating;

  const Player({
    required this.rank,
    required this.name,
    required this.gamesCount,
    required this.winsCount,
    required this.lossesCount,
    required this.mmr,
    required this.profileId,
    required this.winRate,
    this.previousRating,
  });

  @override
  List<Object?> get props => [rank, name, gamesCount, winsCount, lossesCount, mmr, profileId, winRate, previousRating];

  factory Player.fromJson(Map json) => Player(
        rank: json['rank'],
        name: json['name'],
        gamesCount: json['games_count'],
        winsCount: json['wins_count'],
        lossesCount: json['losses_count'],
        mmr: json['rating'],
        profileId: json['profile_id'],
        previousRating: json['rating'] - json['last_rating_change'],
        winRate: json['win_rate'].round(),
      );
}
