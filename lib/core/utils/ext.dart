import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:project/domain/entities/baby_profile.dart';

extension DateExt on DateTime {
  String get repr => DateFormat('dd-MM-yyyy').format(this);
}

extension StrExt on String {
  DateTime get toDate =>
      DateFormat('dd-MM-yyyy').tryParse(this) ?? DateTime.now();

  Gender get toGender =>
      Gender.values.firstWhereOrNull((g) => g.name == this) ?? Gender.male;
}
