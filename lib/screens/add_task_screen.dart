import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Task'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Task Name...'),
            const SizedBox(
              height: 10,
            ),
            const Text('Task Note...'),
            const SizedBox(
              height: 10,
            ),
            const Row(
              children: [
                Text('Task DueDate...'),
                Icon(FluentSystemIcons.ic_fluent_calendar_month_regular,
                    size: 30),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            const Text('Task Tags...'),
            const SizedBox(
              height: 10,
            ),
            const Text('Task Priority...'),
            const SizedBox(
              height: 10,
            ),
            OutlinedButton(
              onPressed: () {},
              child: const Text('Add New Task'),
            ),
          ],
        ),
      ),
    );
  }
}
