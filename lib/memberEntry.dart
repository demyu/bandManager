import 'package:bandmanagement/DBhelper.dart';
import 'package:bandmanagement/bandDetailsScreen.dart';
import 'package:flutter/material.dart';

import 'band.dart';
import 'members.dart';

class MemberEntry extends StatefulWidget {
  Band x;
  BandDetailsScreenState bandDetailsScreenState;
  MemberEntry({this.x, this.bandDetailsScreenState});

  MemberEntryState createState() => MemberEntryState();
}

class MemberEntryState extends State<MemberEntry> {
  final DBHelper db = DBHelper();
  final name = TextEditingController();
  String instrument;
  void addMember() {
    String b = instrument.toString();
    String a = name.text;
    Members member = Members(a, b, widget.x.getBandName());
    db.addMember(member);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Text("Add Member"),
        ),
        body: Column(children: [
          TextField(
            controller: name,
            decoration: InputDecoration(
                border: InputBorder.none, hintText: 'Enter Member name'),
          ),
          DropdownButton<String>(
            value: instrument,
            items: <String>['Gt', 'Dr', 'Vo', 'Key', 'Ba'].map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                instrument = value;
              });
            },
          ),
          RaisedButton(
              onPressed: () {
                addMember();
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
