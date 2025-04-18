import 'package:flutter/material.dart';
import 'package:notes_app_sqflite_provider/Constants/theme_provider.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text("Settings")),
      body: Consumer<ThemeProvider>(
        builder: (_, provider, child) {
          return SwitchListTile.adaptive(
            title: Text("Dark Mode"),
            subtitle: Text("Change theme mode here"),
            value: provider.getThemeValue(),
            onChanged: (value) {
              provider.updateTheme(value: value);
            },
          );
        },
      ),
    );
  }
}
