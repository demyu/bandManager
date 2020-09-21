import 'package:bandmanagement/DBhelper.dart';
import 'package:bandmanagement/homescreen.dart';
import 'package:flutter/material.dart';

import 'band.dart';

class BandEntry extends StatefulWidget {
  HomeScreenState homeScreenState;

  BandEntry({this.homeScreenState});
  BandEntryState createState() => BandEntryState();
}

class BandEntryState extends State<BandEntry> {
  final DBHelper db = DBHelper();
  final name = TextEditingController();
  String genre;
  void addBand() {
    String a = name.text;
    Band band = Band(a, genre);
    db.addBand(band);
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
        appBar: AppBar(
          title: Text("Add Band"),
        ),
        body: Column(children: [
          TextField(
            controller: name,
            decoration: InputDecoration(
                border: InputBorder.none, hintText: 'Enter Band name'),
          ),
          DropdownButton<String>(
            value: genre,
            items: <String>['Rock', 'Metal', 'Alluminum'].map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                genre = value;
              });
            },
          ),
          RaisedButton(
              onPressed: () {
                addBand();
                widget.homeScreenState.refresh();
                Navigator.pop(context);
              },
              child: Center(child: Text("Save"))),
          RaisedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Center(child: Text("Back")))
        ]));
  }
}
