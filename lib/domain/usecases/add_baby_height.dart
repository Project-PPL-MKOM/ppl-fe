import 'package:dartz/dartz.dart';
import 'package:project/core/error/failure.dart';
import 'package:project/core/usecase/usecase.dart';
import 'package:project/domain/entities/baby_height.dart';
import 'package:project/domain/repositories/baby_height_repo.dart';

class AddBabyHeight extends FutureUseCase<void, BabyHeight> {
  final BabyHeightRepository repository;

  AddBabyHeight({required this.repository});

  @override
  Future<Either<Failure, void>> call(BabyHeight params) =>
      repository.add(params);
}
