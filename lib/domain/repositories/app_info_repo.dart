import 'package:dartz/dartz.dart';
import 'package:project/core/error/failure.dart';

abstract class AppInfoRepository {
  Either<Failure, bool> get isIntroDone;
  Future<Either<Failure, void>> markIsIntroDone();
}
