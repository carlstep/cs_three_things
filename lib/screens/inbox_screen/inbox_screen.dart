import 'package:cs_three_things/base/database/task_database.dart';
import 'package:cs_three_things/base/resources/app_styles.dart';
import 'package:cs_three_things/base/task_tile.dart';
import 'package:cs_three_things/screens/edit_task/edit_task_screen.dart';

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../base/models/task.dart';

class InboxScreen extends StatefulWidget {
  const InboxScreen({super.key});

  @override
  State<InboxScreen> createState() => _InboxScreenState();
}

class _InboxScreenState extends State<InboxScreen> {
  // List<Task>? tasks;

  @override
  void initState() {
    Provider.of<TaskDatabase>(context, listen: false).readTasks();
    super.initState();
  }

  void _deleteExistingTask(Task task) {
    String existingTaskName = task.taskName;
    String existingTaskNote = task.taskNote;
    int id = task.id;

    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Confirm Delete Task'),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              existingTaskName,
              style: AppStyles.textTileStyle1,
            ),
            Text(existingTaskNote),
          ],
        ),
        actions: [
          // delete button
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              await context.read<TaskDatabase>().deleteTask(id);
            },
            child: const Text('Delete'),
          ),
          // cancel button
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }

  void _editExistingTask(Task task) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditTaskScreen(
          task: task,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // final taskDatabase = context.watch<TaskDatabase>();

    // List<Task> taskList = taskDatabase.allTasks;

    return Consumer<TaskDatabase>(
      builder: (context, value, child) => ListView.builder(
        itemCount: value.allTasks.length,
        itemBuilder: (context, index) {
          Task eachTask = value.allTasks[index];
          // slidable function >> delete >> edit >> share >> focus

          return TaskTile(
            task: eachTask,
            onPressedDelete: (context) => _deleteExistingTask(eachTask),
            onPressedEdit: (context) => _editExistingTask(eachTask),
          );
        },
      ),
    );
  }
}
