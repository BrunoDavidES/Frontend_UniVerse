import 'package:flutter/widgets.dart';
import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'user_data.dart';

const String localDatabaseName = "universe-fct.db";

class LocalDB {
  late final String databaseName;
  late Database db;

  LocalDB(this.databaseName);

  Future<Database> initDB() async {
    WidgetsFlutterBinding.ensureInitialized();

    String path = await getDatabasesPath();

    db = await openDatabase(
      join(path, databaseName),
      onCreate: _onCreate,
      version: 1,
    );

    return db;
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.transaction((txn) async {
      await txn.execute('CREATE TABLE users (id TEXT PRIMARY KEY, name TEXT, role TEXT, lastLogin INTEGER)');
    });
  }

  // TODO: Draft function. You should adapt after extending the user table
  // with its last position
  Future<void> addUser(final UniverseUser u) async {

    // The `conflictAlgorithm` is used to select the strategy to be used in case
    // the user already exists. In this case, replace any previous data.
    /*await db.insert(
      'users',
      //u.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );*/
  }

  Future<int> countUsers() async {
    final db = await initDB();
    List<Map> list = await db.rawQuery('SELECT * FROM users');

    return list.length;
  }

  Future<void> listAllTables() async {
    final db = await initDB();
    final tables = await db.rawQuery('SELECT * FROM sqlite_master ORDER BY name;');
  }

  Future<List<Map>> fetchUserData(final String id) async {
    final db = await initDB();
    List<Map> u = await db.rawQuery('SELECT * FROM users WHERE users.id=id');
    return u;
  }

}
