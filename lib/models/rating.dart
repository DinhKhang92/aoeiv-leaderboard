class Rating {
  final int timestamp;
  final int rating;
  final int totalWins;
  final int totalLosses;
  final int streak;
  late final int winRate;

  Rating({
    required this.timestamp,
    required this.rating,
    required this.totalWins,
    required this.totalLosses,
    required this.streak,
  });

  factory Rating.fromJSON(Map json) => Rating(
        timestamp: json['timestamp'],
        rating: json['rating'],
        totalWins: json['num_wins'],
        totalLosses: json['num_losses'],
        streak: json['streak'],
      );

  set setWinRate(int rate) => winRate = rate;
}
