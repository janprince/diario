// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:math';

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
        child: Icon(Icons.add),
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
                      image: AssetImage("assets/images/bg_1.jpg"),
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
                          "Elizabeth",
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
                  child: Container(
                    padding: EdgeInsets.all(20),
                    color: kPrimary,
                    child: Row(
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
                                  style:
                                      TextStyle(fontSize: 13.5, color: kBlue),
                                ),
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    "1189",
                                    style: TextStyle(
                                        fontSize: 19,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    " entries",
                                    style: TextStyle(
                                        fontSize: 13, color: Colors.grey),
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
                                  style:
                                      TextStyle(fontSize: 13.5, color: kBlue),
                                ),
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    "1189",
                                    style: TextStyle(
                                        fontSize: 19,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    " steps",
                                    style: TextStyle(
                                        fontSize: 13, color: Colors.grey),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                        Divider(color: Colors.grey),
                      ],
                    ),
                  ),
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
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  GestureDetector(
                    child: Text(
                      "Show more",
                      style: TextStyle(color: kBlue, fontSize: 16),
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
                return Text("Loading....");
              } else {
                if (snapshot.hasError)
                  return Center(child: Text('Error: ${snapshot.error}'));
                else {
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
                // Container(
                //   margin: EdgeInsets.only(right: 15),
                //   width: 8,
                //   height: 50,
                //   color: Colors.blue,
                // ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(children: [
                      Text(
                        date[1],
                        style: TextStyle(
                            fontSize: 16.5,
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
                        style:
                            TextStyle(fontSize: 16.5, color: Colors.blueGrey),
                      )
                    ]),
                    SizedBox(
                      height: 12,
                    ),
                    Text(
                      title,
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontFamily: "Roboto",
                          fontWeight: FontWeight.w500),
                    ),
                    Text(
                      entry,
                      style: TextStyle(
                        fontSize: 15,
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
