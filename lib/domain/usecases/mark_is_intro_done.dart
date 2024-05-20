import 'package:project/domain/repositories/app_info_repo.dart';

class MarkIsIntroDone {
  final AppInfoRepository repository;

  MarkIsIntroDone({required this.repository});

  Future<void> call() async => await repository.markIsIntroDone();
}
