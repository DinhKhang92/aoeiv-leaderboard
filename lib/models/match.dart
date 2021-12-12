import 'package:aoeiv_leaderboard/models/match_player.dart';

class Match {
  final String name;
  final int numPlayers;
  final int mapType;
  final bool isRanked;
  late List<MatchPlayer> matchPlayers;

  Match({required this.name, required this.numPlayers, required this.mapType, required this.isRanked});

  factory Match.fromJSON(Map json) => Match(
        name: json['name'],
        numPlayers: json['num_players'],
        mapType: json['map_type'],
        isRanked: json['ranked'],
      );

  set setMatchPlayers(List<MatchPlayer> players) => matchPlayers = players;
}
