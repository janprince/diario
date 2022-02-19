// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:diario/constants.dart';
import 'package:diario/globals.dart';
import 'package:diario/pages/components/entry_card.dart';
import 'package:diario/pages/components/stat_card.dart';
import 'package:diario/pages/entries.dart';
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
        child: _selectedIndex == 0 ? Home() : Entries(),
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
                    onTap: (() {
                      setState(() {});
                    }),
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
        ],
      ),
    );
  }
}
