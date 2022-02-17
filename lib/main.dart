// ignore_for_file: prefer_const_constructors

import 'package:diario/constants.dart';
import 'package:diario/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  // open database
  runApp(DiaryApp());
}

class DiaryApp extends StatelessWidget {
  const DiaryApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          scaffoldBackgroundColor: kPrimary,
          textTheme: GoogleFonts.amethystaTextTheme(
            Theme.of(context).textTheme,
          )),
      home: Mobile(),
    );
  }
}
