import 'package:flutter/material.dart';
import 'package:notes_app_sqflite_provider/Constants/db_provider.dart';
import 'package:notes_app_sqflite_provider/Constants/local_db_helper.dart';
import 'package:notes_app_sqflite_provider/Constants/theme_provider.dart';
import 'package:notes_app_sqflite_provider/Views/local_db_home.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => DbProvider(dbHelper: DBHelper.getInstance),
        ),
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
      ],
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
      themeMode:
          context.watch<ThemeProvider>().getThemeValue()
              ? ThemeMode.dark
              : ThemeMode.light,
      darkTheme: ThemeData.dark(),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyDbHome(),
    );
  }
}
