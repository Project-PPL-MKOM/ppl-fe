import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/presentation/dashboard/controller.dart';

import 'style.dart';
import 'widgets/display_profile.dart';

class DashboardView extends GetView<DashboardController> {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard', style: appBarTitleStyle),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 18.0),
          tooltip: 'Kembali',
          onPressed: () => Get.back(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          children: [
            GestureDetector(
              onTap: controller.navigateEditProfile,
              child: Obx(
                () => DisplayProfile(data: controller.dataProfile.value),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
