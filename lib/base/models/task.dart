// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:isar/isar.dart';

// generates the isar db file
// run cmd in termainl >> dart run build_runner build
part 'task.g.dart';

@Collection()
class Task {
  // unique task id
  Id id = Isar.autoIncrement;
  // task name
  final String taskName;
  // task description
  final String taskNote;
  // task dueDate
  final DateTime dueDate;
  // task tags
  final List<String> taskTags;
  // taskPriority
  final int taskPriority;
  // task area
  final String taskArea;

  Task({
    required this.taskName,
    required this.taskNote,
    required this.dueDate,
    required this.taskTags,
    required this.taskPriority,
    required this.taskArea,
  });
}
