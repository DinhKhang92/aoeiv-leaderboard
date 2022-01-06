import 'dart:developer' as developer;

import 'package:aoeiv_leaderboard/models/favorite.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class AoeDatabase {
  static final AoeDatabase _aoeDatabase = AoeDatabase._internal();
  final String favoritesTable = "favorites";
  late Database database;

  factory AoeDatabase() => _aoeDatabase;

  AoeDatabase._internal();

  Future<void> initDb() async {
    await _createDb();
  }

  Future<void> _createDb() async {
    print("database created");
    developer.log("database created");
    final String dbPath = await getDatabasesPath();
    database = await openDatabase(
      join(dbPath, 'aoe_database.db'),
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute(
          '''
          create table "$favoritesTable" (
            "${FavoriteField.id}" integer primary key,
            "${FavoriteField.profileId}" integer not null,
            "${FavoriteField.leaderboardId}" integer not null,
            "${FavoriteField.name}" text not null
          )
          ''',
        );
      },
    );
  }

  Future<List> getFavorites() async {
    List favorites = await database.query(favoritesTable);
    return favorites;
  }

  Future<void> addFavorite(Favorite favorite) async {
    await database.insert(
      favoritesTable,
      favorite.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> removeFavorite(Favorite favorite) async {
    await database.delete(
      favoritesTable,
      where: '${FavoriteField.profileId} = ?',
      whereArgs: [favorite.profileId],
    );
  }

  Future<void> closeDb() async {
    await database.close();
    developer.log("database closed");
  }

  Future<void> deleteDb() async {
    final String dbPath = await getDatabasesPath();
    await databaseFactory.deleteDatabase(dbPath);
    developer.log("database deleted");
  }
}
