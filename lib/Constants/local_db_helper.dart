// ADDED PACKAGES: sqflite, path_provider, path

import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  // WE DONT REQUIRE MULTIPLE INSTANCES OF A DATABASE
  // WE NEED TO MANIPULATE DATA INTO A SINGLE DATABASE / TABLE
  // HENCE, WE WILL CREATE A SINGLETON CLASS
  // SINGLETON: ONE STATIC OBJECT CIRCULATED THROUGHOUT THE APP
  // THE _ MAKES THE CONSTRUCTOR PRIVATE
  // IT CANNOT BE ACCESSED OUTSIFE OF THE CLASS
  // ELIMINATIING THE POSSIBILITY OF CREATE MULTIPLE INSTANCES
  // BUT, WE DO NEED A SINGLE INSTANCE.
  DBHelper._();
  // STATIC RETURNS A SINGLE INSTANCE
  // OTHERWISE, A NEW INSTANCE WOULD BE CREATED UPON CALLING THE FUNCTION
  static final DBHelper getInstance = DBHelper._();
  // notes table
  static final String TABLE_NOTE = "note";
  static final String COLUMN_NOTE_SNO = "s_no";
  static final String COLUMN_NOTE_TITLE = "title";
  static final String COLUMN_NOTE_DESC = "desc";

  //DATABASE OBJECT, ? makes it nullable
  Database? myDB;
  // dbOpen (path -> if exists, then open, else create)
  Future<Database> getDB() async {
    // ?? means, if myDB null, then openDB()
    myDB ??= await openDB();
    return myDB!;
    /* SHORTENED ^
    if (myDB != null) {
      return myDB!;
    } else {
      myDB = await openDB();
      return myDB!;
    }*/
  }

  // return type & function name
  // the path will be given some time in the future
  // so we will have to make the function async
  // async has return type Future
  // so Database openDB() will be changed to Future<Database> openDB
  // since openDB is being called in the getDB function
  // the function needs to be set to async
  Future<Database> openDB() async {
    Directory appDir = await getApplicationDocumentsDirectory();
    // Directory: appDir, Path: appDir.path, fileName: noteDb, sqlFileExtension: .db
    String dbPath = join(appDir.path, "noteDB.db");
    // onCreate is called only the first time
    // anonymous function when not needed for reusability
    // doesnt require a function name
    return await openDatabase(
      dbPath,
      onCreate: (db, version) {
        // create all tables here
        db.execute(
          "create table $TABLE_NOTE($COLUMN_NOTE_SNO integer primary key autoincrement, $COLUMN_NOTE_TITLE text, $COLUMN_NOTE_DESC text )",
        );
      },
      version: 1,
    );
    // giving version is not necessary
    // however, if you're ever changing the structure aka schema of db
    // like creating a new table, column, or changing a datatype (rare)
    // you can update the versions then, 1, 1.1, 1.2 or 2.0 etc
  }

  // QUERIES
  // insertNote
  Future<bool> addNote({required String mTitle, required String mDesc}) async {
    var db = await getDB();
    // values will be in key value pairs
    int rowsAffected = await db.insert(TABLE_NOTE, {
      COLUMN_NOTE_TITLE: mTitle,
      COLUMN_NOTE_DESC: mDesc,
    });
    return rowsAffected > 0;
  }

  // readNotes
  Future<List<Map<String, dynamic>>> getAllNotes() async {
    var db = await getDB();
    //select * from note
    List<Map<String, dynamic>> mData = await db.query(TABLE_NOTE);
    return mData;
  }

  // updateNote
  Future<bool> updateNotes({
    required String title,
    required String desc,
    required int sno,
  }) async {
    var db = await getDB();
    int rowsAffected = await db.update(TABLE_NOTE, {
      COLUMN_NOTE_TITLE: title,
      COLUMN_NOTE_DESC: desc,
    }, where: "$COLUMN_NOTE_SNO = $sno");
    return rowsAffected > 0;
  }

  // deleteNote
  Future<bool> deleteNote({required int sno}) async {
    var db = await getDB();
    int rowsAffected = await db.delete(
      TABLE_NOTE,
      where: "$COLUMN_NOTE_SNO =?",
      whereArgs: ["$sno"],
    );
    // "$COLUMN_NOTE_SNO = $sno");
    return rowsAffected > 0;
  }
}
