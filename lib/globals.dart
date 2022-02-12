library diario.globals;

import 'package:diario/models/db_helper.dart';
import 'package:intl/intl.dart';

dbHelper helper = dbHelper();

parseDateTime(String date) {
  var db_date = DateTime.parse(date);
  var day = DateFormat('EEEE').format(db_date);
  var month_day = DateFormat('MMMMd').format(db_date);
  List d = [day, month_day];
  return d;
}


// This file makes the database object available throughout the project.