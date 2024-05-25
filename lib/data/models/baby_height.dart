import 'package:project/domain/entities/baby_height.dart';

class BabyHeightModel extends BabyHeight {
  const BabyHeightModel({
    required super.id,
    required super.babyId,
    required super.height,
    required super.timestamp,
  });

  factory BabyHeightModel.fromEntity(BabyHeight data) => BabyHeightModel(
        id: data.id,
        babyId: data.babyId,
        timestamp: data.timestamp,
        height: data.height,
      );

  factory BabyHeightModel.fromJson(Map<dynamic, dynamic> json) =>
      BabyHeightModel(
        id: json['id'] as String,
        babyId: json['babyId'] as String,
        height: json['height'] as double,
        timestamp: json['timestamp'] as DateTime,
      );

  Map<String, dynamic> get toJson => <String, dynamic>{
        'id': id,
        'babyId': babyId,
        'timestamp': timestamp,
        'height': height,
      };

  BabyHeightModel copyWith({
    String? id,
    String? babyId,
    double? height,
    DateTime? timestamp,
  }) {
    return BabyHeightModel(
      id: id ?? this.id,
      babyId: babyId ?? this.babyId,
      height: height ?? this.height,
      timestamp: timestamp ?? this.timestamp,
    );
  }
}
