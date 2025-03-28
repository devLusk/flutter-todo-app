import 'package:hive_flutter/adapters.dart';

class ToDoDataBase {
  List todoList = [];

  final _appData = Hive.box('appData');

  // 1st time opening the app
  void createInitialData() {
    todoList = [
      ["Thats a default task", false],
      ["Slide to left to delete the task", false],
    ];
  }

  // load data from database
  void loadData() {
    todoList = _appData.get("TODOLIST");
  }

  // update the database
  void updateDataBase() {
    _appData.put("TODOLIST", todoList);
  }
}
