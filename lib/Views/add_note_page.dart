import 'package:flutter/material.dart';
import 'package:notes_app_sqflite/constants.dart';

class AddNotePage extends StatelessWidget {
  const AddNotePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Add Note",
          style: TextStyle(color: MyConstants.myTxtColor),
        ),
      ),
    );
  }
}
