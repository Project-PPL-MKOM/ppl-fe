import 'package:dartz/dartz.dart';
import 'package:project/core/error/failure.dart';
import 'package:project/core/usecase/usecase.dart';
import 'package:project/domain/entities/baby_profile.dart';
import 'package:project/domain/repositories/baby_profile_repo.dart';

class UpdateBabyProfileParams {
  final String id;
  final BabyProfile data;

  const UpdateBabyProfileParams({required this.id, required this.data});
}

class UpdateBabyProfile extends FutureUseCase<void, UpdateBabyProfileParams> {
  final BabyProfileRepository repository;

  UpdateBabyProfile({required this.repository});

  @override
  Future<Either<Failure, void>> call(UpdateBabyProfileParams params) =>
      repository.update(params.id, params.data);
}
