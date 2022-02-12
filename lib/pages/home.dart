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
                    EdgeInsets.only(top: 30, bottom: 60, left: 30, right: 30),
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
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Container(
              margin: EdgeInsets.only(bottom: 30, top: 85),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Latest Entries",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                  GestureDetector(
                    child: Text(
                      "Show more",
                      style: TextStyle(color: kBlue, fontSize: 15),
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
                  print(entries);

                  return Expanded(
                    child: ListView(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      children: entries.map((e) {
                        return Container(
                          margin: EdgeInsets.only(bottom: 10),
                          padding: EdgeInsets.symmetric(
                              horizontal: 15, vertical: 10),
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
                                      style: TextStyle(
                                          color: Colors.grey, fontSize: 13),
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

class EntryDetail extends StatelessWidget {
  const EntryDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          Row(
            children: [
              Icon(Icons.arrow_back),
              Spacer(
                flex: 10,
              ),
              Icon(Icons.edit),
              Spacer(
                flex: 1,
              ),
              Icon(Icons.menu)
            ],
          )
        ],
      )),
    );
  }
}
