import 'package:equatable/equatable.dart';

class Player extends Equatable {
  final int profileId;
  final String name;

  const Player({
    required this.profileId,
    required this.name,
  });

  @override
  List<Object?> get props => [name, profileId];

  Player.fromJson(Map json)
      : name = json['name'],
        profileId = json['profile_id'];
}

class PlayerPreview extends Player {
  final int rank;
  final int gamesCount;
  final int winsCount;
  final int lossesCount;
  final int mmr;
  final int winRate;
  final int? previousRating;

  const PlayerPreview({
    required name,
    required profileId,
    required this.rank,
    required this.gamesCount,
    required this.winsCount,
    required this.lossesCount,
    required this.mmr,
    required this.winRate,
    this.previousRating,
  }) : super(name: name, profileId: profileId);

  @override
  List<Object?> get props => [rank, name, gamesCount, winsCount, lossesCount, mmr, profileId, winRate, previousRating];

  PlayerPreview.fromJson(Map json)
      : rank = json['rank'],
        gamesCount = json['games_count'],
        winsCount = json['wins_count'],
        lossesCount = json['losses_count'],
        mmr = json['rating'],
        previousRating = json['rating'] - json['last_rating_change'],
        winRate = json['win_rate'].round(),
        super.fromJson(json);
}

class PlayerDetail extends Player {
  final int rank;
  final int gamesCount;
  final int winsCount;
  final int lossesCount;
  final int mmr;
  final int winRate;
  final int? rankLevel;

  const PlayerDetail({
    required name,
    required profileId,
    required this.rank,
    required this.gamesCount,
    required this.winsCount,
    required this.lossesCount,
    required this.mmr,
    required this.winRate,
    this.rankLevel,
  }) : super(name: name, profileId: profileId);

  PlayerDetail.fromJson(Map json)
      : rank = json['rank'],
        gamesCount = json['games_count'],
        winsCount = json['wins_count'],
        lossesCount = json['losses_count'],
        mmr = json['rating'],
        winRate = json['win_rate'].round(),
        rankLevel = json['rank_level'],
        super.fromJson(json);
}
