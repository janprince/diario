// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:diario/constants.dart';
import 'package:diario/globals.dart';
import 'package:diario/models/db_helper.dart';
import 'package:diario/pages/entry.dart';
import 'package:flutter/material.dart';

class Mobile extends StatefulWidget {
  const Mobile({Key? key}) : super(key: key);

  @override
  State<Mobile> createState() => _MobileState();
}

class _MobileState extends State<Mobile> {
  // Pages
  // for bottom navbar
  int _selectedIndex = 0;
  void _onItemSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Home(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: kBlue,
        backgroundColor: kPrimary,
        onTap: (value) => _onItemSelected(value),
        currentIndex: _selectedIndex,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.book), label: "Entries"),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: kBlue,
        onPressed: () {
          // push to the entry page and on pop, rebuild.
          Navigator.push(
                  context, MaterialPageRoute(builder: (context) => EntryPage()))
              .then((_) => setState(() {}));
        },
        child: Icon(Icons.create_rounded),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future<List> fetchEntry() async {
    Future<List> entries = helper.getEntries();
    // make the entries available to entire app
    gbEntries = entries;
    return entries;
  }

  // entries (data from db)

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: MediaQuery.of(context).size.width * 0.3,
      color: kSecondary,
      // padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: kPrimary,
                  image: DecorationImage(
                      image: AssetImage("assets/images/bg_2.jpg"),
                      fit: BoxFit.cover),
                ),
                padding:
                    EdgeInsets.only(top: 30, bottom: 60, left: 26, right: 26),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Good Morning",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "Prince",
                          style: TextStyle(
                            fontSize: 17.5,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    CircleAvatar(
                      radius: 25,
                      backgroundImage: AssetImage("assets/girl.jpg"),
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: -50,
                left: 26,
                right: 26,
                child: Material(
                  elevation: 9,
                  child: statCard(),
                ),
              )
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 26),
            child: Container(
              margin: EdgeInsets.only(bottom: 30, top: 85),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Latest Entries",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 15.5),
                  ),
                  GestureDetector(
                    child: Text(
                      "Show more",
                      style: TextStyle(color: kBlue, fontSize: 15.5),
                    ),
                  ),
                ],
              ),
            ),
          ),
          FutureBuilder(
            future: fetchEntry(),
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
                  print("sssssssssssuccessssss");
                  List entries = snapshot.data!;

                  print(entries[0]['mood'].runtimeType);

                  return Expanded(
                    child: ListView(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      children: entries.map((e) {
                        return EntryCard(
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
        ],
      ),
    );
  }
}

// entry card UI
class EntryCard extends StatelessWidget {
  String title;
  String entry;
  List date;
  int mood;

  EntryCard(
      {Key? key,
      required this.title,
      required this.entry,
      required this.date,
      required this.mood})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
      child: Material(
        color: kPrimary,
        elevation: 3,
        child: InkWell(
          onTap: (() {}),
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
                              'assets/icons/emoji_${average_mood.toInt()}.png'),
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
