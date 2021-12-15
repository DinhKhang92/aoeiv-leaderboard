class FetchDataException implements Exception {
  final String message;

  FetchDataException(this.message);

  @override
  String toString() {
    return "Exception: $message";
  }

  String get errorMessage => message;
}
