import 'package:flutter/material.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class ReportPage extends StatelessWidget {
  const ReportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: CircularStepProgressIndicator(
        totalSteps: 100,
        currentStep: 72,
        selectedColor: Colors.yellow,
        unselectedColor: Colors.lightBlue,
        padding: 0,
        width: 100,
        child: Icon(
          Icons.percent,
          color: Colors.red,
          size: 84,
        ),
      )),
    );
  }
}
