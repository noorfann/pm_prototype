import 'package:flutter/material.dart';
import 'package:pm_prototype/presentation/profile_matching/task/task_form_screen.dart';

class TaskScreen extends StatelessWidget {
  const TaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [TaskFormScreen()],
    );
  }
}
