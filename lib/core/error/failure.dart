import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  // If the subclasses have some properties, they'll get passed to this constructor
  // so that Equatable can perform value comparison.
  final String message;
  const Failure(this.message);

  @override
  List<Object?> get props => [];
}

// General failures
class ServerFailure extends Failure {
  const ServerFailure(super.message);

  @override
  List<Object?> get props => [message];
}

class LocalFailure extends Failure {
  const LocalFailure(super.message);

  @override
  List<Object?> get props => [message];
}
