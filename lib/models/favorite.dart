import 'package:equatable/equatable.dart';

class FavoriteField {
  static const String id = "_id";
  static const String leaderboardId = "leaderboard_id";
  static const String profileId = "profile_id";
  static const String name = "name";
}

class Favorite extends Equatable {
  final int leaderboardId;
  final int profileId;
  final String name;

  const Favorite({required this.leaderboardId, required this.profileId, required this.name});

  @override
  List<Object> get props => [leaderboardId, profileId, name];

  factory Favorite.fromJSON(Map json) => Favorite(
        leaderboardId: json['leaderboard_id'],
        profileId: json['profile_id'],
        name: json['name'],
      );

  Map<String, dynamic> toMap() {
    return {
      "leaderboard_id": leaderboardId,
      "profile_id": profileId,
      "name": name,
    };
  }
}
