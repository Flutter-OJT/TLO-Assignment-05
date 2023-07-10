//import 'dart:io';

import 'package:sqflite/sqflite.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';

/// # EntityService
///
/// The entity service
///
/// @author TintLwinOo
class EntityService {
  late Database _database;

  /// Empty constructor
  EntityService();

  /// ## initialize
  ///
  /// Initialize the database
  Future<void> initialize() async {
    //var projectpath = Directory.current;

    var databasePath = await getDatabasesPath();
    String path = join(databasePath, 'user.db');
    _database = await openDatabase(path, version: 1, onCreate: _onDbCreate); //
  }

  /// ## _onDbCreate
  ///
  /// Create table on database newly created.
  ///
  /// [Parameters]:
  ///   - db [Database]
  ///   - version [Version]
  Future<void> _onDbCreate(Database db, int version) async {
    // create all tables from the models
    await db.execute(
        'CREATE TABLE IF NOT EXISTS userinfo (id INTEGER PRIMARY KEY, name STRING, email STRING, password STRING, created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP)');
    await db.rawInsert(
      'INSERT INTO userinfo (id, name, email, password) VALUES (0, "Admin", "admin@gmail.com", "d033e22ae348aeb5660fc2140aec35850c4da997")',
    );
  }

  get database => _database;
}
