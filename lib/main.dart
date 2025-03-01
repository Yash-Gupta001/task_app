import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:task_app/app/data/services/storage/services.dart';
import 'package:task_app/app/modules/home/binding.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:task_app/app/modules/splash/splash.dart';

// import 'app/modules/home/view.dart';

void main() async {
  await GetStorage.init();
  await Get.putAsync(() => StorageService().init());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Task app using getx',
      home: Splash(),
      initialBinding: HomeBinding(),
      builder: EasyLoading.init(),
    );
  }
}