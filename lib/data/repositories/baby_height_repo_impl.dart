import 'package:dartz/dartz.dart';
import 'package:faker/faker.dart';
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
      return Left(LocalFailure(e.toString()));
    }
  }

  @override
  Either<Failure, List<BabyHeight>> get(String babyId) {
    try {
      // TODO: remove fake data
      final fakeData = List.generate(
          15,
          (_) => BabyHeight.noId(
                babyId: babyId,
                height: faker.randomGenerator.decimal(min: 10, scale: 70),
                timestamp: faker.date.dateTime(minYear: 2020, maxYear: 2023),
              ));
      fakeData.sort((a, b) => a.timestamp.compareTo(b.timestamp));
      return Right(fakeData);
      // return Right(localDataSource.getBabyHeights(babyId));
    } catch (e, st) {
      _logger.severe('Get height failed', e, st);
      return Left(LocalFailure(e.toString()));
    }
  }
}
