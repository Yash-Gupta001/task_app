import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:task_app/app/core/utils/extensions.dart';
import 'package:task_app/app/core/values/colors.dart';
import 'package:task_app/app/data/models/task.dart';
import 'package:task_app/app/modules/home/controller.dart';
import 'package:task_app/app/widgets/icons.dart';

class AddCard extends StatelessWidget {
  final homeCtrl = Get.find<HomeController>();
  AddCard({super.key});

  @override
  Widget build(BuildContext context) {
    final icons = getIcons();
    var squareWidth = Get.width - 12.0.wp;

    return Container(
      width: squareWidth / 2,
      height: squareWidth / 2,
      margin: EdgeInsets.all(3.0.wp),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        // boxShadow: [
        //   BoxShadow(
        //     color: Colors.black.withOpacity(0.1),
        //     offset: Offset(0, 4),
        //     blurRadius: 6,
        //   ),
        // ],
      ),
      child: InkWell(
        onTap: () async {
          await Get.defaultDialog(
            titlePadding: EdgeInsets.symmetric(vertical: 5.0.wp),
            radius: 5,
            title: 'Task Type',
            content: Form(
              key: homeCtrl.formKey,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 3.0.wp),
                    child: TextFormField(
                      controller: homeCtrl.editCtrl,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Title',
                        labelStyle: TextStyle(color: blue),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Enter your task title';
                        }
                        return null;
                      },
                    ),
                  ),
                  Wrap(
                    spacing: 2.0.wp,
                    children: icons
                        .map((e) {
                          return Obx(() {
                            int index = icons.indexOf(e);
                            return ChoiceChip(
                              label: e,
                              selected: homeCtrl.chipIndex.value == index,
                              onSelected: (bool selected) {
                                homeCtrl.chipIndex.value = selected ? index : -1;
                              },
                              // selectedColor: blue, 
                              backgroundColor: Colors.grey[300], 
                              labelStyle: TextStyle(
                                  color: homeCtrl.chipIndex.value == index
                                      ? Colors.white
                                      : Colors.black),
                            );
                          });
                        })
                        .toList(),
                  ),
                  SizedBox(height: 4.0.wp),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30), 
                      ),
                      minimumSize: Size(150, 50),
                      elevation: 3,
                    ),
                    onPressed: () {
                      if (homeCtrl.formKey.currentState!.validate()) {
                        int icon = icons[homeCtrl.chipIndex.value].icon!.codePoint;
                        String color = icons[homeCtrl.chipIndex.value].color!.toHex();
                        var task = Task(
                          title: homeCtrl.editCtrl.text, 
                          icon: icon, 
                          color: color);
              
                      Get.back();
                      homeCtrl.addTask(task)
                      ? EasyLoading.showSuccess("Task Created") :
                      EasyLoading.showError("Duplicate Task");
                      }
                    },
                    child: Text(
                      "Add Task",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
          );
          homeCtrl.editCtrl.clear();
          homeCtrl.changeChipIndex(-1);
        },
        child: DottedBorder(
          color: Colors.grey[400]!,
          dashPattern: [8, 4],
          borderType: BorderType.RRect,
          radius: Radius.circular(20),
          child: Center(
            child: Icon(
              Icons.add,
              size: 12.0.wp,
              color: Colors.grey, 
            ),
          ),
        ),
      ),
    );
  }
}