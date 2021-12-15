class NoDataException implements Exception {
  final String message;

  NoDataException(this.message);

  @override
  String toString() {
    return "Exception: $message";
  }

  String get errorMessage => message;
}
