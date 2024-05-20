import 'package:dartz/dartz.dart';
import 'package:logging/logging.dart';
import 'package:project/core/error/failure.dart';
import 'package:project/data/datasources/local/local_ds.dart';
import 'package:project/domain/repositories/app_info_repo.dart';

class AppInfoRepositoryImpl extends AppInfoRepository {
  final _logger = Logger('AppInfoRepository');
  final LocalDataSource localDataSource;

  AppInfoRepositoryImpl({required this.localDataSource});

  @override
  Either<Failure, bool> get isIntroDone {
    try {
      return Right(localDataSource.isIntroDone);
    } catch (e, st) {
      _logger.severe('Get intro done failed', e, st);
      return Left(LocalFailure());
    }
  }

  @override
  Future<Either<Failure, void>> markIsIntroDone() async {
    try {
      return Right(localDataSource.markIsIntroDone());
    } catch (e, st) {
      _logger.severe('Mark intro done failed', e, st);
      return Left(LocalFailure());
    }
  }
}
