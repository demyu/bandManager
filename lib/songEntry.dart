import 'package:bandmanagement/DBhelper.dart';
import 'package:bandmanagement/bandDetailsScreen.dart';
import 'package:bandmanagement/songs.dart';
import 'package:flutter/material.dart';

import 'band.dart';
import 'members.dart';

class SongEntry extends StatefulWidget {
  Band x;
  BandDetailsScreenState bandDetailsScreenState;
  SongEntry({this.x, this.bandDetailsScreenState});

  SongEntryState createState() => SongEntryState();
}

class SongEntryState extends State<SongEntry> {
  final DBHelper db = DBHelper();
  final name = TextEditingController();
  final date = TextEditingController();
  void addSong() {
    int temp = int.parse(date.text);
    String a = name.text;
    Songs member = Songs(a, temp, widget.x.getBandName());
    db.addSong(member);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Text("Add Song"),
        ),
        body: Column(children: [
          TextField(
            controller: name,
            decoration: InputDecoration(
                border: InputBorder.none, hintText: 'Enter Song name'),
          ),
          TextField(
            controller: date,
            decoration: InputDecoration(
                border: InputBorder.none, hintText: 'Enter Release year'),
          ),
          
          RaisedButton(
              onPressed: () {
                addSong();
                widget.bandDetailsScreenState.refresh();
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
