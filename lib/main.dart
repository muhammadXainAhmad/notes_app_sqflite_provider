import 'package:flutter/material.dart';
import 'package:notes_app_sqflite/Constants/db_provider.dart';
import 'package:notes_app_sqflite/Constants/local_db_helper.dart';
import 'package:notes_app_sqflite/Views/local_db_home.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => DbProvider(dbHelper: DBHelper.getInstance),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyDbHome(),
    );
  }
}
