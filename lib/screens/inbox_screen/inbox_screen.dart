import 'package:cs_three_things/base/database/task_database.dart';
import 'package:cs_three_things/base/resources/app_styles.dart';
import 'package:cs_three_things/base/task_tile.dart';
import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

import '../../base/models/task.dart';

class InboxScreen extends StatefulWidget {
  const InboxScreen({super.key});

  @override
  State<InboxScreen> createState() => _InboxScreenState();
}

class _InboxScreenState extends State<InboxScreen> {
  List<Task>? tasks;

  @override
  void initState() {
    Provider.of<TaskDatabase>(context, listen: false).readTasks();
    super.initState();
  }

  void deleteTask(int id) {
    context.read<TaskDatabase>().deleteTask(id);
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
          );
        },
      ),
    );
  }
}
