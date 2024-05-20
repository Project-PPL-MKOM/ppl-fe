import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:project/core/utils/ext.dart';
import 'package:project/di.dart';
import 'package:project/domain/entities/baby_profile.dart';
import 'package:project/domain/usecases/add_new_baby_profiles.dart';
import 'package:project/presentation/profile/widgets/confirm_dialog.dart';

class ProfileController extends GetxController {
  final formKey = GlobalKey<FormState>();
  bool isEditingMode = false;

  final nameCtrl = TextEditingController();
  final dateCtrl = TextEditingController();
  final gender = Gender.male.obs;

  @override
  void onInit() {
    dynamic arg = Get.arguments;
    if (arg is Map<String, dynamic> && arg['edit'] is bool) {
      isEditingMode = arg['edit'];
      if (isEditingMode && arg['data'] is BabyProfile) {
        BabyProfile data = arg['data'];
        nameCtrl.text = data.name;
        dateCtrl.text = data.bornDate.repr;
        gender.value = data.gender;
      }
    }
    super.onInit();
  }

  @override
  void onClose() {
    nameCtrl.dispose();
    dateCtrl.dispose();
    gender.close();
    super.onClose();
  }

  Future<void> openDatePicker(BuildContext context) async {
    final curDate = DateFormat('dd-MM-yyyy').tryParse(dateCtrl.text);
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: curDate ?? DateTime.now(),
      firstDate: DateTime(2015),
      lastDate: DateTime(2050),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context),
          child: child!,
        );
      },
    );

    if (pickedDate != null) {
      final dateStr = DateFormat('dd-MM-yyyy').format(pickedDate);
      dateCtrl.value = TextEditingValue(
        text: dateStr,
        selection: TextSelection.fromPosition(
          TextPosition(offset: dateStr.length),
        ),
      );
    }
  }

  Future<bool> displayBackWarning() async {
    bool? confirm = await Get.dialog(const ConfirmDialog());
    return confirm ?? false;
  }

  Future<void> addNewProfile() async {
    final isValid = formKey.currentState?.validate() ?? false;
    if (!isValid) return;
    final task = await Injector.instance<AddNewBabyProfiles>();
    final data = BabyProfile.noId(
      name: nameCtrl.text,
      bornDate: dateCtrl.text.toDate,
      gender: gender.value,
    );
    final result = await task(data);
    final newData = result.fold((_) => null, (v) => v);
    if (newData == null) {
      Get.snackbar(
        'Tambah Profil',
        'Profil bayi gagal dibuat',
        colorText: Colors.white,
        backgroundColor: Colors.red,
        icon: const Icon(Icons.error, color: Colors.white),
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }
    Get.back(result: newData);
  }
}
