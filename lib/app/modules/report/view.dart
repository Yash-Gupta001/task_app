import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:task_app/app/core/utils/extensions.dart';
import 'package:task_app/app/modules/home/controller.dart';

class ReportPage extends StatelessWidget {
  final homeCtrl = Get.find<HomeController>();

  ReportPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade50, Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Obx(() {
            var createTasks = homeCtrl.getTotalTask();
            var completedTasks = homeCtrl.getTotalDoneTask();
            var liveTasks = (createTasks - completedTasks); // Corrected calculation for live tasks

            // Check if createTasks is zero to avoid division by zero errors
            var percent = (createTasks != 0)
                ? ((completedTasks / createTasks) * 100).toStringAsFixed(2)
                : "0%"; // Ensure no division by zero

            return ListView(
              children: [
                Padding(
                  padding: EdgeInsets.all(4.0.wp),
                  child: Text(
                    'My To Do Report',
                    style: TextStyle(
                      fontSize: 24.0.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4.0.wp),
                  child: Text(
                    DateFormat.yMMMMd().format(DateTime.now()),
                    style: TextStyle(
                      fontSize: 14.0.sp,
                      color: Colors.grey,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 3.0.wp, horizontal: 4.0.wp),
                  child: Divider(
                    thickness: 1.5,
                    color: Colors.blue.shade200,
                  ),
                ),
                // Animated Circular Step Progress Indicator
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 4.0.wp, horizontal: 4.0.wp),
                  child: Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: createTasks == 0
                          ? Center(
                              child: Text(
                                'No tasks available',
                                style: TextStyle(fontSize: 16.0.sp),
                              ),
                            )
                          : TweenAnimationBuilder(
                              tween: Tween<double>(begin: 0.0, end: completedTasks.toDouble()),
                              duration: Duration(seconds: 2),
                              builder: (context, value, child) {
                                return CircularStepProgressIndicator(
                                  totalSteps: createTasks, // Total tasks
                                  currentStep: value.toInt(), // Animated current step
                                  stepSize: 15, // Size of each step (you can adjust this)
                                  selectedColor: Colors.greenAccent, // Color for completed steps
                                  unselectedColor: Colors.grey[200], // Color for uncompleted steps
                                  padding: 0,
                                  width: 90.0.wp, // Width of the circle
                                  height: 85.0.wp, // Height of the circle
                                  selectedStepSize: 15, // Size of selected step
                                  roundedCap: (_, __) => true, // Make the step ends rounded
                                  child: Center(
                                    child: Text(
                                      '$percent%',
                                      style: TextStyle(fontSize: 16.0.sp, fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                );
                              },
                            ),
                    ),
                  ),
                ),
                // Task Statistics
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 2.0.wp, horizontal: 4.0.wp),
                  child: Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          _buildStatisticRow(Icons.assignment, 'Total Tasks', '$createTasks'),
                          SizedBox(height: 10),
                          _buildStatisticRow(Icons.check_circle, 'Completed Tasks', '$completedTasks'),
                          SizedBox(height: 10),
                          _buildStatisticRow(Icons.access_time, 'Live Tasks (Pending)', '$liveTasks'),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }

  // Helper method to build a statistic row
  Widget _buildStatisticRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, color: Colors.blue.shade600, size: 24.0.sp),
        SizedBox(width: 10),
        Text(
          label,
          style: TextStyle(
            fontSize: 16.0.sp,
            color: Colors.blue.shade800,
          ),
        ),
        Spacer(),
        Text(
          value,
          style: TextStyle(
            fontSize: 16.0.sp,
            fontWeight: FontWeight.bold,
            color: Colors.blue.shade800,
          ),
        ),
      ],
    );
  }
}
