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
          return Slidable(
            startActionPane: ActionPane(
              extentRatio: 0.3,
              motion: const ScrollMotion(),
              children: [
                // mark task for focus screen
                SlidableAction(
                  padding: const EdgeInsets.all(0),
                  spacing: 0,
                  onPressed: null,
                  icon: FluentSystemIcons.ic_fluent_target_regular,
                  foregroundColor: AppStyles.unselectedIconColor,
                )
              ],
            ),
            endActionPane: ActionPane(
              extentRatio: 0.5,
              motion: const ScrollMotion(),
              children: [
                // delete function >> showDialog with task info and confirm to delete
                SlidableAction(
                    icon: FluentSystemIcons.ic_fluent_delete_regular,
                    foregroundColor: AppStyles.unselectedIconColor,
                    onPressed: (context) {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          title: const Text('Confirm Delete Task'),
                          content: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                eachTask.taskName,
                                style: AppStyles.textTileStyle1,
                              ),
                              Text(eachTask.taskNote),
                            ],
                          ),
                          actions: [
                            // delete button
                            TextButton(
                              onPressed: () {
                                deleteTask(eachTask.id);
                                Navigator.pop(context);
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
                    }),
                // edit task function
                SlidableAction(
                  icon: FluentSystemIcons.ic_fluent_edit_regular,
                  foregroundColor: AppStyles.unselectedIconColor,
                  onPressed: null,
                ),
                SlidableAction(
                  icon: FluentSystemIcons.ic_fluent_share_ios_regular,
                  foregroundColor: AppStyles.unselectedIconColor,
                  onPressed: null,
                ),
              ],
            ),
            child: TaskTile(
              task: eachTask,
            ),
          );
        },
      ),
    );
  }
}
