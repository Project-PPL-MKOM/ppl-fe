import 'package:hive_flutter/hive_flutter.dart';
import 'package:project/core/utils/uuid.dart';
import 'package:project/data/models/baby_profile.dart';

class LocalDataSource {
  bool _isInitiated = false;

  final _kInfoBox = 'app-info';
  final _kIsIntroDone = 'is-intro-done';

  final _kBabyProfilesBox = 'baby-profiles';

  Future<void> initDb() async {
    if (_isInitiated) return;
    await Hive.initFlutter();
    await Hive.openBox(_kInfoBox);
    await Hive.openBox(_kBabyProfilesBox);
    _isInitiated = true;
  }

  bool get isIntroDone {
    final box = Hive.box(_kInfoBox);
    final value = box.get(_kIsIntroDone, defaultValue: false) as bool;
    return value;
  }

  Future<void> markIsIntroDone() async {
    final box = Hive.box(_kInfoBox);
    await box.put(_kIsIntroDone, true);
  }

  List<BabyProfileModel> get babyProfiles {
    final box = Hive.box(_kBabyProfilesBox);
    final values = box.values
        .map((e) => BabyProfileModel.fromJson(e as Map<dynamic, dynamic>))
        .toList();
    return values;
  }

  Future<BabyProfileModel> addBabyProfile(BabyProfileModel data) async {
    final box = Hive.box(_kBabyProfilesBox);
    final id = uniqueId;
    final newData = data.copyWith(id: id);
    await box.put(id, newData.toJson);
    return newData;
  }

  Future<void> updateBabyProfile(String id, BabyProfileModel newData) async {
    final box = Hive.box(_kBabyProfilesBox);
    await box.put(id, newData.toJson);
  }

  Future<void> deleteBabyProfile(String id) async {
    final box = Hive.box(_kBabyProfilesBox);
    await box.delete(id);
  }
}
