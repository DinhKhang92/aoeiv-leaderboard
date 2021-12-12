class MatchPlayer {
  final int profileId;
  final String name;
  final int rating;
  final int team;
  final int civilizationId;

  const MatchPlayer({
    required this.profileId,
    required this.name,
    required this.rating,
    required this.team,
    required this.civilizationId,
  });

  factory MatchPlayer.fromJSON(Map json) => MatchPlayer(
        profileId: json['profile_id'],
        name: json['name'],
        rating: json['rating'],
        team: json['team'],
        civilizationId: json['civ'],
      );
}
