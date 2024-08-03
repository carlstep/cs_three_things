// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../base/resources/app_styles.dart';

class DueDateInput extends StatelessWidget {
  // onDateSelect >> a callback function, used when a new dueDate is selected.
  final Function(DateTime) onDateSelected;
  // selectedDate >> the currently selected dueDate, set to DateTime.now(); THIS IS A DATETIME OBJECT
  // DateTime has ? to indicate
  final DateTime? selectedDate;

  const DueDateInput({
    super.key,
    required this.onDateSelected,
    required this.selectedDate,
  });

  @override
  Widget build(BuildContext context) {
    // the container, with BoxDecoration to style the border
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: AppStyles.unselectedIconColor),
        borderRadius: BorderRadius.circular(15),
      ),
      // a row to align the two main parts > Text to display the selectedDate, > IconButton to display showDatePicker calendar icon
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            // Text to display the dueDate (selectedDate)
            child: Text(
              DateFormat('EEEE, d MMMM yyyy').format(selectedDate!),
              style: AppStyles.textInputStyle2,
            ),
          ),
          IconButton(
            // TODO - change showDatePicker color style
            // onPressed displays > showDatePicker
            onPressed: () async {
              // onPressed is async, it awaits for the user to select a new date (pickedDate)
              final pickedDate = await showDatePicker(
                // the arguments for showDatePicker
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2020),
                lastDate: DateTime(2100),
                helpText: 'Select Task Due Date',
              );
              // (pickedDate != null) null safety
              if (pickedDate != null) {
                // if user selects new dueDate, pickedDate is assigned to onDateSelected callback function
                onDateSelected(pickedDate);
              }
            },
            // the caledar icon for the IconButton
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
