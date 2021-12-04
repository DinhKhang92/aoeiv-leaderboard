class Rating {
  final int timestamp;
  final int rating;

  Rating({required this.timestamp, required this.rating});

  factory Rating.fromJSON(Map json) => Rating(
        timestamp: json['timestamp'],
        rating: json['rating'],
      );
}
