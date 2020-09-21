import 'package:bandmanagement/DBhelper.dart';
import 'package:bandmanagement/band.dart';
import 'package:bandmanagement/homescreen.dart';
import 'package:bandmanagement/memberEntry.dart';
import 'package:bandmanagement/songEntry.dart';
import 'package:bandmanagement/songs.dart';
import 'package:flutter/material.dart';

import 'members.dart';

class BandDetailsScreen extends StatefulWidget {
  Band bandOwner;
  BandDetailsScreen({this.bandOwner});
  BandDetailsScreenState createState() => BandDetailsScreenState();
}

class BandDetailsScreenState extends State<BandDetailsScreen> {
  final DBHelper db = DBHelper();
  List<Songs> songs;
  List<Songs> loadedSongs;
  List<Members> members;
  List<Members> loadedMembers;

  var picture;

  void load() async {
    songs = List();
    loadedSongs = List();
    members =List();
    loadedMembers = List();

    songs = await db.getSongList();
    members = await db.getMemberList();

    for (int i = 0; i < songs.length; i++) {
      if (songs[i].getOwner() == widget.bandOwner.getBandName()) {
        loadedSongs.add(songs[i]);
      }
    }
    for (int i = 0; i < members.length; i++) {
      if (members[i].getOwner() == widget.bandOwner.getBandName()) {
        loadedMembers.add(members[i]);
      }
    }

    
    setState(() {});
  }

  void refresh() {
    load();
    setState(() {});
  }

  void removeSong(int id) async {
    await db.deleteSong(id);
    load();
  }

  void removeMember(int id) async {
    await db.deleteMember(id);
    load();
  }

  void getPicture() {
    switch (widget.bandOwner.getGenre()) {
      case "Rock":
        picture = Container(
            width: MediaQuery.of(context).size.width,
            height: 300.00,
            decoration: new BoxDecoration(
              image: new DecorationImage(
                image: ExactAssetImage('assets/genre/rock.jpg'),
                fit: BoxFit.fitHeight,
              ),
            ));
        break;
      case "Metal":
        picture = Container(
            width: MediaQuery.of(context).size.width,
            height: 300.00,
            decoration: new BoxDecoration(
              image: new DecorationImage(
                image: ExactAssetImage('assets/genre/metal.jpg'),
                fit: BoxFit.fitHeight,
              ),
            ));
        break;
      case "Alluminum":
        picture = Container(
            width: MediaQuery.of(context).size.width,
            height: 300.00,
            decoration: new BoxDecoration(
              image: new DecorationImage(
                image: ExactAssetImage('assets/genre/alluminum.jpg'),
                fit: BoxFit.fitHeight,
              ),
            ));
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    getPicture();
    if (loadedSongs == null) {
      load();
    }
    if(loadedMembers == null){
      load();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.bandOwner.getBandName()),
      ),
      body: SingleChildScrollView(child: Column(
        children: [
          picture,
          Container(
            width: MediaQuery.of(context).size.width,
            child: Center(child: Text("Members")),
            color: Colors.red,
          ),
          Container(
              height: MediaQuery.of(context).size.height / 4,
              width: MediaQuery.of(context).size.width,
              child: ListView.builder(
                  itemCount: loadedMembers.length,
                  itemBuilder: (BuildContext contect, int index) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      color: Colors.red[300],
                      child: Row(
                        children: [
                          Text(loadedMembers[index].getMember().toString()),
                          SizedBox(width: 40),
                          Text(loadedMembers[index].getInstrument()),
                          SizedBox(width: 40),
                          IconButton(
                              icon: Icon(Icons.remove_circle),
                              onPressed: () {
                                removeMember(loadedMembers[index].getId());
                              })
                        ],
                      ),
                    );
                  })),
          RaisedButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => MemberEntry(
                            x: widget.bandOwner,
                            bandDetailsScreenState: this,
                          )));
            },
            child: Text("Add Member"),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            child: Center(child: Text("Songs")),
            color: Colors.red,
          ),
          Container(
              height: MediaQuery.of(context).size.height / 4,
              width: MediaQuery.of(context).size.width,
              child: ListView.builder(
                  itemCount: loadedSongs.length,
                  itemBuilder: (BuildContext contect, int index) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      color: Colors.red[300],
                      child: Row(
                        children: [
                          Text(loadedSongs[index].getSongName()),
                          IconButton(
                              icon: Icon(Icons.remove_circle),
                              onPressed: () {
                                removeSong(loadedSongs[index].getId());
                              })
                        ],
                      ),
                    );
                  })),
          RaisedButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => SongEntry(
                            x: widget.bandOwner,
                            bandDetailsScreenState: this,
                          )));
            },
            child: Text("Add Song"),
          ),
          RaisedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("Back"),
          ),
        ],
      ),)
    );
  }
}
