// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:diario/models/database.dart';
import 'package:diario/models/diary.dart';
import 'package:intl/intl.dart';
import 'package:diario/constants.dart';
import 'package:flutter/material.dart';

class EntryPage extends StatefulWidget {
  const EntryPage({Key? key}) : super(key: key);

  @override
  State<EntryPage> createState() => _EntryPageState();
}

class _EntryPageState extends State<EntryPage> {
  TextEditingController titleController = TextEditingController();

  TextEditingController storyController = TextEditingController();

  var date_now =
      DateFormat('EEEE, dd/MM/yyyy').format(DateTime.now()).toString();

  bool _validation_error = false;

  @override
  void dispose() {
    storyController.dispose();
    titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _showMaterialDialog(context);
        return true;
      },
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: kBlue,
          onPressed: () async {
            print(
                "Title: ${titleController.value.text} \tStory: ${storyController.value.text} \tDate: ${date_now}");
            setState(() {
              titleController.text.isEmpty
                  ? _validation_error = true
                  : _validation_error = false;
            });
            if (_validation_error == false) {
              DiaryEntry diary_entry = DiaryEntry(
                  date: date_now,
                  title: titleController.value.text,
                  entry: storyController.value.text);

              await insertEntry(diary_entry);
              List e = await entries();
              print("trtrtt ${e}");
            }
          },
          child: Icon(
            Icons.done,
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        // resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 100,
                        margin: EdgeInsets.only(right: 13),
                        padding: EdgeInsets.all(8),
                        color: kSecondary,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(
                              Icons.emoji_emotions,
                              size: 15,
                            ),
                            Text(
                              "Add emoji",
                              style: TextStyle(fontSize: 12),
                            )
                          ],
                        ),
                      ),
                      Container(
                        width: 100,
                        margin: EdgeInsets.only(right: 13),
                        padding: EdgeInsets.all(8),
                        color: kSecondary,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(
                              Icons.image,
                              size: 15,
                            ),
                            Text(
                              "Add image",
                              style: TextStyle(fontSize: 12),
                            )
                          ],
                        ),
                      ),
                      Spacer(),
                      TextButton(
                        onPressed: () => _showMaterialDialog(context),
                        child: Text(
                          "Cancel",
                          style: TextStyle(
                              color: kBlue,
                              fontWeight: FontWeight.w700,
                              fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 40),
                    child: Text(
                      date_now,
                      style: TextStyle(
                          fontWeight: FontWeight.w500, color: Colors.grey),
                    ),
                  ),
                  TextField(
                    controller: titleController,
                    textCapitalization: TextCapitalization.sentences,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(bottom: 0),
                      errorText: _validation_error ? 'Field required' : null,
                      hintStyle: TextStyle(
                          fontWeight: FontWeight.normal, color: Colors.grey),
                      hintText: "Title",
                      border: InputBorder.none,
                    ),
                  ),
                  TextField(
                    controller: storyController,
                    textCapitalization: TextCapitalization.sentences,
                    maxLines: 25,
                    decoration: InputDecoration(
                      hintStyle: TextStyle(
                          fontWeight: FontWeight.normal, color: Colors.grey),
                      hintText: "Write a story",
                      border: InputBorder.none,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Widget dialog() {
  //   return AlertDialog(
  //     title: Text("Discard Entry"),
  //     content: Text("Are you sure you want to discard ?"),
  //     actions: [
  //       TextButton(onPressed: () {}, child: Text("Discard")),
  //       TextButton(onPressed: () {}, child: Text("Cancel"))
  //     ],
  //   );
  // }

  void _showMaterialDialog(BuildContext dialogContext) {
    AlertDialog alert = AlertDialog(
      // title: Text("Discard Entry"),
      content: Text("Are you sure you want to discard ?"),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.of(context).popUntil((route) => route.isFirst);
            },
            child: Text(
              "Discard",
              style: TextStyle(color: Colors.black),
            )),
        TextButton(
            onPressed: () {
              Navigator.pop(dialogContext);
            },
            child: Text(
              "Cancel",
              style: TextStyle(color: Colors.black),
            ))
      ],
    );
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        });
  }
}
