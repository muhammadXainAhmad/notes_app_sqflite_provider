import 'package:flutter/material.dart';
import 'package:notes_app_sqflite_provider/Constants/local_db_helper.dart';

class DbProvider extends ChangeNotifier {
  List<Map<String, dynamic>> _mData = [];
  DBHelper dbHelper;
  DbProvider({required this.dbHelper});

  void addNote(String title, String desc) async {
    bool check = await dbHelper.addNote(mTitle: title, mDesc: desc);
    if (check) {
      _mData = await dbHelper.getAllNotes();
      notifyListeners();
    }
  }

  void updateNotes(String title, String desc, int sno) async {
    bool check = await dbHelper.updateNotes(title: title, desc: desc, sno: sno);
    if (check) {
      _mData = await dbHelper.getAllNotes();
      notifyListeners();
    }
  }

  void deleteNote(int sno) async {
    bool check = await dbHelper.deleteNote(sno: sno);
    if (check) {
      _mData = await dbHelper.getAllNotes();
      notifyListeners();
    }
  }

  List<Map<String, dynamic>> getNotes() => _mData;

  void getInitialNotes() async {
    _mData = await dbHelper.getAllNotes();
    notifyListeners();
  }
}
