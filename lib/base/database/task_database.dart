import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import '../models/task.dart';

class TaskDatabase extends ChangeNotifier {
  // TaskDatabase class, that inherits from ChangeNotifier

  static late Isar isar;
  // declares a static late variable 'isar', which holds the reference to the Isar database

  List<Task> _allTasks = [];
  // _allTasks is a private list. Stores all Task objects from the Isar db

  // SETUP
  // - initialize db
  // static method named initialize() is async and used to setup the Isar db.
  // it retrieves the application documents directory path and opens an Isar instance
  // with [TaskSchema]
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

    void printTasks() {
      for (final task in _allTasks) {
        print(task.taskPriority);
      }
    }
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
