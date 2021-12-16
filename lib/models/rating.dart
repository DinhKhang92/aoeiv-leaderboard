class Rating {
  final int timestamp;
  final int rating;
  final int totalWins;
  final int totalLosses;
  final int streak;
  final int winRate;

  Rating({
    required this.timestamp,
    required this.rating,
    required this.totalWins,
    required this.totalLosses,
    required this.streak,
    required this.winRate,
  });

  factory Rating.fromJSON(Map json) => Rating(
        timestamp: json['timestamp'],
        rating: json['rating'],
        totalWins: json['num_wins'],
        totalLosses: json['num_losses'],
        streak: json['streak'],
        winRate: (json['num_wins'] / (json['num_wins'] + json['num_losses']) * 100).round(),
      );
}
