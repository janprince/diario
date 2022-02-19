import 'package:diario/constants.dart';
import 'package:diario/globals.dart';
import 'package:diario/pages/components/entry_card.dart';
import 'package:flutter/material.dart';

class Entries extends StatelessWidget {
  const Entries({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        child: Column(children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 26),
            child: Container(
              margin: EdgeInsets.only(bottom: 25, top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "All Entries",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 15.5),
                  ),
                ],
              ),
            ),
          ),
          FutureBuilder(
            future: gbEntries,
            builder:
                (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                    child: CircularProgressIndicator(
                        // value: 3.0,
                        ));
              } else {
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  List entries = snapshot.data!;
                  return Expanded(
                    child: ListView(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      children: entries.map((e) {
                        return EntryCard(
                          id: e['id'],
                          title: e['title'],
                          entry: e['entry'],
                          date: parseDateTime(e['date_created']),
                          mood: e['mood'],
                        );
                      }).toList(),
                    ),
                  );
                }
              }
            },
          ),
        ]),
      ),
    );
  }
}
