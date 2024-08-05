import 'package:cs_three_things/base/resources/app_styles.dart';
import 'package:cs_three_things/base/utils/app_routes.dart';
import 'package:cs_three_things/screens/inbox_screen/inbox_screen.dart';
import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  final appScreens = [
    const Center(child: Text('focus screen')),
    const InboxScreen(),
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
        title: Text(
          'Three Things',
          style: AppStyles.headlineStyle1,
        ),
        // 'add' action will not appear on stats screen (index - 2)
        actions: _selectedIndex == 2
            ? null
            : [
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
        unselectedItemColor: AppStyles.unselectedIconColor,
        selectedItemColor: AppStyles.selectedIconColor,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        iconSize: 34,
        items: const [
          BottomNavigationBarItem(
              label: 'home',
              icon: Icon(
                FluentSystemIcons.ic_fluent_target_regular,
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
