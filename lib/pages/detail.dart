import 'package:diario/globals.dart';
import 'package:flutter/material.dart';

class EntryDetail extends StatelessWidget {
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
                Icon(Icons.delete)
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
                        date[0],
                        style: TextStyle(
                            fontSize: 21,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 3),
                        child: Text(
                          date[1],
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
                    image: AssetImage(moods[mood - 1]),
                    width: 35,
                    height: 35,
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Text(
                title,
                style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(child: SingleChildScrollView(child: Text(entry))),
          ],
        ),
      )),
    );
  }
}
