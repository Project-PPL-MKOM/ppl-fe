import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:project/core/error/failure.dart';

abstract class UseCase<Type, Params> {
  Either<Failure, Type> call(Params params);
}

abstract class FutureUseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

// This will be used by the code calling the use case whenever the use case
// doesn't accept any parameters.
class NoParams extends Equatable {
  @override
  List<Object?> get props => [];
}
