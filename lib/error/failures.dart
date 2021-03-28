abstract class Failure {
  final String message;
  Failure(this.message);
}

class ServerFailure extends Failure {
  ServerFailure({String message}) : super(message);
}

class CacheFailure extends Failure {
  CacheFailure({String message}) : super(message);
}

class InternetConnectionFailure extends Failure {
  InternetConnectionFailure({String message}) : super(message);
}

class UnExpectedServerResponseFailure extends Failure {
  UnExpectedServerResponseFailure({String message}) : super(message);
}

class UnknownFailuer extends Failure {
  UnknownFailuer({String message}) : super(message);
}
