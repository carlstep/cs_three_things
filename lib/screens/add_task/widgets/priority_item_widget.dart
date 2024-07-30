// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cs_three_things/base/resources/app_styles.dart';
import 'package:cs_three_things/base/utils/config.dart';
import 'package:flutter/material.dart';

class PriorityItemWidget extends StatelessWidget {
  final int selectedPriority;
  final int index;

  const PriorityItemWidget({
    super.key,
    required this.selectedPriority,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 6),
      child: CircleAvatar(
        radius: 30,
        backgroundColor: (index == selectedPriority)
            ? priorities[index]['color']
            : Colors.grey.shade500,
        child: CircleAvatar(
          radius: 20,
          backgroundColor: Colors.white,
          child: Text(
            priorities[index]['icon'],
            style: AppStyles.headlineStyle1.copyWith(
                color: (index == selectedPriority)
                    ? priorities[index]['color']
                    : Colors.grey,
                fontSize: 26),
          ),
        ),
      ),
    );
  }
}
