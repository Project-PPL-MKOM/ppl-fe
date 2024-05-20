import 'package:dartz/dartz.dart';
import 'package:project/core/error/failure.dart';
import 'package:project/core/usecase/usecase.dart';
import 'package:project/domain/entities/baby_profile.dart';
import 'package:project/domain/repositories/baby_profile_repo.dart';

class AddNewBabyProfiles extends FutureUseCase<BabyProfile, BabyProfile> {
  final BabyProfileRepository repository;

  AddNewBabyProfiles({required this.repository});

  @override
  Future<Either<Failure, BabyProfile>> call(BabyProfile params) =>
      repository.add(params);
}
