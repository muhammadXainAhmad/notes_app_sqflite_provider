import 'package:flutter/material.dart';
import 'package:notes_app_sqflite/Constants/local_db_helper.dart';

class DbProvider extends ChangeNotifier {
  List<Map<String, dynamic>> _mData = [];
  DBHelper dbHelper;
  DbProvider({required this.dbHelper});

  void addNote(String title, String desc) async {
    bool check = await dbHelper.addNote(mTitle: title, mDesc: desc);
    if (check) {
      await dbHelper.getAllNotes();
      notifyListeners();
    }
  }

  List<Map<String, dynamic>> getNotes() => _mData;
  
  void getInitialNotes() async {
    _mData = await dbHelper.getAllNotes();
    notifyListeners();
  }
}
