class CacheException implements Exception {
  final String message;

  CacheException({this.message});
}

class UnExpectedServerResponseException implements Exception {
  final String message;
  UnExpectedServerResponseException({this.message});
}
