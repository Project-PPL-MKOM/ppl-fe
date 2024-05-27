import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:logging/logging.dart';
import 'package:project/core/error/failure.dart';
import 'package:project/data/datasources/remote/remote_ds.dart';
import 'package:project/data/models/calculation_response.dart';
import 'package:project/domain/repositories/calculation_repo.dart';

class CalculationRepositoryImpl extends CalculationRepository {
  final _logger = Logger('CalculationRepository');
  final RemoteDataSource remoteDataSource;

  CalculationRepositoryImpl({required this.remoteDataSource});

  @override
  Stream<Either<Failure, CalculationDataWithMessage>> makeCalculation(
    String filePath,
    double refLength,
  ) async* {
    final transformer = StreamTransformer<CalculationResponseWithMessage,
        Either<Failure, CalculationDataWithMessage>>.fromHandlers(
      handleData: (data, sink) {
        final (:message, :response) = data;
        if (response == null) {
          sink.add(Right((message: message, result: null)));
        } else {
          if (response.success) {
            sink.add(
              Right((message: message, result: response.data)),
            );
          } else {
            _logger.severe('Calculation failed', message);
            sink.add(Left(ServerFailure(response.error ?? '')));
          }
        }
      },
      handleError: (e, st, sink) {
        _logger.severe('Calculation failed', e, st);
        final err = LocalFailure(e.toString());
        sink.add(Left(err));
      },
      handleDone: (sink) => sink.close(),
    );
    yield* remoteDataSource.process(filePath, refLength).transform(transformer);
    // yield* remoteDataSource.processTest(filePath).transform(transformer);
  }
}
