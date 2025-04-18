import 'package:flutter/material.dart';
import 'package:notes_app_sqflite_provider/Constants/constants.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Text(
          "Settings",
          style: TextStyle(color: MyConstants.myTxtColor),
        ),
        iconTheme: const IconThemeData(color: Colors.white, size: 28),
      ),
      body: SwitchListTile.adaptive(
        title: Text(
          "Dark Mode",
          style: TextStyle(color: MyConstants.myTxtColor),
        ),
        subtitle: Text(
          "Change theme mode here",
          style: TextStyle(color: MyConstants.myTxtColor),
        ),
        value: isDarkMode,
        onChanged: (value) {
          isDarkMode = value;
          setState(() {});
        },
      ),
    );
  }
}
