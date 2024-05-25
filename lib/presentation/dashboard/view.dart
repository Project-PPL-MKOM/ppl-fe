import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/core/theme/app_theme.dart';
import 'package:project/core/widgets/appbar.dart';
import 'package:project/presentation/dashboard/controller.dart';
import 'widgets/display_profile.dart';

class DashboardView extends GetView<DashboardController> {
  const DashboardView({super.key});

  Widget _buttonMenu(String label, void Function() onTap) => Expanded(
        child: GestureDetector(
          onTap: onTap,
          child: Container(
            height: 84,
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 18),
            decoration: BoxDecoration(
              color: AppTheme.grey200,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              label,
              textAlign: TextAlign.center,
              style: AppTheme.family.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(
        title: 'Dashboard',
        withBack: true,
        onBack: () => Get.back(),
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
            const SizedBox(height: 24),
            Row(
              children: [
                _buttonMenu(
                  'Hitung Tinggi Badan',
                  controller.navigateCalculate,
                ),
                const SizedBox(width: 16),
                _buttonMenu(
                  'Riwayat Perhitungan',
                  controller.navigateHistory,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
