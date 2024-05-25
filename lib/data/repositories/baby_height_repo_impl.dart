import 'package:dartz/dartz.dart';
import 'package:logging/logging.dart';
import 'package:project/core/error/failure.dart';
import 'package:project/data/datasources/local/local_ds.dart';
import 'package:project/data/models/baby_height.dart';
import 'package:project/domain/entities/baby_height.dart';
import 'package:project/domain/repositories/baby_height_repo.dart';

class BabyHeightRepositoryImpl extends BabyHeightRepository {
  final _logger = Logger('BabyHeightRepository');
  final LocalDataSource localDataSource;

  BabyHeightRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failure, void>> add(BabyHeight data) async {
    try {
      await localDataSource.addBabyHeight(BabyHeightModel.fromEntity(data));
      return const Right(null);
    } catch (e, st) {
      _logger.severe('Add height failed', e, st);
      return Left(LocalFailure());
    }
  }

  @override
  Either<Failure, List<BabyHeight>> get(String babyId) {
    try {
      return Right(localDataSource.getBabyHeights(babyId));
    } catch (e, st) {
      _logger.severe('Get height failed', e, st);
      return Left(LocalFailure());
    }
  }
}
