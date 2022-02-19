import 'package:diario/constants.dart';
import 'package:diario/globals.dart';
import 'package:flutter/material.dart';

class statCard extends StatefulWidget {
  const statCard({Key? key}) : super(key: key);

  @override
  _statCardState createState() => _statCardState();
}

class _statCardState extends State<statCard> {
  // int n_entries = gbEntries != null ? gbEntries!.length : 000;
  // var average_mood = 000;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      color: kPrimary,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            margin: EdgeInsets.only(right: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: Text(
                    "Entries",
                    style: TextStyle(fontSize: 13.5, color: kBlue),
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    // no of diary entries
                    FutureBuilder(
                        // wait for the global db to be filed
                        future: gbEntries,
                        builder: (BuildContext context,
                            AsyncSnapshot<List<dynamic>> snapshot) {
                          if (snapshot.hasData) {
                            List entries = snapshot.data!;
                            int n_entries = entries.length;
                            return Text(
                              "$n_entries",
                              style: TextStyle(
                                  fontSize: 19, fontWeight: FontWeight.bold),
                            );
                          } else {
                            return CircularProgressIndicator();
                          }
                        }),
                    Text(
                      " entries",
                      style: TextStyle(fontSize: 13, color: Colors.grey),
                    )
                  ],
                )
              ],
            ),
          ),
          SizedBox(
            width: 50,
          ),
          Container(
            margin: EdgeInsets.only(right: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: Text(
                    "Average Mood",
                    style: TextStyle(fontSize: 13.5, color: kBlue),
                  ),
                ),

                // average mood
                FutureBuilder(
                    // wait for the global db to be filed
                    future: gbEntries,
                    builder: (BuildContext context,
                        AsyncSnapshot<List<dynamic>> snapshot) {
                      if (snapshot.hasData) {
                        List entries = snapshot.data!;
                        int sum = 0;
                        for (int i = 0; i < entries.length; i++) {
                          sum = sum + entries[i]['mood'].hashCode;
                        }
                        double average_mood = sum / entries.length;
                        return Image(
                          image: AssetImage(
                              'assets/icons/emoji_${average_mood.round()}.png'),
                          width: 30,
                          height: 30,
                        );
                      } else {
                        return CircularProgressIndicator();
                      }
                    }),

                // Row(
                //   crossAxisAlignment: CrossAxisAlignment.end,
                //   children: [
                //     Text(
                //       "1189",
                //       style: TextStyle(
                //           fontSize: 19,
                //           fontWeight: FontWeight.bold),
                //     ),
                //     Text(
                //       " steps",
                //       style: TextStyle(
                //           fontSize: 13, color: Colors.grey),
                //     )
                //   ],
                // )
              ],
            ),
          ),
          Divider(color: Colors.grey),
        ],
      ),
    );
  }
}
