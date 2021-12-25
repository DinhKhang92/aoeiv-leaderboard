import 'package:aoeiv_leaderboard/models/match_player.dart';

class Match {
  final String? name;
  final int numPlayers;
  final int mapType;
  final bool isRanked;
  final List<MatchPlayer> matchPlayers;

  Match({this.name, required this.numPlayers, required this.mapType, required this.isRanked, required this.matchPlayers});

  factory Match.fromJSON(Map json) => Match(
        name: json['name'],
        numPlayers: json['num_players'],
        mapType: json['map_type'],
        isRanked: json['ranked'],
        matchPlayers: (json['players'] as List).map((matchHistoryPlayer) => MatchPlayer.fromJSON(matchHistoryPlayer)).toList(),
      );
}
