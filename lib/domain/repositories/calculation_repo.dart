import 'package:dartz/dartz.dart';
import 'package:project/core/error/failure.dart';

abstract class CalculationRepository {
  Stream<Either<Failure, String>> makeCalculation();
}
