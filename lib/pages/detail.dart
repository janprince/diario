import 'package:flutter/material.dart';

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
