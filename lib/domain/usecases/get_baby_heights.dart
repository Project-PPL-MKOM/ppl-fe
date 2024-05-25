import 'package:dartz/dartz.dart';
import 'package:project/core/error/failure.dart';
import 'package:project/core/usecase/usecase.dart';
import 'package:project/domain/entities/baby_height.dart';
import 'package:project/domain/repositories/baby_height_repo.dart';

class GetBabyHeights extends UseCase<List<BabyHeight>, String> {
  final BabyHeightRepository repository;

  GetBabyHeights({required this.repository});

  @override
  Either<Failure, List<BabyHeight>> call(String params) =>
      repository.get(params);
}
