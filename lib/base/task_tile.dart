import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'package:cs_three_things/base/utils/config.dart';

import 'database/task_database.dart';
import 'models/task.dart';
import 'resources/app_styles.dart';

class TaskTile extends StatefulWidget {
  // passes the Task values
  final Task task;
  // delete function
  final void Function(BuildContext) onPressedDelete;
  final void Function(BuildContext) onPressedEdit;
  final bool? isFocused;
  final void Function(BuildContext)? onPressedFocus;

  const TaskTile({
    super.key,
    required this.task,
    required this.onPressedDelete,
    required this.onPressedEdit,
    this.isFocused,
    required this.onPressedFocus,
  });

  @override
  State<TaskTile> createState() => _TaskTileState();
}

class _TaskTileState extends State<TaskTile> {
  // bool private variable to expand the tile
  bool _isExpanded = false;

  // priority indicator
  Map<String, dynamic>? _findPriorityConfig(String priorityName) {
    return priorities.firstWhere(
      (priority) {
        return priority['name'] == priorityName;
      },
    );
  }

  @override
  void initState() {
    Provider.of<TaskDatabase>(context, listen: false).readTasks();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Slidable(
      startActionPane: ActionPane(
        extentRatio: 0.2,
        motion: const ScrollMotion(),
        children: [
          // mark task for focus screen
          SlidableAction(
            autoClose: false,
            padding: const EdgeInsets.all(0),
            spacing: 0,
            // onPressed - moves the selected task to the focus list
            // TODO - set up move to focus list
            onPressed: widget.onPressedFocus,

            icon: FluentSystemIcons.ic_fluent_target_regular,
            foregroundColor: widget.task.isFocused
                ? AppStyles.selectedIconColor
                : AppStyles.unselectedIconColor,
          )
        ],
      ),
      endActionPane: ActionPane(
        extentRatio: 0.5,
        motion: const ScrollMotion(),
        children: [
          // delete function >> showDialog with task info and confirm to delete
          SlidableAction(
            onPressed: widget.onPressedDelete,
            icon: FluentSystemIcons.ic_fluent_delete_regular,
            foregroundColor: AppStyles.unselectedIconColor,
          ),
          // edit task function
          SlidableAction(
            icon: FluentSystemIcons.ic_fluent_edit_regular,
            foregroundColor: AppStyles.unselectedIconColor,
            onPressed: widget.onPressedEdit,
          ),
          // TODO - work on share function
          SlidableAction(
            icon: FluentSystemIcons.ic_fluent_share_ios_regular,
            foregroundColor: AppStyles.unselectedIconColor,
            // onPressed - when tapped, the task data can be shared to external apps
            onPressed: null,
          ),
        ],
      ),
      child: GestureDetector(
        onTap: () {
          setState(() {
            _isExpanded = !_isExpanded;
          });
        },
        child: Card(
          color: Colors.transparent,
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: BorderSide(
              width: widget.task.isFocused ? 2 : .3,
              color: widget.task.isFocused
                  ? AppStyles.selectedIconColor
                  : Colors.grey.shade900,
            ),
          ),
          // elevation set to 0
          elevation: 0,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Row to display the taskName and taskPriority indicator
                // this Row displays main task information
                Row(
                  // crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(
                      widget.task.isFocused
                          ? FluentSystemIcons.ic_fluent_target_regular
                          : null,
                      color: AppStyles.selectedIconColor,
                    ),

                    Text(
                      widget.task.taskName,
                      style: AppStyles.textTileStyle1,
                    ),

                    // priority indicator
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 20,
                          backgroundColor: _findPriorityConfig(
                              widget.task.taskPriority?.name ?? '')?['color'],
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 17,
                            child: Text(
                              _findPriorityConfig(
                                  widget.task.taskPriority?.name ??
                                      '')?['icon'],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                // _isExpanded is 'false' show SizedBox = 10, _isExpanded is 'true' show SizedBox = 0.
                _isExpanded
                    ? const SizedBox(
                        height: 10,
                      )
                    : const SizedBox(
                        height: 0,
                      ),
                Padding(
                  padding: const EdgeInsets.only(left: 0, right: 0, bottom: 0),
                  child: _isExpanded
                      // _isExpanded ? is true >> show column
                      // expands the taskTile to show more information
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 10.0, right: 5),
                              child: Text(
                                widget.task.taskNote,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  DateFormat('EEEE, dd MMM yyyy')
                                      .format(widget.task.dueDate),
                                  style: AppStyles.textTileStyle2,
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Text(widget.task.taskArea),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Flexible(
                                  child: Wrap(
                                    spacing: 4.0,
                                    runSpacing: 2.0,
                                    children: widget.task.taskTags.isEmpty
                                        ? [
                                            const Text('no tags to display!'),
                                          ]
                                        : widget.task.taskTags
                                            .map(
                                              (tag) => Chip(
                                                side: BorderSide.none,
                                                backgroundColor:
                                                    Colors.grey.shade300,
                                                label: Text(tag),
                                                labelStyle: AppStyles
                                                    .textTileChipStyle2,
                                                labelPadding:
                                                    const EdgeInsets.symmetric(
                                                  horizontal: 2,
                                                  vertical: 0,
                                                ),
                                              ),
                                            )
                                            .toList(),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )
                      : null,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
