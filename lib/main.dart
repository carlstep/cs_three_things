import 'package:cs_three_things/base/database/task_database.dart';
import 'package:cs_three_things/screens/inbox_screen/inbox_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'base/bottom_nav_bar.dart';
import 'base/utils/app_routes.dart';
import 'screens/add_task/add_task_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // initialize db
  await TaskDatabase.initialize();

  runApp(
    // Provider state management
    ChangeNotifierProvider(
      create: (context) => TaskDatabase(),
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Three Things',
      theme: ThemeData(
        useMaterial3: true,
      ),
      routes: {
        // navigate to AppRoutes.homeScreen
        AppRoutes.focusScreen: (context) => const BottomNavBar(),
        // navigate to InboxScreen
        AppRoutes.inboxScreen: (context) => const InboxScreen(),
        // navigate to AppRoutes.addTaskScreen
        AppRoutes.addTaskScreen: (context) => const AddTaskScreen(),
      },
    );
  }
}
