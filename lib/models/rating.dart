import 'package:equatable/equatable.dart';

class Rating extends Equatable {
  final int timestamp;
  final int rating;
  final int totalWins;
  final int totalLosses;
  final int streak;
  final int winRate;

  const Rating({
    required this.timestamp,
    required this.rating,
    required this.totalWins,
    required this.totalLosses,
    required this.streak,
    required this.winRate,
  });

  @override
  List<Object?> get props => [timestamp, rating, totalWins, totalLosses, streak, winRate];

  factory Rating.fromJSON(Map json) => Rating(
        timestamp: json['timestamp'],
        rating: json['rating'],
        totalWins: json['num_wins'],
        totalLosses: json['num_losses'],
        streak: json['streak'],
        winRate: (json['num_wins'] / (json['num_wins'] + json['num_losses']) * 100).round(),
      );
}
