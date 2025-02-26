import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:task_app/app/core/utils/extensions.dart';
import 'package:task_app/app/modules/home/controller.dart';

class AddDialog extends StatefulWidget {
  final homeCtrl = Get.find<HomeController>();
  AddDialog({Key? key}) : super(key: key);

  @override
  State<AddDialog> createState() => _AddDialogState();
}

class _AddDialogState extends State<AddDialog> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Form(
          key: widget.homeCtrl.formKey,
          child: ListView(
            children: [
              Padding(
                padding: EdgeInsets.all(3.0.wp),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {
                        Get.back();
                        widget.homeCtrl.editCtrl.clear();
                        widget.homeCtrl.changeTask(null);
                      },
                      icon: Icon(Icons.close),
                    ),
                    TextButton(
                      style: ButtonStyle(
                        overlayColor: WidgetStateProperty.all(Colors.transparent),
                      ),
                      onPressed: _onDonePressed,
                      child: Text(
                        "Done",
                        style: TextStyle(
                          fontSize: 14.0.sp,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.0.wp),
                child: Text(
                  'New Task',
                  style: TextStyle(
                    fontSize: 20.0.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.0.wp),
                child: TextFormField(
                  controller: widget.homeCtrl.editCtrl,
                  decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey[400]!,
                      ),
                    ),
                  ),
                  autofocus: false,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter your To Do...';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: 5.0.wp,
                  left: 5.0.wp,
                  right: 5.0.wp,
                  bottom: 2.0.wp,
                ),
                child: Text(
                  'Add to',
                  style: TextStyle(
                    fontSize: 14.0.sp,
                    color: Colors.grey,
                  ),
                ),
              ),
              ...widget.homeCtrl.tasks.map((element) => Obx(
                    () => InkWell(
                      onTap: () => widget.homeCtrl.changeTask(element),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 3.0.wp, horizontal: 5.0.wp),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  IconData(
                                    element.icon,
                                    fontFamily: 'MaterialIcons',
                                  ),
                                  color: HexColor.fromHex(element.color),
                                ),
                                SizedBox(width: 3.0.wp),
                                Text(
                                  element.title,
                                  style: TextStyle(
                                    fontSize: 12.0.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            if (widget.homeCtrl.task.value == element)
                              const Icon(
                                Icons.check,
                                color: Colors.blue,
                              ),
                          ],
                        ),
                      ),
                    ),
                  )).toList(),
            ],
          ),
        ),
      ),
    );
  }

  void _onDonePressed() {
    if (widget.homeCtrl.formKey.currentState!.validate()) {
      if (widget.homeCtrl.task.value == null) {
        EasyLoading.showError('Please select a task type');
      } else {
        var success = widget.homeCtrl.updateTask(
          widget.homeCtrl.task.value!,
          widget.homeCtrl.editCtrl.text,
        );
        if (success) {
          EasyLoading.showSuccess(
              '${widget.homeCtrl.task.value!.title} item added successfully');
          Get.back();
          widget.homeCtrl.changeTask(null);
        } else {
          EasyLoading.showError('To Do item already exists');
        }
        widget.homeCtrl.editCtrl.clear();
      }
    }
  }
}