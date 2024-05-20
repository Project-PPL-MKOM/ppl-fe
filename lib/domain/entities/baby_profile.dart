import 'package:equatable/equatable.dart';
import 'package:project/core/utils/ext.dart';

enum Gender {
  male('M'),
  female('F');

  final String name;

  const Gender(this.name);

  @override
  String toString() => name;
}

class BabyProfile extends Equatable {
  final String id;
  final String name;
  final DateTime bornDate;
  final Gender gender;

  const BabyProfile({
    required this.id,
    required this.name,
    required this.bornDate,
    required this.gender,
  });

  factory BabyProfile.noId({
    required String name,
    required DateTime bornDate,
    required Gender gender,
  }) =>
      BabyProfile(id: '', name: name, bornDate: bornDate, gender: gender);

  @override
  List<Object?> get props => [id, name, bornDate.repr, gender];
}
