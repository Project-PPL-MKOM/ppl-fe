import 'package:dartz/dartz.dart';
import 'package:project/core/error/failure.dart';
import 'package:project/domain/entities/calculation_data.dart';

typedef CalculationDataWithMessage = ({
  String message,
  CalculationData? result,
});

abstract class CalculationRepository {
  Stream<Either<Failure, CalculationDataWithMessage>> makeCalculation(
    String filePath,
    double refLength,
  );
}
