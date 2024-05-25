import 'package:get_it/get_it.dart';
import 'package:project/data/datasources/local/local_ds.dart';
import 'package:project/data/datasources/remote/remote_ds.dart';
import 'package:project/data/repositories/repository.dart';
import 'package:project/domain/repositories/repository.dart';
import 'package:project/domain/usecases/usecase.dart';

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
    _getIt.registerSingletonAsync(() async => RemoteDataSource());
  }

  void _registerRepositories() {
    _getIt.registerSingletonWithDependencies<BabyProfileRepository>(
      () => BabyProfileRepositoryImpl(
        localDataSource: _getIt<LocalDataSource>(),
      ),
      dependsOn: [LocalDataSource],
    );
    _getIt.registerSingletonWithDependencies<BabyHeightRepository>(
      () => BabyHeightRepositoryImpl(
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
    _getIt.registerSingletonWithDependencies<CalculationRepository>(
      () => CalculationRepositoryImpl(
        remoteDataSource: _getIt<RemoteDataSource>(),
      ),
      dependsOn: [RemoteDataSource],
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
      () => AddBabyHeight(
        repository: _getIt<BabyHeightRepository>(),
      ),
      dependsOn: [BabyHeightRepository],
    );
    _getIt.registerSingletonWithDependencies(
      () => GetBabyHeights(
        repository: _getIt<BabyHeightRepository>(),
      ),
      dependsOn: [BabyHeightRepository],
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
    _getIt.registerSingletonWithDependencies(
      () => ProcessData(
        repository: _getIt<CalculationRepository>(),
      ),
      dependsOn: [CalculationRepository],
    );
  }

  Future<T> call<T extends Object>() async {
    await _getIt.isReady<T>();
    return _getIt.get<T>();
  }
}
