import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/core/theme/app_theme.dart';
import 'package:project/domain/entities/baby_profile.dart';
import 'style.dart';
import 'widgets/baby_card.dart';
import 'widgets/message_view.dart';
import 'package:searchable_listview/searchable_listview.dart';
import 'controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Daftar Nama Bayi', style: appBarTitleStyle),
          centerTitle: true,
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: AppTheme.primary800,
          shape: const CircleBorder(),
          tooltip: 'Tambah Profil Bayi',
          onPressed: () => controller.navigateAddNewProfile(),
          child: const Icon(Icons.add, color: Colors.white, size: 28),
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
          child: Obx(
            () => SearchableList<BabyProfile>(
              // ignore: invalid_use_of_protected_member
              initialList: controller.babies.value,
              itemBuilder: (BabyProfile data) => BabyCard(data: data),
              seperatorBuilder: (_, __) => const SizedBox(height: 10),
              listViewPadding: const EdgeInsets.only(bottom: 20),
              filter: (value) => controller.babies
                  .where(
                    (e) => e.name.toLowerCase().contains(value.toLowerCase()),
                  )
                  .toList(),
              emptyWidget: controller.loadBabiesErrorMsg.value == null
                  ? const MessageView(msg: 'Belum ada bayi')
                  : MessageView(
                      msg: controller.loadBabiesErrorMsg.value ?? '',
                      isError: true,
                    ),
              inputDecoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                labelText: 'Cari bayi',
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderSide: const BorderSide(width: 1.0),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: AppTheme.primary400,
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                // suffixIcon: const Icon(Icons.search),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
