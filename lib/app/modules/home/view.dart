import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:task_app/app/core/utils/extensions.dart';
import 'package:task_app/app/data/models/task.dart';
import 'package:task_app/app/modules/home/controller.dart';
import 'package:get/get.dart';
import 'package:task_app/app/modules/home/widgets/add_dialog.dart';
import 'package:task_app/app/modules/home/widgets/task_card.dart';
import 'package:task_app/app/modules/home/widgets/add_card.dart';

class Home extends GetView<HomeController> {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SafeArea(
          child: ListView(
            children: [
              Padding(
                padding: EdgeInsets.all(4.0.wp),
                child: Text(
                  'My List',
                  style: TextStyle(
                    fontSize: 24.0.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Obx(
                () => GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  children: [
                    ...controller.tasks
                        .map((element) => LongPressDraggable(
                              data: element,
                              onDragStarted: () =>
                                  controller.changeDeleting(true),
                              onDraggableCanceled: (___, __) =>
                                  controller.changeDeleting(false),
                              onDragEnd: (_) =>
                                  controller.changeDeleting(false),
                              feedback: Opacity(
                                opacity: 0.8,
                                child: TaskCard(task: element),
                              ),
                              child: TaskCard(task: element),
                            ))
                        .toList(),
                    AddCard(),
                  ],
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: DragTarget<Task>(
          builder: (_, __, ___) {
            return Obx(
              () => AnimatedContainer(
                duration: Duration(milliseconds: 300), // Animation duration
                width: controller.deleting.value
                    ? MediaQuery.of(context).size.width * 0.9 // 90% width
                    : 56.0, // Default FAB size
                height: 56.0, // Default FAB height
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: controller.deleting.value ? Colors.red : Colors.blue,
                  borderRadius: BorderRadius.circular(controller.deleting.value
                      ? 12.0
                      : 28.0), // Rounded corners
                ),
                child: FloatingActionButton(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  onPressed: () {
                    if (controller.tasks.isNotEmpty) {
                      Get.to(
                        () => AddDialog(),
                        transition: Transition.downToUp,
                      );
                    } else{
                      EasyLoading.showInfo("create task type first");
                    }
                  },
                  child: Icon(
                    controller.deleting.value ? Icons.delete : Icons.add,
                    color: Colors.white,
                  ),
                ),
              ),
            );
          },
          onAccept: (Task task) {
            // Show a confirmation dialog before deleting the task
            Get.dialog(
              AlertDialog(
                title: Text('Delete Task'),
                content:
                    Text('Are you sure you want to delete ${task.title} ?'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Get.back(); // Close the dialog
                    },
                    child: Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () {
                      controller.deleteTask(task); // Delete the task
                      EasyLoading.showSuccess("Delete done");
                      Get.back(); // Close the dialog
                    },
                    child: Text(
                      'Delete',
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
