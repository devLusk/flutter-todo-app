import 'package:flutter/material.dart';
import 'package:flutter_textfield/util/my_button.dart';

class DialogBox extends StatelessWidget {
  final controller;
  VoidCallback onAdd;
  VoidCallback onCancel;

  DialogBox({
    super.key,
    required this.controller,
    required this.onAdd,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      content: Container(
        height: 120,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: controller,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Add a new task",
              ),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(child: MyButton(text: "Add", onPressed: onAdd)),
                SizedBox(width: 10),
                Expanded(child: MyButton(text: "Cancel", onPressed: onCancel)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
