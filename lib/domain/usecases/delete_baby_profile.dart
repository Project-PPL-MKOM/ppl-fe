import 'package:dartz/dartz.dart';
import 'package:project/core/error/failure.dart';
import 'package:project/core/usecase/usecase.dart';
import 'package:project/domain/repositories/baby_profile_repo.dart';

class DeleteBabyProfile extends FutureUseCase<void, String> {
  final BabyProfileRepository repository;

  DeleteBabyProfile({required this.repository});

  @override
  Future<Either<Failure, void>> call(String params) =>
      repository.delete(params);
}
