// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
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
  final void Function()? deleteFunction;

  const TaskTile({
    super.key,
    required this.task,
    this.deleteFunction,
  });

  @override
  State<TaskTile> createState() => _TaskTileState();
}

class _TaskTileState extends State<TaskTile> {
  // bool private variable to expand the tile
  bool _isExpanded = false;

  @override
  void initState() {
    Provider.of<TaskDatabase>(context, listen: false).readTasks();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isExpanded = !_isExpanded;
        });
      },
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
          side: BorderSide(
            width: .5,
            color: Colors.grey.shade900,
          ),
        ),
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                // crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.task.taskName,
                    style: AppStyles.textTileStyle1,
                  ),
                  CircleAvatar(
                    backgroundColor: Colors.red.shade300,
                    radius: 15,
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
                                                  Colors.grey.shade400,
                                              label: Text(tag),
                                              labelStyle:
                                                  AppStyles.textTileChipStyle2,
                                            ),
                                          )
                                          .toList(),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              OutlinedButton.icon(
                                onPressed: () {},
                                icon: const Icon(Icons.edit),
                                label: const Text('edit'),
                              ),
                            ],
                          )
                        ],
                      )
                    : null,
              ),
            ],
          ),
        ),
      ),
    );
    ;
  }
}
