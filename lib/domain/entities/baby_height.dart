import 'package:equatable/equatable.dart';

class BabyHeight extends Equatable {
  final String id, babyId;
  final double height;
  final DateTime timestamp;

  const BabyHeight({
    required this.id,
    required this.babyId,
    required this.height,
    required this.timestamp,
  });

  factory BabyHeight.noId({
    required String babyId,
    required double height,
    required DateTime timestamp,
  }) =>
      BabyHeight(
        id: '',
        babyId: babyId,
        height: height,
        timestamp: timestamp,
      );

  @override
  List<Object?> get props => [id, babyId, height, timestamp];
}
