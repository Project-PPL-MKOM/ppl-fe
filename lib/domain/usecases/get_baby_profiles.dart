import 'package:dartz/dartz.dart';
import 'package:project/core/error/failure.dart';
import 'package:project/core/usecase/usecase.dart';
import 'package:project/domain/entities/baby_profile.dart';
import 'package:project/domain/repositories/baby_profile_repo.dart';

class GetBabyProfiles extends UseCase<List<BabyProfile>, NoParams> {
  final BabyProfileRepository repository;

  GetBabyProfiles({required this.repository});

  @override
  Either<Failure, List<BabyProfile>> call(NoParams params) => repository.babies;
}
