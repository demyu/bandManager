import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'band.dart';
import 'members.dart';
import 'songs.dart';

class DBHelper {
  static DBHelper _dbHelper;
  static Database _db;

  DBHelper._createInstance();
  factory DBHelper() {
    if (_dbHelper == null) {
      _dbHelper = DBHelper._createInstance();
    }
    return _dbHelper;
  }

  Future<Database> initializeDatabase() async {
    return await openDatabase(
      join(await getDatabasesPath(), 'proto7.db'),
      onCreate: (db, version) {
        String table1 = """CREATE TABLE band(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            bandname VARCHAR NOT NULL,
            genre VARCHAR NOT NULL
          )""";
        String table2 = """CREATE TABLE members(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            membername VARCHAR NOT NULL,
            instrument VARCHAR NOT NULL,
            bandowner VARCHAR NOT NULL
          )""";
        String table3 = """CREATE TABLE songs(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            songname VARCHAR NOT NULL,
            date INTEGER NOT NULL,
            bandowner VARCHAR NOT NULL
          )""";
        db.execute(table1);
        db.execute(table2);
        db.execute(table3);
      },
      version: 1,
    );
  }

  Future<Database> getDatabase() async {
    if (_db == null) {
      _db = await initializeDatabase();
    }
    return _db;
  }

  Future<List<Band>> getBandList() async {
    var db = await this.getDatabase();
    var list = await db.query('band');
    List<Band> userList = [];
    for (var data in list) {
      userList.add(Band.fromDB(data));
    }
    return userList;
  }

  Future<List<Members>> getMemberList() async {
    var db = await this.getDatabase();
    var list = await db.query('members');
    List<Members> userList = [];
    for (var data in list) {
      userList.add(Members.fromDB(data));
    }
    return userList;
  }

  Future<List<Songs>> getSongList() async {
    var db = await this.getDatabase();
    var list = await db.query('songs');
    List<Songs> userList = [];
    for (var data in list) {
      userList.add(Songs.fromDB(data));
    }
    return userList;
  }

  Future<int> addBand(Band user) async {
    var db = await this.getDatabase();
    return await db.insert('band', user.toMap());
  }

  Future<int> addMember(Members restaurant) async {
    var db = await this.getDatabase();
    return await db.insert('members', restaurant.toMap());
  }

  Future<int> deleteMember(int id) async {
    var db = await this.getDatabase();
    return await db.delete('members', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> addSong(Songs review) async {
    var db = await this.getDatabase();
    return await db.insert('songs', review.toMap());
  }

  Future<int> deleteSong(int id) async {
    var db = await this.getDatabase();
    return await db.delete('songs', where: 'id = ?', whereArgs: [id]);
  }
}
