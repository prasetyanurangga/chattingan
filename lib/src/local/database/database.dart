import 'dart:async';
import 'dart:io';import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
final userTABLE = 'user';
final tempTABLE = 'temp';

class DatabaseProvider {
  static final DatabaseProvider dbProvider = DatabaseProvider();
  Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await createDatabase();
    return _database;
  }

  createDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "Humana.db");
    var database = await openDatabase(path, version: 1, onCreate: initTable, onUpgrade: onUpgrade);
    return database;
  }  //This is optional, and only used for changing DB schema migrations

  void onUpgrade(Database database, int oldVersion, int newVersion) {
    if (newVersion > oldVersion) {}
  }

  void initTable(Database database, int version) async {
    await database.execute("CREATE TABLE $userTABLE ("
        "id TEXT PRIMARY KEY, "
        "email TEXT, "
        "username TEXT"
        ")"
    );
  }

}