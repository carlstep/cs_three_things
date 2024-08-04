import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import '../models/task.dart';

class TaskDatabase extends ChangeNotifier {
  static late Isar isar;

  List<Task> _allTasks = [];

  // SETUP
  // - initialize db
  static Future<void> initialize() async {
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open(
      [TaskSchema],
      directory: dir.path,
    );
  }

  // GETTER METHODS
  // getter for all tasks
  List<Task> get allTasks => _allTasks;

  // OPERATIONS

  // - create new task
  Future<void> createNewTask(Task newTask) async {
    // add to db
    await isar.writeTxn(() => isar.tasks.put(newTask));

    // re-read from db
    await readTasks();
  }

  // - read tasks
  Future<void> readTasks() async {
    // fetch all existing tasks
    List<Task> fetchedTasks = await isar.tasks.where().findAll();

    // clear all expenses list and add
    _allTasks.clear();
    _allTasks.addAll(fetchedTasks);

    // update UI
    notifyListeners();
  }

  // - update
  Future<void> updateTask(int id, Task updatedTask) async {
    // use id to make sure working on correct task
    updatedTask.id = id;

    // update db
    await isar.writeTxn(() => isar.tasks.put(updatedTask));

    // re-read from db
    await readTasks();
  }

  // - delete
  Future<void> deleteTask(int id) async {
    // delete from db
    await isar.writeTxn(() => isar.tasks.delete(id));

    // re-read from
    await readTasks();
  }

  // HELPER METHODS
}
