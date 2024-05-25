import 'package:dartz/dartz.dart';
import 'package:project/core/error/failure.dart';
import 'package:project/domain/entities/baby_height.dart';

abstract class BabyHeightRepository {
  Either<Failure, List<BabyHeight>> get(String babyId);
  Future<Either<Failure, void>> add(BabyHeight data);
}
