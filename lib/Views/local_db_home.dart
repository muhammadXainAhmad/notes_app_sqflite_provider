import 'package:flutter/material.dart';
import 'package:notes_app_sqflite_provider/Constants/db_provider.dart';
import 'package:notes_app_sqflite_provider/Views/add_note_page.dart';
import 'package:notes_app_sqflite_provider/Constants/local_db_helper.dart';
import 'package:notes_app_sqflite_provider/Constants/constants.dart';
import 'package:notes_app_sqflite_provider/Views/settings_page.dart';
import 'package:provider/provider.dart';

class MyDbHome extends StatefulWidget {
  const MyDbHome({super.key});

  @override
  State<MyDbHome> createState() => _MyDbHomeState();
}

class _MyDbHomeState extends State<MyDbHome> {
  @override
  void initState() {
    super.initState();
    context.read<DbProvider>().getInitialNotes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Text(
          "ALL NOTES",
          style: TextStyle(color: MyConstants.myTxtColor),
        ),
        actions: [
          InkWell(
            onTap: () {
              Navigator.of(
                context,
              ).push(MaterialPageRoute(builder: (context) => SettingsPage()));
            },
            child: Icon(
              Icons.settings,
              color: MyConstants.myTxtColor,
              size: 28,
            ),
          ),
          SizedBox(width: 25),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: MyConstants.myPrimaryColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        onPressed: () async {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddNotePage()),
          );
        },
        child: Icon(Icons.note_add_rounded, color: Colors.orange),
      ),
      body: Consumer<DbProvider>(
        builder: (ctx, provider, __) {
          List<Map<String, dynamic>> allNotes = provider.getNotes();
          return Center(
            child:
                allNotes.isNotEmpty
                    ? ListView.builder(
                      itemCount: allNotes.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(
                            top: 8.0,
                            bottom: 8,
                            right: 18,
                            left: 18,
                          ),
                          child: ListTile(
                            tileColor: MyConstants.myPrimaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(26),
                            ),
                            leading: Text(
                              "${index + 1}",
                              style: TextStyle(color: MyConstants.myTxtColor),
                            ),
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  allNotes[index][DBHelper.COLUMN_NOTE_TITLE],
                                  style: TextStyle(
                                    color: MyConstants.myTxtColor,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Divider(
                                  color: MyConstants.myTxtColor,
                                  endIndent: 100,
                                ),
                              ],
                            ),

                            subtitle: Text(
                              allNotes[index][DBHelper.COLUMN_NOTE_DESC],
                              style: TextStyle(
                                color: MyConstants.myTxtColor,
                                fontSize: 16,
                              ),
                            ),
                            trailing: SizedBox(
                              width: 60,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder:
                                              (context) => AddNotePage(
                                                isUpdate: true,
                                                sno:
                                                    allNotes[index][DBHelper
                                                        .COLUMN_NOTE_SNO],
                                                title:
                                                    allNotes[index][DBHelper
                                                        .COLUMN_NOTE_TITLE],
                                                desc:
                                                    allNotes[index][DBHelper
                                                        .COLUMN_NOTE_DESC],
                                              ),
                                        ),
                                      );
                                    },
                                    child: Icon(
                                      Icons.edit,
                                      color: MyConstants.myTxtColor,
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  InkWell(
                                    onTap: () async {
                                      context.read<DbProvider>().deleteNote(
                                        allNotes[index][DBHelper
                                            .COLUMN_NOTE_SNO],
                                      );
                                    },
                                    child: Icon(
                                      Icons.delete,
                                      color: Colors.red.shade600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    )
                    : Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "No Notes",
                            style: TextStyle(
                              color: MyConstants.myTxtColor,
                              fontSize: 20,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            "Tap the Add button to create a note.",
                            style: TextStyle(
                              color: MyConstants.myTxtColor,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
          );
        },
      ),
    );
  }
}
