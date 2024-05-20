import 'package:get_it/get_it.dart';
import 'package:project/data/datasources/local/local_ds.dart';
import 'package:project/data/repositories/app_info_repo_impl.dart';
import 'package:project/data/repositories/baby_profile_repo_impl.dart';
import 'package:project/domain/repositories/app_info_repo.dart';
import 'package:project/domain/repositories/baby_profile_repo.dart';
import 'package:project/domain/usecases/add_new_baby_profiles.dart';
import 'package:project/domain/usecases/delete_baby_profile.dart';
import 'package:project/domain/usecases/get_baby_profiles.dart';
import 'package:project/domain/usecases/is_intro_done.dart';
import 'package:project/domain/usecases/mark_is_intro_done.dart';
import 'package:project/domain/usecases/update_baby_profile.dart';

class Injector {
  final GetIt _getIt;
  Injector._() : _getIt = GetIt.instance;

  static final Injector instance = Injector._();

  void setup() {
    _registerDataSources();
    _registerRepositories();
    _registerUseCases();
  }

  void _registerDataSources() {
    _getIt.registerSingletonAsync<LocalDataSource>(() async {
      final obj = LocalDataSource();
      await obj.initDb();
      return obj;
    });
  }

  void _registerRepositories() {
    _getIt.registerSingletonWithDependencies<BabyProfileRepository>(
      () => BabyProfileRepositoryImpl(
        localDataSource: _getIt<LocalDataSource>(),
      ),
      dependsOn: [LocalDataSource],
    );
    _getIt.registerSingletonWithDependencies<AppInfoRepository>(
      () => AppInfoRepositoryImpl(
        localDataSource: _getIt<LocalDataSource>(),
      ),
      dependsOn: [LocalDataSource],
    );
  }

  void _registerUseCases() {
    _getIt.registerSingletonWithDependencies(
      () => AddNewBabyProfiles(
        repository: _getIt<BabyProfileRepository>(),
      ),
      dependsOn: [BabyProfileRepository],
    );
    _getIt.registerSingletonWithDependencies(
      () => GetBabyProfiles(
        repository: _getIt<BabyProfileRepository>(),
      ),
      dependsOn: [BabyProfileRepository],
    );
    _getIt.registerSingletonWithDependencies(
      () => UpdateBabyProfile(
        repository: _getIt<BabyProfileRepository>(),
      ),
      dependsOn: [BabyProfileRepository],
    );
    _getIt.registerSingletonWithDependencies(
      () => DeleteBabyProfile(
        repository: _getIt<BabyProfileRepository>(),
      ),
      dependsOn: [BabyProfileRepository],
    );
    _getIt.registerSingletonWithDependencies(
      () => IsIntroDone(
        repository: _getIt<AppInfoRepository>(),
      ),
      dependsOn: [AppInfoRepository],
    );
    _getIt.registerSingletonWithDependencies(
      () => MarkIsIntroDone(
        repository: _getIt<AppInfoRepository>(),
      ),
      dependsOn: [AppInfoRepository],
    );
  }

  Future<T> call<T extends Object>() async {
    await _getIt.isReady<T>();
    return _getIt.get<T>();
  }
}
