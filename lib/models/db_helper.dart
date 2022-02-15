import 'package:diario/globals.dart';
import 'package:diario/models/diary_entry.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';

class dbHelper {
  static Database? _db;

  Future<Database> get db async {
    if (_db != null) return _db!;
    _db = await initDb();
    return _db!;
  }

  initDb() async {
    WidgetsFlutterBinding.ensureInitialized();
    var database = openDatabase(
      join(await getDatabasesPath(), 'diario.db'),
      // When the database is first created, do this:
      onCreate: (db, version) => db.execute(
          'CREATE TABLE diary_entry (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, mood INTEGER, title TEXT, entry TEXT, date_created TIMESTAMP DEFAULT CURRENT_TIMESTAMP)'),
      // Set the version. This executes the onCreate function and provides a
      // path to perform database upgrades and downgrades.
      version: 1,
    );
    return database;
  }

  // insert into database
  Future insertEntry(DiaryEntry entry) async {
    // Get a reference to the database.
    final Db = await db;

    await Db.insert(
      'diary_entry',
      entry.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

// retrieve from database
  Future<List> getEntries() async {
    // Get a reference to the database.
    final Db = await db;

    // get the db table sorted by date_created
    final List entry_maps =
        await Db.query("diary_entry", orderBy: "date_created DESC");
    return entry_maps;
  }
}
