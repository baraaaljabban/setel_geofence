import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:setel_geofanc/core/app_utils.dart';
import 'package:setel_geofanc/error/failures.dart';

main() {
  InputConverter inputConverter;
  setUp(() {
    inputConverter = new InputConverter();
  });

  group(
    "stringToUnsignedDouble2",
    () {
      test(
        "should return an integer when the string represents an unsigned Double",
        () async {
          // arrange
          final xPoint = "123";
          final yPoint = "222";
          //act
          final result = inputConverter.stringToUnsignedDouble2(
            xPoint: xPoint,
            yPoint: yPoint,
          );
          //assert
          expect(result, Right(Tuple2(123, 222)));
        },
      );
    },
  );

  group(
    "stringToUnsignedDouble",
    () {
      test(
        "should return an integer when the string represents an unsigned Double",
        () async {
          // arrange
          final xPoint = "123";
          final yPoint = "222";
          final radius = "333";

          //act
          final result = inputConverter.stringToUnsignedDouble(
            xPoint: xPoint,
            yPoint: yPoint,
            radius: radius,
          );
          //assert
          expect(result, Right(Tuple3(123, 222, 333)));
        },
      );
    },
  );

  group(
    "stringToUnsignedDouble",
    () {
      test(
        "should return Left InvalidInputFailure",
        () async {
          // arrange
          final xPoint = "-123";
          final yPoint = "-333";
          final radius = "444";

          //act
          final result = inputConverter.stringToUnsignedDouble(
            xPoint: xPoint,
            yPoint: yPoint,
            radius: radius,
          );
          //assert
          expect(result, Left(InvalidInputFailure("")));
        },
      );
    },
  );

  group(
    "stringToUnsignedDouble",
    () {
      test(
        "should return Left InvalidInputFailure",
        () async {
          // arrange
          final xPoint = "-123";
          final yPoint = "333";

          //act
          final result = inputConverter.stringToUnsignedDouble2(
            xPoint: xPoint,
            yPoint: yPoint,
          );
          //assert
          expect(result, Left(InvalidInputFailure("x format worng")));
        },
      );
    },
  );
}
