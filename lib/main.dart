// ignore_for_file: prefer_const_constructors

import 'package:diario/constants.dart';
import 'package:diario/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/widgets.dart';
import 'globals.dart' as globals;

void main() async {
  runApp(DiaryApp());
  WidgetsFlutterBinding.ensureInitialized();
  globals.database = openDatabase(
    join(await getDatabasesPath(), 'diario.db'),
    // When the database is first created, do this:
    onCreate: (db, version) => db.execute(
        'CREATE TABLE diary_entry (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, date TEXT, title TEXT, entry TEXT)'),
    // Set the version. This executes the onCreate function and provides a
    // path to perform database upgrades and downgrades.
    version: 1,
  );
}

class DiaryApp extends StatelessWidget {
  const DiaryApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(scaffoldBackgroundColor: kPrimary),
      home: Mobile(),
      // routes: {
      //   "/": (context) => Mobile(),
      //   "/entry": (context) => DiaryEntry(),
      //   "/login": (context) => Login(),
      //   "/signup": (context) => SignUp(),
      // },
    );
  }
}
