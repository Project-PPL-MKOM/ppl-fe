import 'package:project/core/utils/ext.dart';
import 'package:project/domain/entities/baby_profile.dart';

class BabyProfileModel extends BabyProfile {
  const BabyProfileModel({
    required super.name,
    required super.bornDate,
    required super.gender,
    required super.id,
  });

  factory BabyProfileModel.fromEntity(BabyProfile data) => BabyProfileModel(
        name: data.name,
        bornDate: data.bornDate,
        gender: data.gender,
        id: data.id,
      );

  factory BabyProfileModel.fromJson(Map<dynamic, dynamic> json) =>
      BabyProfileModel(
        id: json['id'] as String,
        name: json['name'] as String,
        bornDate: (json['bornDate'] as String).toDate,
        gender: (json['gender'] as String).toGender,
      );

  Map<String, dynamic> get toJson => <String, dynamic>{
        'id': id,
        'name': name,
        'bornDate': bornDate.repr,
        'gender': gender.name,
      };

  BabyProfileModel copyWith({
    String? id,
    String? name,
    DateTime? bornDate,
    Gender? gender,
  }) {
    return BabyProfileModel(
      id: id ?? this.id,
      name: name ?? this.name,
      bornDate: bornDate ?? this.bornDate,
      gender: gender ?? this.gender,
    );
  }
}
