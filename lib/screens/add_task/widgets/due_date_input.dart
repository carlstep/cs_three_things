// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../base/resources/app_styles.dart';

class DueDateInput extends StatelessWidget {
  final Function(DateTime) onDateSelected;
  final DateTime? selectedDate;

  const DueDateInput({
    super.key,
    required this.onDateSelected,
    required this.selectedDate,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: AppStyles.unselectedIconColor),
          borderRadius: BorderRadius.circular(15)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              DateFormat('EEEE, d MMMM yyyy').format(selectedDate!),
              style: AppStyles.textInputStyle2,
            ),
          ),
          IconButton(
            // TODO - change showDatePicker color style
            onPressed: () async {
              final pickedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2020),
                lastDate: DateTime(2100),
                helpText: 'Select Task Due Date',
              );
              if (pickedDate != null) {
                onDateSelected(pickedDate);
              }
            },
            icon: const Icon(
              FluentSystemIcons.ic_fluent_calendar_month_regular,
              size: 34,
            ),
          )
        ],
      ),
    );
  }
}
