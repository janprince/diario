import 'package:diario/globals.dart';
import 'package:diario/pages/home.dart';
import 'package:flutter/material.dart';

class EntryDetail extends StatefulWidget {
  String title;
  String entry;
  List date;
  int mood;
  int id;

  EntryDetail(
      {Key? key,
      required this.title,
      required this.entry,
      required this.date,
      required this.mood,
      required this.id})
      : super(key: key);

  @override
  State<EntryDetail> createState() => _EntryDetailState();
}

class _EntryDetailState extends State<EntryDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: (() => Navigator.pop(context)),
                  child: Icon(
                    Icons.arrow_back,
                  ),
                ),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.only(right: 17),
                  child: Icon(Icons.edit),
                ),
                GestureDetector(
                    onTap: () {
                      _showMaterialDialog(context);
                    },
                    child: Icon(Icons.delete))
              ],
            ),
            Container(
              margin: EdgeInsets.only(bottom: 35, top: 30),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.date[0],
                        style: TextStyle(
                            fontSize: 21,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 3),
                        child: Text(
                          widget.date[1],
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
                  Image(
                    image: AssetImage(moods[widget.mood - 1]),
                    width: 35,
                    height: 35,
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Text(
                widget.title,
                style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(child: SingleChildScrollView(child: Text(widget.entry))),
          ],
        ),
      )),
    );
  }

  void _showMaterialDialog(BuildContext dialogContext) {
    AlertDialog alert = AlertDialog(
      // title: Text("Discard Entry"),
      content: Text("Are you sure you want to delete?"),
      actions: [
        TextButton(
            onPressed: () async {
              await helper.deleteEntry(widget.id);
              Navigator.pop(dialogContext);
              Navigator.pop(context, Mobile());
            },
            child: Text(
              "Delete",
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
