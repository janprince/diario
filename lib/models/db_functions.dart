// This file contains methods/functions for interacting with the database.

import 'package:diario/globals.dart';
import 'package:diario/models/diary_entry.dart';
import 'package:sqflite/sqflite.dart';

// insert into database
Future insertEntry(DiaryEntry entry) async {
  // Get a reference to the database.
  final db = await database;

  await db!.insert(
    'diary_entry',
    entry.toMap(),
    conflictAlgorithm: ConflictAlgorithm.replace,
  );
}

// retrieve from database
Future<List> getEntries() async {
  // Get a reference to the database.
  final db = await database;

  final List entry_maps = await db!.query("diary_entry");
  return entry_maps;
}
