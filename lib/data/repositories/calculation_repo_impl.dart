import 'package:dartz/dartz.dart';
import 'package:logging/logging.dart';
import 'package:project/core/error/failure.dart';
import 'package:project/data/datasources/remote/remote_ds.dart';
import 'package:project/domain/repositories/calculation_repo.dart';

class CalculationRepositoryImpl extends CalculationRepository {
  final _logger = Logger('CalculationRepository');
  final RemoteDataSource remoteDataSource;

  CalculationRepositoryImpl({required this.remoteDataSource});

  @override
  Stream<Either<Failure, String>> makeCalculation() async* {
    try {
      yield* remoteDataSource.process().map((data) => Right(data));
    } catch (e, st) {
      _logger.severe('Add baby failed', e, st);
      yield Left(LocalFailure());
    }
  }
}
