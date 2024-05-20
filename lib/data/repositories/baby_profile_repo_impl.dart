import 'package:dartz/dartz.dart';
import 'package:logging/logging.dart';
import 'package:project/core/error/failure.dart';
import 'package:project/data/datasources/local/local_ds.dart';
import 'package:project/data/models/baby_profile.dart';
import 'package:project/domain/entities/baby_profile.dart';
import 'package:project/domain/repositories/baby_profile_repo.dart';

class BabyProfileRepositoryImpl extends BabyProfileRepository {
  final _logger = Logger('BabyProfileRepository');
  final LocalDataSource localDataSource;

  BabyProfileRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failure, BabyProfile>> add(BabyProfile data) async {
    try {
      final newData = await localDataSource
          .addBabyProfile(BabyProfileModel.fromEntity(data));
      return Right(newData);
    } catch (e, st) {
      _logger.severe('Add baby failed', e, st);
      return Left(LocalFailure());
    }
  }

  @override
  Either<Failure, List<BabyProfile>> get babies {
    try {
      return Right(localDataSource.babyProfiles);
    } catch (e, st) {
      _logger.severe('Get baby failed', e, st);
      return Left(LocalFailure());
    }
  }

  @override
  Future<Either<Failure, void>> delete(String id) async {
    try {
      localDataSource.deleteBabyProfile(id);
      return const Right(null);
    } catch (e, st) {
      _logger.severe('Delete baby failed', e, st);
      return Left(LocalFailure());
    }
  }

  @override
  Future<Either<Failure, void>> update(String id, BabyProfile data) async {
    try {
      localDataSource.updateBabyProfile(id, BabyProfileModel.fromEntity(data));
      return const Right(null);
    } catch (e, st) {
      _logger.severe('Update baby failed', e, st);
      return Left(LocalFailure());
    }
  }
}
