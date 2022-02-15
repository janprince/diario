library diario.globals;

import 'package:diario/models/db_helper.dart';
import 'package:intl/intl.dart';

// database helper
dbHelper helper = dbHelper();

// moods
List moods = [
  "assets/icons/emoji_1.png",
  "assets/icons/emoji_2.png",
  "assets/icons/emoji_3.png",
  "assets/icons/emoji_4.png",
  "assets/icons/emoji_5.png"
];

// parse timestamp from database
List parseDateTime(String date) {
  var db_date = DateTime.parse(date);
  var day = DateFormat('EEEE').format(db_date);
  var month_day = DateFormat('MMMd').format(db_date);
  List d = [day, month_day];
  return d;
}


// This file makes the database object available throughout the project.