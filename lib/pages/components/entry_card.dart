import 'package:diario/constants.dart';
import 'package:diario/globals.dart';
import 'package:diario/pages/detail.dart';
import 'package:flutter/material.dart';

// entry card UI
class EntryCard extends StatelessWidget {
  String title;
  String entry;
  List date;
  int mood;
  int id;

  EntryCard(
      {Key? key,
      required this.title,
      required this.entry,
      required this.date,
      required this.mood,
      required this.id})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
      child: Material(
        color: kPrimary,
        elevation: 3,
        child: InkWell(
          onTap: (() {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => EntryDetail(
                          title: title,
                          id: id,
                          date: date,
                          mood: mood,
                          entry: entry,
                        )));
          }),
          child: Container(
            // margin: EdgeInsets.only(bottom: 10),
            padding: EdgeInsets.all(16),
            color: Colors.transparent,
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(children: [
                      Text(
                        date[1],
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: kBlue),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Icon(
                          Icons.circle,
                          size: 5,
                          color: kBlue,
                        ),
                      ),
                      Text(
                        date[0],
                        style: TextStyle(fontSize: 16, color: Colors.blueGrey),
                      )
                    ]),
                    SizedBox(
                      height: 12,
                    ),
                    Text(
                      title,
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          // fontFamily: "Roboto",
                          fontWeight: FontWeight.w500),
                    ),
                    Text(
                      entry.replaceRange(entry.length > 40 ? 40 : entry.length,
                          entry.length, "..."),
                      style: TextStyle(
                        fontSize: 13.5,
                        color: Colors.black,
                        fontFamily: "Roboto",
                      ),
                    ),
                  ],
                ),
                Spacer(),
                Image(
                  image: AssetImage(moods[mood - 1]),
                  width: 35,
                  height: 35,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
