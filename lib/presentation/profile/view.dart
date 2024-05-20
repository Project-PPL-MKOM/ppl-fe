import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/core/theme/app_theme.dart';
import 'package:project/domain/entities/baby_profile.dart';
import 'controller.dart';
import 'style.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

  String get _appTitle =>
      '${controller.isEditingMode ? 'Edit' : 'Tambah'} Profil Bayi';

  Widget _labelText(String label) => Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Text(label, style: labelTextStyle),
      );

  InputDecoration _textDecoration(String hint, {Widget? suffix}) =>
      InputDecoration(
        contentPadding:
            const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        isCollapsed: true,
        hintText: hint,
        hintStyle: hintTextStyle,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          borderSide: BorderSide(color: AppTheme.grey, width: 1.0),
        ),
        suffixIcon: suffix,
      );

  Widget _genderButton(Gender gender) => Expanded(
        child: Obx(
          () => ElevatedButton(
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all(
                controller.gender.value == gender
                    ? AppTheme.dark
                    : const Color(0xFFEEEEEE),
              ),
              shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
            ),
            onPressed: () => controller.gender.value = gender,
            child: Text(
              gender == Gender.male ? 'Laki-laki' : 'Perempuan',
              style: AppTheme.family.copyWith(
                fontSize: 16,
                color: controller.gender.value == gender
                    ? Colors.white
                    : AppTheme.dark,
              ),
            ),
          ),
        ),
      );

  Widget _acionButton(String label, Color color, void Function()? onPressed) =>
      ElevatedButton(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size.fromHeight(54),
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16), // button's shape
          ),
        ),
        onPressed: onPressed,
        child: Text(
          label,
          style: AppTheme.family.copyWith(
            fontSize: 18,
            color: Colors.white,
          ),
        ),
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
          appBar: AppBar(
            title: Text(_appTitle, style: appBarTitleStyle),
            centerTitle: true,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new, size: 18.0),
              tooltip: 'Kembali',
              onPressed: controller.onBackInvoked,
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(24),
            child: Form(
              key: controller.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _labelText('Nama'),
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
                  const SizedBox(height: 20),
                  _labelText('Tanggal lahir'),
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
                  const SizedBox(height: 20),
                  _labelText('Jenis Kelamin'),
                  Row(
                    children: [
                      _genderButton(Gender.male),
                      const SizedBox(width: 20),
                      _genderButton(Gender.female),
                    ],
                  ),
                  const Spacer(),
                  _acionButton(
                    'Tambah',
                    AppTheme.primary800,
                    controller.addNewProfile,
                  ),
                  const SizedBox(height: 16),
                  _acionButton(
                    'Batal',
                    AppTheme.red,
                    controller.onBackInvoked,
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
