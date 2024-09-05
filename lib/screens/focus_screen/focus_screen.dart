import 'package:cs_three_things/base/task_tile.dart';
import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:provider/provider.dart';

import '../../base/database/task_database.dart';
import '../../base/models/task.dart';

class FocusScreen extends StatefulWidget {
  const FocusScreen({super.key});

  @override
  State<FocusScreen> createState() => _FocusScreenState();
}

class _FocusScreenState extends State<FocusScreen> {
  List<Task>? tasks;

  @override
  void initState() {
    Provider.of<TaskDatabase>(context, listen: false).readFocusTasks();
    super.initState();
  }

  void _setTaskToFocus(Task task) {
    bool isFocused = false;
    Provider.of<TaskDatabase>(context, listen: false)
        .updateTaskFocus(task.id, isFocused);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskDatabase>(
      builder: (context, value, child) => Column(
        children: [
          const Center(
            child: Text('data'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: value.focusTaskList.length,
              itemBuilder: (context, index) {
                Task focusTask = value.focusTaskList[index];

                return TaskTile(
                  task: focusTask,
                  onPressedDelete: (context) => null,
                  onPressedEdit: (context) => null,
                  onPressedFocus: (context) => _setTaskToFocus(focusTask),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
