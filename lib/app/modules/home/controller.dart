import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:task_app/app/data/models/task.dart';
import 'package:task_app/app/data/services/storage/repository.dart';

class HomeController extends GetxController {
  final TaskRepository taskRepository;

  // Constructor to inject the repository
  HomeController({required this.taskRepository});

  final formKey = GlobalKey<FormState>();
  final editCtrl = TextEditingController();
  final chipIndex = 0.obs;
  final deleting = false.obs;
  final tasks = <Task>[].obs;

  @override
  void onInit() {
    super.onInit();
    tasks.assignAll(taskRepository.readTasks());
    ever(tasks, (_) => taskRepository.writeTasks(tasks));
  }

  void changeDeleting(bool value) {
    deleting.value = value;
  }

  @override
  void onClose() {
    editCtrl.dispose();
    super.onClose();
  }

  void changeChipIndex(int value) {
    chipIndex.value = value;
  }

  bool addTask(Task task) {
    if (tasks.contains(task)) {
      return false;
    }
    tasks.add(task);
    return true;
  }

  // New method for deleting a task
  void deleteTask(Task task) {
    tasks.remove(task); 
  }
}
