import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_app/app/core/utils/extensions.dart';
import 'package:task_app/app/modules/home/controller.dart';

class DoneList extends StatelessWidget {
  DoneList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final homeCtrl = Get.find<HomeController>();
    var task = homeCtrl.task.value;
    final color = HexColor.fromHex(task!.color);

    return Obx(
      () => homeCtrl.doneTodos.isNotEmpty
          ? ListView(
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              children: [
                Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: 2.0.wp, horizontal: 5.0.wp),
                    child: Text(
                      'Completed ${homeCtrl.doneTodos.length}',
                      style: TextStyle(fontSize: 14.0.sp, color: Colors.grey),
                    )),
                ...homeCtrl.doneTodos.map((element) {
                  return Dismissible(
                    key: ObjectKey(element),
                    direction: DismissDirection.endToStart,
                    onDismissed: (_) {
                      // Delay the removal of the task to ensure the animation finishes first
                      Future.delayed(Duration(milliseconds: 300), () {
                        homeCtrl.deleteDoneToDo(element);
                      });
                    },
                    background: Container(
                      color: Colors.red.withOpacity(0.8),
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: EdgeInsets.only(right: 5.0.wp),
                        child: Icon(
                          Icons.delete,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 3.0.wp,
                        horizontal: 9.0.wp,
                      ),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 20,
                            height: 20,
                            child: Icon(
                              Icons.done,
                              color: color,
                            ),
                          ),
                          Flexible(
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 4.0.wp),
                              child: Text(
                                element['title'],
                                style: TextStyle(
                                  fontSize: 25,
                                  decoration: TextDecoration.lineThrough,
                                  decorationColor: color,
                                ),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 10, // Limit text to 10 lines
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ],
            )
          : Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0.wp),
              child: Text(
                'No task completed yet...',
                style: TextStyle(fontSize: 14.0.sp, color: Colors.grey),
              ),
            ),
    );
  }
}
