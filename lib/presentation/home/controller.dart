import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/core/usecase/usecase.dart';
import 'package:project/di.dart';
import 'package:project/domain/entities/baby_profile.dart';
import 'package:project/domain/usecases/get_baby_profiles.dart';
import 'package:project/routes/app_pages.dart';

class HomeController extends GetxController {
  final loadBabiesDone = false.obs;
  final loadBabiesErrorMsg = (null as String?).obs;
  final babies = <BabyProfile>[].obs;

  @override
  void onInit() {
    super.onInit();
    reloadBabies();
  }

  @override
  void onClose() {
    loadBabiesDone.close();
    loadBabiesErrorMsg.close();
    babies.close();
    super.onClose();
  }

  Future<void> reloadBabies() async {
    loadBabiesDone.value = false;
    final task = await Injector.instance<GetBabyProfiles>();
    final result = task(NoParams());
    result.fold(
      (_) => loadBabiesErrorMsg.value = 'Terjadi kesalahan',
      (data) {
        loadBabiesErrorMsg.value = null;
        babies.replaceRange(0, babies.length, data);
      },
    );
    loadBabiesDone.value = true;
  }

  void navigateAddNewProfile() async {
    final newData = await Get.toNamed(
      AppRoutes.profile,
      arguments: {'edit': false},
    ) as BabyProfile?;
    // reloadBabies();
    if (newData != null) {
      babies.add(newData);
      Get.snackbar(
        'Tambah Profil',
        'Profil bayi berhasil dibuat',
        colorText: Colors.white,
        backgroundColor: Colors.green,
        icon: const Icon(Icons.check, color: Colors.white),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
