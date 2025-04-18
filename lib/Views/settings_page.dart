import 'package:flutter/material.dart';

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
      appBar: AppBar(centerTitle: true, title: Text("Settings")),
      body: SwitchListTile.adaptive(
        title: Text("Dark Mode"),
        subtitle: Text("Change theme mode here"),
        value: isDarkMode,
        onChanged: (value) {
          isDarkMode = value;
          setState(() {});
        },
      ),
    );
  }
}
