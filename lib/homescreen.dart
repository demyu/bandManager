import 'package:bandmanagement/DBhelper.dart';
import 'package:bandmanagement/bandDetailsScreen.dart';
import 'package:bandmanagement/bandEntry.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'band.dart';

class HomeScreen extends StatefulWidget {
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  final DBHelper db = DBHelper();
  List<Band> band;

  void load() async {
    band = List();
    band = await db.getBandList();

    setState(() {});
  }

  void refresh() {
    load();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (band == null) {
      load();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("BandManager"),
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          Container(
              width: MediaQuery.of(context).size.width,
              height: 300.00,
              decoration: new BoxDecoration(
                image: new DecorationImage(
                  image: ExactAssetImage('assets/logo/logo.jpg'),
                  fit: BoxFit.fitHeight,
                ),
              )),
          Container(
              height: MediaQuery.of(context).size.height / 4,
              width: MediaQuery.of(context).size.width,
              child: ListView.builder(
                  itemCount: band.length,
                  itemBuilder: (BuildContext contect, int index) {
                    final review = band[index];
                    return GestureDetector(
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 50,
                          color: Colors.red[300],
                          child: Center(
                            child: Text(band[index].getBandName()),
                          ),
                        ),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => BandDetailsScreen(
                                        bandOwner: review,
                                      )));
                        });
                  })),
          RaisedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => BandEntry(
                              homeScreenState: this,
                            )));
              },
              child: Center(child: Text("Add Band")))
        ],
      )),
    );
  }
}
