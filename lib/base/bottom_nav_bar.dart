import 'package:cs_three_things/base/utils/app_routes.dart';
import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  final appScreens = [
    const Center(child: Text('home screen')),
    const Center(child: Text('inbox screen')),
    const Center(child: Text('stats screen')),
  ];

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Three Things'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, AppRoutes.addTaskScreen);
              },
              icon: const Icon(
                FluentSystemIcons.ic_fluent_add_circle_regular,
                size: 30,
              ))
        ],
      ),
      body: appScreens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: _onItemTapped,
        currentIndex: _selectedIndex,
        unselectedItemColor: Colors.blueGrey,
        selectedItemColor: Colors.red,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        iconSize: 34,
        items: const [
          BottomNavigationBarItem(
              label: 'home',
              icon: Icon(
                FluentSystemIcons.ic_fluent_home_regular,
              )),
          BottomNavigationBarItem(
              label: 'inbox',
              icon: Icon(
                FluentSystemIcons.ic_fluent_mail_inbox_regular,
              )),
          BottomNavigationBarItem(
              label: 'stats',
              icon: Icon(
                FluentSystemIcons.ic_fluent_data_pie_regular,
              )),
        ],
      ),
    );
  }
}
