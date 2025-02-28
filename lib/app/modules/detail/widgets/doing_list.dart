import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_app/app/core/utils/extensions.dart'; // Ensure this is correct
import 'package:task_app/app/modules/home/controller.dart';

class DoingList extends StatelessWidget {
  final homeCtrl = Get.find<HomeController>();

  DoingList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var task = homeCtrl.task.value;
    final color = HexColor.fromHex(task!.color);
    return Obx(
      () {
        return homeCtrl.doingTodos.isEmpty && homeCtrl.doneTodos.isEmpty
            ? Column(
                children: [
                  SizedBox(height: 25.0.wp),
                  Image.asset(
                    'assets/images/task.webp',
                    fit: BoxFit.cover,
                    width: 65.0.wp,
                  ),
                  Text(
                    'Add Task',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 8.0.wp,
                      color: color,
                    ),
                  ),
                  SizedBox(height: 6.0.wp),
                ],
              )
            : ListView(
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                children: [
                  ...homeCtrl.doingTodos
                      .map((element) => Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 3.0.wp, horizontal: 9.0.wp),
                            child: Row(
                              children: [
                                SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: Checkbox(
                                    fillColor:
                                        MaterialStateProperty.resolveWith(
                                            (states) => Colors.white),
                                    value: element['done'],
                                    onChanged: (bool? value) {
                                      homeCtrl.doneTodo(element['title']);
                                    },
                                  ),
                                ),


                                // Wrap text with Container or Flexible
                                Flexible(
                                  child: Container(
                                    // constraints: BoxConstraints(
                                    //   maxWidth: Get.width - 60.0.wp, // limit width for Text widget
                                    // ),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 4.0.wp),
                                      child: Text(
                                        element['title'],
                                        style: TextStyle(
                                          fontSize: 14.0.sp,
                                        ),
                                        overflow: TextOverflow.ellipsis, // Adds ellipsis at the end if text overflows
                                        maxLines: 10, // Limit text to 10 lines
                                      ),
                                    ),
                                  ),
                                )


                                
                              ],
                            ),
                          ))
                      .toList(),
                ],
              );
      },
    );
  }
}
