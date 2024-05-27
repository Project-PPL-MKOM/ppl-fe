import 'package:dartz/dartz.dart';
import 'package:project/core/error/failure.dart';
import 'package:project/domain/repositories/calculation_repo.dart';

class ProcessData {
  final CalculationRepository repository;

  ProcessData({required this.repository});

  Stream<Either<Failure, CalculationDataWithMessage>> call(
    String filePath,
    double refLength,
  ) =>
      repository.makeCalculation(filePath, refLength);
}
