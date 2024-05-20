import 'package:project/domain/repositories/app_info_repo.dart';

class IsIntroDone {
  final AppInfoRepository repository;

  IsIntroDone({required this.repository});

  bool call() => repository.isIntroDone.fold((_) => false, (v) => v);
}
