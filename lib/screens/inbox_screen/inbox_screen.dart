import 'package:cs_three_things/base/database/task_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../base/models/task.dart';

class InboxScreen extends StatefulWidget {
  const InboxScreen({super.key});

  @override
  State<InboxScreen> createState() => _InboxScreenState();
}

class _InboxScreenState extends State<InboxScreen> {
  @override
  void initState() {
    Provider.of<TaskDatabase>(context, listen: false).readTasks();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskDatabase>(
      builder: (context, value, child) => ListView.builder(
        itemCount: value.allTasks.length,
        itemBuilder: (context, index) {
          Task eachTask = value.allTasks[index];
          return Text(eachTask.taskName);
        },
      ),
    );
  }
}
