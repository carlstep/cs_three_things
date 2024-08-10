// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:isar/isar.dart';

// generates the isar db file
// run cmd in termainl >> dart run build_runner build
part 'task.g.dart';

// task class, not the id is not required
// to add a new task, see addTask() function in add_task_screen

@Collection()
class Task {
  // unique task id >> comes from isar
  Id id = Isar.autoIncrement;
  // task name
  late String taskName;
  // task description
  late String taskNote;
  // task dueDate
  late DateTime dueDate;
  // task tags
  late List<String> taskTags;
  // taskPriority

  @Enumerated(EnumType.name)
  PriorityEnum? taskPriority;
  // task area
  late String taskArea;

  // Task({
  //   required this.taskName,
  //   required this.taskNote,
  //   required this.dueDate,
  //   required this.taskTags,
  //   required this.taskPriority,
  //   required this.taskArea,
  // });
}

enum PriorityEnum {
  low,
  medium,
  high,
}
