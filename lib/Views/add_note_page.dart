import 'package:flutter/material.dart';
import 'package:notes_app_sqflite_provider/Constants/db_provider.dart';
import 'package:notes_app_sqflite_provider/constants.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class AddNotePage extends StatelessWidget {
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();
  bool isUpdate;
  String title;
  String desc;
  int sno;
  AddNotePage({
    super.key,
    this.isUpdate = false,
    this.sno = 0,
    this.title = "",
    this.desc = "",
  });

  @override
  Widget build(BuildContext context) {
    if (isUpdate) {
      titleController.text = title;
      descController.text = desc;
    }
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Text(
          isUpdate ? "Update Note" : "Add Note",
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: MyConstants.myTxtColor,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white, size: 30),
      ),
      body: Container(
        padding: EdgeInsets.all(11),
        width: double.infinity,
        child: Column(
          children: [
            SizedBox(height: 20),
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
                hintStyle: TextStyle(
                  color: MyConstants.myTxtColor,
                  fontSize: 16,
                ),
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
                        if (isUpdate) {
                          context.read<DbProvider>().updateNotes(
                            title,
                            desc,
                            sno,
                          );
                        } else {
                          context.read<DbProvider>().addNote(title, desc);
                        }
                        Navigator.of(context).pop();
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
      ),
    );
  }
}
