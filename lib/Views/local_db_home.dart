import 'package:flutter/material.dart';
import 'package:notes_app_sqflite/Views/local_db_helper.dart';
import 'package:notes_app_sqflite/constants.dart';

class MyDbHome extends StatefulWidget {
  const MyDbHome({super.key});

  @override
  State<MyDbHome> createState() => _MyDbHomeState();
}

class _MyDbHomeState extends State<MyDbHome> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();
  List<Map<String, dynamic>> allNotes = [];
  DBHelper? dbRef;
  @override
  void initState() {
    super.initState();
    dbRef = DBHelper.getInstance;
    getNotes();
  }

  void getNotes() async {
    allNotes = await dbRef!.getAllNotes();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black12,
        centerTitle: true,
        title: Text(
          "ALL NOTES",
          style: TextStyle(color: MyConstants.myTxtColor),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: MyConstants.myPrimaryColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        onPressed: () async {
          /*
          bool check =
              await dbRef!.addNote(mTitle: "xainNote", mDesc: "xainNoteDesc");
          if (check) {
            getNotes();
          }*/
          showModalBottomSheet(
            context: context,
            builder: (context) {
              titleController.clear();
              descController.clear();
              return getBottomSheetWidget();
            },
          );
        },
        child: Icon(Icons.note_add_rounded, color: Colors.orange),
      ),
      body: Center(
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
                                  titleController.text =
                                      allNotes[index][DBHelper
                                          .COLUMN_NOTE_TITLE];
                                  descController.text =
                                      allNotes[index][DBHelper
                                          .COLUMN_NOTE_DESC];
                                  showModalBottomSheet(
                                    context: context,
                                    builder: (context) {
                                      return getBottomSheetWidget(
                                        isUpdate: true,
                                        sno:
                                            allNotes[index][DBHelper
                                                .COLUMN_NOTE_SNO],
                                      );
                                    },
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
                                  bool check = await dbRef!.deleteNote(
                                    sno:
                                        allNotes[index][DBHelper
                                            .COLUMN_NOTE_SNO],
                                  );
                                  if (check) {
                                    getNotes();
                                  }
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
                  child: Text(
                    "NO NOTES YET!",
                    style: TextStyle(color: Colors.black, fontSize: 20),
                  ),
                ),
      ),
    );
  }

  Widget getBottomSheetWidget({bool isUpdate = false, int sno = 0}) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          left: BorderSide(color: MyConstants.myBtnColor, width: 2),
          right: BorderSide(color: MyConstants.myBtnColor, width: 2),
          top: BorderSide(color: MyConstants.myBtnColor, width: 2),
        ),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
        color: Colors.black,
      ),
      padding: EdgeInsets.all(11),
      width: double.infinity,
      child: Column(
        children: [
          SizedBox(height: 20),
          Text(
            isUpdate ? "Update Note" : "Add Note",
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: MyConstants.myTxtColor,
            ),
          ),
          SizedBox(height: 21),
          TextField(
            style: TextStyle(color: MyConstants.myTxtColor, fontSize: 16),
            controller: titleController,
            decoration: InputDecoration(
              fillColor: MyConstants.myPrimaryColor,
              filled: true,
              hintText: "Enter title here",
              hintStyle: TextStyle(color: MyConstants.myTxtColor),

              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(11),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(11),
              ),
            ),
          ),
          SizedBox(height: 11),
          TextField(
            style: TextStyle(color: MyConstants.myTxtColor, fontSize: 16),
            maxLines: 5,
            controller: descController,
            decoration: InputDecoration(
              fillColor: MyConstants.myPrimaryColor,
              filled: true,
              hintText: "Enter description here",
              hintStyle: TextStyle(color: MyConstants.myTxtColor, fontSize: 16),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(11),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(11),
              ),
            ),
          ),
          SizedBox(height: 11),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: MyConstants.myBtnColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(11),
                    ),
                  ),
                  onPressed: () async {
                    var title = titleController.text;
                    var desc = descController.text;
                    if (title.isNotEmpty && desc.isNotEmpty) {
                      bool check =
                          isUpdate
                              ? await dbRef!.updateNotes(
                                title: title,
                                desc: desc,
                                sno: sno,
                              )
                              : await dbRef!.addNote(
                                mTitle: title,
                                mDesc: desc,
                              );
                      if (check) {
                        getNotes();
                      }
                      titleController.clear();
                      descController.clear();
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            "Please fill all the required fields!",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: MyConstants.myTxtColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          backgroundColor: Colors.red,
                          behavior: SnackBarBehavior.floating,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(11),
                          ),
                        ),
                      );
                    }
                    Navigator.pop(context);
                  },
                  child: Text(
                    isUpdate ? "Update Note" : "Add Note",
                    style: TextStyle(
                      color: MyConstants.myTxtColor,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 11),
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red.shade500,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(11),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Cancel",
                    style: TextStyle(
                      color: MyConstants.myTxtColor,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
