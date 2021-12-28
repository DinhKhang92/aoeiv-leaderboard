import 'package:aoeiv_leaderboard/models/match_player.dart';
import 'package:equatable/equatable.dart';

class Match extends Equatable {
  final String? name;
  final int mapType;
  final bool isRanked;
  final int ratingTypeId;
  final List<MatchPlayer> matchPlayers;

  const Match({this.name, required this.mapType, required this.isRanked, required this.ratingTypeId, required this.matchPlayers});

  @override
  List<Object?> get props => [name, mapType, isRanked, ratingTypeId, matchPlayers];

  factory Match.fromJSON(Map json) => Match(
        name: json['name'],
        mapType: json['map_type'],
        isRanked: json['ranked'],
        ratingTypeId: json['rating_type_id'],
        matchPlayers: (json['players'] as List).map((matchHistoryPlayer) => MatchPlayer.fromJSON(matchHistoryPlayer)).toList(),
      );
}
