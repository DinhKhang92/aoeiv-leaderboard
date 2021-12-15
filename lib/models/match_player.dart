class MatchPlayer {
  final int profileId;
  final String name;
  final int team;
  final int civilizationId;
  final int? rating;

  const MatchPlayer({
    required this.profileId,
    required this.name,
    required this.team,
    required this.civilizationId,
    required this.rating,
  });

  factory MatchPlayer.fromJSON(Map json) => MatchPlayer(
        profileId: json['profile_id'],
        name: json['name'],
        rating: json['rating'],
        team: json['team'],
        civilizationId: json['civ'],
      );
}
