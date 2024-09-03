import 'package:cs_three_things/base/task_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../base/database/task_database.dart';

class FocusScreen extends StatefulWidget {
  const FocusScreen({super.key});

  @override
  State<FocusScreen> createState() => _FocusScreenState();
}

class _FocusScreenState extends State<FocusScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<TaskDatabase>(
      builder: (context, value, child) => Column(
        children: [
          Center(
            child: Text('data'),
          ),
        ],
      ),
    );
  }
}
