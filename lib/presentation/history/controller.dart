import 'package:get/get.dart';
import 'package:project/di.dart';
import 'package:project/domain/entities/baby_height.dart';
import 'package:project/domain/usecases/get_baby_heights.dart';

class HistoryController extends GetxController {
  String babyId = '';
  final heights = <BabyHeight>[].obs;
  final loadDone = true.obs;

  @override
  void onInit() {
    dynamic arg = Get.arguments;
    if (arg is String) {
      babyId = arg;
    }
    super.onInit();
    loadData();
  }

  Future<void> loadData() async {
    loadDone.value = false;
    final task = await Injector.instance<GetBabyHeights>();
    final result = task(babyId);
    result.fold(
      (_) {},
      (data) {
        heights.replaceRange(0, heights.length, data);
      },
    );
    loadDone.value = true;
    heights.refresh();
  }
}
