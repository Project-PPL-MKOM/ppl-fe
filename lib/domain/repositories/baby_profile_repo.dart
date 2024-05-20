import 'package:dartz/dartz.dart';
import 'package:project/core/error/failure.dart';
import 'package:project/domain/entities/baby_profile.dart';

abstract class BabyProfileRepository {
  Either<Failure, List<BabyProfile>> get babies;
  Future<Either<Failure, BabyProfile>> add(BabyProfile data);
  Future<Either<Failure, void>> update(String id, BabyProfile data);
  Future<Either<Failure, void>> delete(String id);
}
