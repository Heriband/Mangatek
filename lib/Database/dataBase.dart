import 'package:mangatek/Model/Manga.dart';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';


const String DATABASENAME = "MangatekDataBase.db";
const String MANGATABLE = "MangaTable";
const String COLUMNID = "id";


class dataBase {
  late final Database _database;

  dataBase(){
    initializeDatabase();
  }

  bool isOpen(){
    return _database.isOpen;
  }


  Future<bool> isDatabaseOpen() async {
    print(isOpen());
    return isOpen();
  }

  Future<void> initializeDatabase() async {
    final String dbPath = await getDatabasesPath();
    final String path = join(dbPath, DATABASENAME);
    print("init Database");
    _database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        db.execute(
          "CREATE TABLE $MANGATABLE ($COLUMNID INTEGER PRIMARY KEY AUTOINCREMENT, Name TEXT, Popularity INTEGER, Volume INTEGER);",
        );
        print('Database Created');
      },
    );
  }

  Future<void> insertManga(Manga manga) async {
    if (_database == null) return;
    print("add manga");
    _database.insert(
      MANGATABLE,
      manga.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }


  Future<void> deletManga(Manga manga) async {
    if (_database == null) return;
    print("add manga");
    _database.delete(
      MANGATABLE,
      where: "name = ?",
      whereArgs: [manga.name],
    );
  }

  Future<List<Manga>> getMangas() async {
    final List<Map<String, dynamic>> maps =
    await _database.rawQuery('SELECT * FROM ' + MANGATABLE);
    print(maps);
    return List.generate(maps.length, (i) {
      return Manga(
        name: maps[i]['Name'].toString(),
        popularity: maps[i]['Popularity'],
        volume: maps[i]['Volume'],
      );
    });
  }
}
