import 'package:equatable/equatable.dart';

class MatchPlayer extends Equatable {
  final int profileId;
  final String? name;
  final int team;
  final int civilizationId;
  final int? rating;

  const MatchPlayer({
    required this.profileId,
    this.name,
    required this.team,
    required this.civilizationId,
    required this.rating,
  });

  @override
  List<Object?> get props => [profileId, name, team, civilizationId, rating];

  factory MatchPlayer.fromJSON(Map json) => MatchPlayer(
        profileId: json['profile_id'],
        name: json['name'],
        rating: json['rating'],
        team: json['team'],
        civilizationId: json['civ'],
      );
}
