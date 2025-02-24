import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:task_app/app/data/models/task.dart';
import 'package:task_app/app/data/services/storage/repository.dart';

class HomeController extends GetxController {
   TaskRepository taskRepository;

  // Constructor to inject the repository
  HomeController({required this.taskRepository});

  final formKey = GlobalKey<FormState>();
  final editCtrl = TextEditingController();
  final chipIndex = 0.obs;
  final tasks = <Task>[].obs;

  @override
  void onInit() {
    super.onInit();
    tasks.assignAll(taskRepository.readTasks());
    ever(tasks, (_) => taskRepository.writeTasks(tasks));
  }

  @override
  void onClose() {
    super.onClose();
  }

  void changeChipIndex(int value){
    chipIndex.value = value;
  }

  
}