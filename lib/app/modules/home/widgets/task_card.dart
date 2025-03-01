import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_app/app/core/utils/extensions.dart';
import 'package:task_app/app/data/models/task.dart';
import 'package:task_app/app/modules/detail/view.dart';
import 'package:task_app/app/modules/home/controller.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class TaskCard extends StatelessWidget {
  final homeCtrl = Get.find<HomeController>();
  final Task task;

  TaskCard({Key? key, required this.task}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = HexColor.fromHex(task.color); // Task color
    final squareWidth = Get.width - 12.0.wp; // Width of the square card

    // Calculate dynamic progress
    final totalSteps = homeCtrl.isTodosEmpty(task) ? 1 : task.todos?.length ?? 0;
    final currentStep = homeCtrl.isTodosEmpty(task) ? 0 : homeCtrl.getDoneTodo(task);

    return GestureDetector(
      onTap: () {
        homeCtrl.changeTask(task);
        homeCtrl.changeTodos(task.todos ?? []);
        Get.to(() => DetailPage(),
          transition: Transition.rightToLeft,
        );
      },
      child: Container(
        width: squareWidth / 2,
        height: squareWidth / 2,
        margin: EdgeInsets.all(3.0.wp),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white,color.withOpacity(0.3)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey[300]!,
              blurRadius: 7,
              offset: Offset(0, 7),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // StepProgressIndicator
            StepProgressIndicator(
              roundedEdges: Radius.circular(10.0.wp),
              totalSteps: totalSteps,
              currentStep: currentStep,
              size: 5,
              padding: 0,
              selectedGradientColor: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomLeft,
                colors: [color.withOpacity(0.5), color],
              ),
              unselectedGradientColor: LinearGradient(
                colors: [Colors.white, Colors.white],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(6.0.wp),
              child: task.icon != null
                  ? Icon(
                      IconData(task.icon, fontFamily: 'MaterialIcons'),
                      color: color,
                      size: 24,
                    )
                  : SizedBox(), 
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(4.0.wp),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      task.title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12.0.sp,
                      ),
                    ),
                    SizedBox(height: 2.0.wp),
                    Text(
                      '${task.todos?.length ?? 0} Task${(task.todos?.length ?? 0) > 1 ? 's' : ''}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[100],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
