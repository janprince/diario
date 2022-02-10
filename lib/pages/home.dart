// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:diario/constants.dart';
import 'package:diario/models/db_functions.dart';
import 'package:diario/pages/entry.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// fetch data from db
Future<List> entries() async {
  List e = await getEntries();
  var date = DateTime.parse(e[0]['date_created']);
  var day = DateFormat('EEEE').format(date);
  var month_day = DateFormat('MMMMd').format(date);
  List d = [day, month_day];
  return d;
}

class Mobile extends StatefulWidget {
  const Mobile({Key? key}) : super(key: key);

  @override
  State<Mobile> createState() => _MobileState();
}

class _MobileState extends State<Mobile> {
  // for bottom navbar
  int _selectedIndex = 0;
  void _onItemSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // entries
  Future<List> entries = getEntries();

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
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => EntryPage()));
        },
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

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
                padding:
                    EdgeInsets.only(top: 20, bottom: 50, left: 30, right: 30),
                color: kPrimary,
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
                          ),
                        ),
                        Text(
                          "Elizabeth",
                          style: TextStyle(
                              fontSize: 17.5, fontWeight: FontWeight.bold),
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
                left: 30,
                right: 30,
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
            padding: EdgeInsets.only(top: 85, left: 30, right: 30, bottom: 20),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Latest Entries",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 14),
                      ),
                      GestureDetector(
                        child: Text(
                          "Show more",
                          style: TextStyle(color: kBlue, fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  color: kPrimary,
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin: EdgeInsets.only(right: 15),
                        width: 10,
                        height: 50,
                        color: Colors.blue,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(bottom: 3),
                            child: Text(
                              "10: 00 am",
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 13),
                            ),
                          ),
                          Text(
                            "November 13",
                            style: TextStyle(
                                fontSize: 17,
                                color: Colors.black,
                                fontFamily: "Roboto",
                                fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
                      Spacer(),
                      Icon(
                        Icons.chevron_right,
                        color: Colors.grey,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
