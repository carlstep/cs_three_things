import 'package:flutter/material.dart';

import 'base/bottom_nav_bar.dart';
import 'base/utils/app_routes.dart';
import 'screens/add_task_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Three Things',
      // theme: ThemeData(),
      routes: {
        AppRoutes.homeScreen: (context) => const BottomNavBar(),
        AppRoutes.addTaskScreen: (context) => const AddTaskScreen(),
      },
    );
  }
}
