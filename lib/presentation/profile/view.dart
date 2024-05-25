import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/core/theme/app_theme.dart';
import 'package:project/core/widgets/appbar.dart';
import 'package:project/core/widgets/button.dart';
import 'package:project/domain/entities/baby_profile.dart';
import 'package:project/presentation/profile/widget.dart';
import 'controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

  String get _appTitle =>
      '${controller.isEditingMode ? 'Edit' : 'Tambah'} Profil Bayi';

  InputDecoration _textDecoration(String hint, {Widget? suffix}) =>
      InputDecoration(
        contentPadding:
            const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        isCollapsed: true,
        hintText: hint,
        hintStyle: AppTheme.family.copyWith(
          fontSize: 14,
          color: AppTheme.grey,
        ),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          borderSide: BorderSide(color: AppTheme.grey, width: 1.0),
        ),
        suffixIcon: suffix,
      );

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        if (didPop) return;
        await controller.onBackInvoked();
      },
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: appBar(
            title: _appTitle,
            withBack: true,
            onBack: controller.onBackInvoked,
          ),
          body: Padding(
            padding: const EdgeInsets.all(24),
            child: Form(
              key: controller.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  labelText('Nama'),
                  TextFormField(
                    controller: controller.nameCtrl,
                    decoration: _textDecoration('Masukkan nama'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Nama tidak boleh kososng';
                      }
                      return null;
                    },
                  ),
                  space,
                  labelText('Tanggal lahir'),
                  TextFormField(
                    controller: controller.dateCtrl,
                    readOnly: true,
                    onTap: () => controller.openDatePicker(context),
                    decoration: _textDecoration(
                      'Masukkan tanggal lahir',
                      suffix: const Icon(Icons.date_range_outlined),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Tanggal lahir tidak boleh kosong';
                      }
                      return null;
                    },
                  ),
                  space,
                  labelText('Jenis Kelamin'),
                  Row(
                    children: [
                      Obx(
                        () => genderButton(
                          gender: Gender.male,
                          selected: controller.gender.value == Gender.male,
                          onSelected: () =>
                              controller.gender.value = Gender.male,
                        ),
                      ),
                      const SizedBox(width: 20),
                      Obx(
                        () => genderButton(
                          gender: Gender.female,
                          selected: controller.gender.value == Gender.female,
                          onSelected: () =>
                              controller.gender.value = Gender.female,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  actionButton(
                    label: controller.isEditingMode ? 'Simpan' : 'Tambah',
                    color: AppTheme.primary800,
                    onPressed: controller.isEditingMode
                        ? controller.updateProfile
                        : controller.addNewProfile,
                  ),
                  const SizedBox(height: 16),
                  actionButton(
                    label: 'Batal',
                    color: AppTheme.red,
                    onPressed: controller.onBackInvoked,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
