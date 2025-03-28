import 'package:flutter/material.dart';
import 'package:flutter_textfield/data/database.dart';
import 'package:flutter_textfield/util/dialog_box.dart';
import 'package:flutter_textfield/util/todo_tile.dart';
import 'package:hive/hive.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _appData = Hive.box('appData');
  ToDoDataBase db = ToDoDataBase();

  @override
  void initState() {
    if (_appData.get("TODOLIST") == null) {
      db.createInitialData();
      db.updateDataBase();
    } else {
      db.loadData();
    }

    super.initState();
  }

  // Text controller
  final _controller = TextEditingController();

  // Checkbox check
  void isChecked(bool? value, int index) {
    setState(() {
      db.todoList[index][1] = !db.todoList[index][1];
    });
    db.updateDataBase();
  }

  void saveNewTask() {
    setState(() {
      db.todoList.add([_controller.text, false]);
      _controller.clear();
    });
    Navigator.of(context).pop();
    db.updateDataBase();
  }

  void createNewTask() {
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          controller: _controller,
          onAdd: saveNewTask,
          onCancel: () => Navigator.of(context).pop(),
        );
      },
    );
  }

  void deleteTaks(int index) {
    setState(() {
      db.todoList.removeAt(index);
    });
    db.updateDataBase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "TO DO",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.blueAccent,
      ),
      body: ListView.builder(
        itemCount: db.todoList.length,
        itemBuilder: (context, index) {
          return TodoTile(
            taskName: db.todoList[index][0],
            taskCompleted: db.todoList[index][1],
            onChanged: (value) => isChecked(value, index),
            deleteFunction: (context) => deleteTaks(index),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
        onPressed: createNewTask,
        child: Icon(Icons.add),
      ),
    );
  }
}
