import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';

const List<Map<String, dynamic>> priorities = [
  {'name': 'low', 'icon': '!', 'color': Colors.green, 'selected': false},
  {'name': 'medium', 'icon': '!!', 'color': Colors.orange, 'selected': false},
  {'name': 'high', 'icon': '!!!', 'color': Colors.red, 'selected': false},
];

const List<Map<String, dynamic>> areas = [
  {
    'area': 'Personal',
    'icon': Icon(FluentSystemIcons.ic_fluent_person_filled),
    'selected': false
  },
  {
    'area': 'Work',
    'icon': Icon(FluentSystemIcons.ic_fluent_briefcase_filled),
    'selected': false
  },
  {
    'area': 'Home',
    'icon': Icon(FluentSystemIcons.ic_fluent_home_filled),
    'selected': false
  },
];
