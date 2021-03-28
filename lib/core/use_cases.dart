

import 'package:dartz/dartz.dart';
import 'package:setel_geofanc/error/failures.dart';

abstract class UseCaseNoParams<Type> {
  Future<Either<Failure, Type>> call();
}

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call({Params params});
}
