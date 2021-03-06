// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, non_constant_identifier_names

import 'package:diario/globals.dart';
import 'package:diario/models/diary_entry.dart';
import 'package:diario/pages/home.dart';
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

  // date to display
  List<dynamic> date_now = get_date();

  // form validation
  bool _validation_error = false;

  // moods
  int _moodSelectedIndex = 3;
  List moods = [
    "assets/icons/emoji_1.png",
    "assets/icons/emoji_2.png",
    "assets/icons/emoji_3.png",
    "assets/icons/emoji_4.png",
    "assets/icons/emoji_5.png"
  ];

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
        resizeToAvoidBottomInset: true,
        floatingActionButton: FloatingActionButton(
          backgroundColor: kBlue,
          onPressed: () async {
            FocusManager.instance.primaryFocus?.unfocus();
            print(
                "Title: ${titleController.value.text} \tStory: ${storyController.value.text} \tDate: ${date_now}");
            setState(() {
              titleController.text.isEmpty
                  ? _validation_error = true
                  : _validation_error = false;
            });
            if (_validation_error == false) {
              DiaryEntry diary_entry = DiaryEntry(
                  mood: _moodSelectedIndex,
                  title: titleController.value.text,
                  entry: storyController.value.text);

              await helper.insertEntry(diary_entry);
              Navigator.pop(context, Mobile());
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
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: Icon(
                            Icons.close,
                            color: Colors.grey,
                          ),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            "SAVE",
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w500),
                          ),
                          style: TextButton.styleFrom(
                            backgroundColor: kBlue,
                            primary: Colors.white,
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 30, top: 5),
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              date_now[0],
                              style: TextStyle(
                                  fontSize: 21,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 3),
                              child: Text(
                                date_now[1],
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey,
                                    fontSize: 15),
                              ),
                            ),
                          ],
                        ),
                        Spacer(),
                        // emoji dropdown
                        DropdownButton<dynamic>(
                            underline: SizedBox(),
                            // iconSize: 0.0,
                            value: _moodSelectedIndex,
                            items: moods.map((e) {
                              return DropdownMenuItem(
                                value: moods.indexOf(e) + 1,
                                child: Image(
                                  width: 40,
                                  height: 40,
                                  image: AssetImage(e),
                                ),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                _moodSelectedIndex = value;
                              });
                            }),
                      ],
                    ),
                  ),
                  TextField(
                    controller: titleController,
                    textCapitalization: TextCapitalization.sentences,
                    style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
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
                    maxLines: 20,
                    decoration: InputDecoration(
                      hintStyle: TextStyle(
                          fontWeight: FontWeight.normal, color: Colors.grey),
                      hintText: "Write more .....",
                      border: InputBorder.none,
                    ),
                  ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: moods.map((e) {
                  //     return _moodSelectedIndex == moods.indexOf(e) + 1
                  //         ? Container(
                  //             padding: EdgeInsets.all(0.5),
                  //             decoration: BoxDecoration(
                  //                 shape: BoxShape.circle,
                  //                 border: Border.all(width: 2, color: kBlue)),
                  //             child: Image(
                  //               image: AssetImage(e),
                  //               width: 42,
                  //               height: 42,
                  //             ),
                  //           )
                  //         : GestureDetector(
                  //             onTap: () {
                  //               setState(() {
                  //                 _moodSelectedIndex = moods.indexOf(e) + 1;
                  //               });
                  //             },
                  //             child: Image(
                  //               image: AssetImage(e),
                  //               width: 42,
                  //               height: 42,
                  //             ),
                  //           );
                  //   }).toList(),
                  // ),
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

List get_date() {
  var dateNow = DateTime.now();
  var day = DateFormat('EEEE').format(dateNow);
  var month_day = DateFormat('MMMMd').format(dateNow);
  List d = [day, month_day];
  return d;
}
