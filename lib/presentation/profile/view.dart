import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/domain/entities/baby_profile.dart';
import 'controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

  InputDecoration _textDecoration(String label, {Widget? suffix}) =>
      InputDecoration(
        labelText: label,
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          borderSide: BorderSide(color: Colors.grey, width: 1.0),
        ),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          borderSide: BorderSide(color: Colors.grey, width: 1.0),
        ),
        suffixIcon: suffix,
      );

  @override
  Widget build(BuildContext context) {
    // return BackButtonListener(
    //   onBackButtonPressed: () async {
    //     final isConfirmed = await controller.displayBackWarning();
    //     return !isConfirmed;
    //   },
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        if (didPop) return;
        final isConfirmed = await controller.displayBackWarning();
        if (isConfirmed) Get.back();
      },
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title:
                Text('${controller.isEditingMode ? 'Edit' : 'Tambah'} Profile'),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new, size: 24.0),
              tooltip: 'Kembali',
              onPressed: () async {
                final isConfirmed = await controller.displayBackWarning();
                if (isConfirmed) Get.back();
              },
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: controller.formKey,
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    TextFormField(
                      controller: controller.nameCtrl,
                      decoration: _textDecoration('Nama'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: controller.dateCtrl,
                      readOnly: true,
                      onTap: () => controller.openDatePicker(context),
                      decoration: _textDecoration(
                        'Tanggal lahir',
                        suffix: const Icon(Icons.date_range_outlined),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    const Text('Jenis kelamin'),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        Expanded(
                          child: Obx(
                            () => ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor: WidgetStateProperty.all(
                                  controller.gender.value == Gender.male
                                      ? Colors.grey
                                      : Colors.white,
                                ),
                                shape: WidgetStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    side: const BorderSide(color: Colors.black),
                                  ),
                                ),
                              ),
                              onPressed: () =>
                                  controller.gender.value = Gender.male,
                              child: Text(
                                'Laki-laki',
                                style: TextStyle(
                                  color: controller.gender.value == Gender.male
                                      ? Colors.white
                                      : Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: Obx(
                            () => ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor: WidgetStateProperty.all(
                                  controller.gender.value == Gender.female
                                      ? Colors.grey
                                      : Colors.white,
                                ),
                                shape: WidgetStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    side: const BorderSide(color: Colors.black),
                                  ),
                                ),
                              ),
                              onPressed: () =>
                                  controller.gender.value = Gender.female,
                              child: Text(
                                'Perempuan',
                                style: TextStyle(
                                  color:
                                      controller.gender.value == Gender.female
                                          ? Colors.white
                                          : Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          minimumSize: const Size.fromHeight(60)),
                      onPressed: controller.addNewProfile,
                      child: const Text("Submit"),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
