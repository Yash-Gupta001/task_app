import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:task_app/app/core/utils/extensions.dart';
import 'package:task_app/app/data/models/task.dart';
import 'package:task_app/app/modules/home/controller.dart';
import 'package:get/get.dart';
import 'package:task_app/app/modules/home/widgets/task_card.dart';
import 'package:task_app/app/widgets/add_card.dart';

class Home extends GetView<HomeController> {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("Home Page"),
      // ),
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
                        onDragStarted: () => controller.changeDeleting(true),
                        onDraggableCanceled: (___,__) => controller.changeDeleting(false),
                        onDragEnd: (_) => controller.changeDeleting(false),

                        feedback: Opacity(opacity: 0.8,
                        child: TaskCard(task: element),
                        ),
                        child: TaskCard(task: element)))
                      .toList(),
                  AddCard()
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: DragTarget<Task>(
  builder: (_, __, ___) {
    return Obx( 
      () => FloatingActionButton(
        backgroundColor: controller.deleting.value ? Colors.red : Colors.blue,
        onPressed: () {
          // Add your logic for the button press if needed
        },
        child: Icon(controller.deleting.value ? Icons.delete : Icons.add),
      ),
    );
  },
  onAccept: (Task task) {
    controller.deleteTask(task);
    EasyLoading.showSuccess("Delete done");
  },
),

        
    );
  }
}
