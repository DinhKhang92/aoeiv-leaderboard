import 'package:aoeiv_leaderboard/models/player.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class AoeDatabase {
  static final AoeDatabase _aoeDatabase = AoeDatabase._internal();
  final String tableNamePlayer = "players";
  final int minToFetch = 15;
  late Database database;

  factory AoeDatabase() => _aoeDatabase;

  AoeDatabase._internal();

  Future<void> init() async {
    // await _resetDb();
    await _createDb();

    // final Player onePlayer = Player.fromJson(exampleLeaderboardPlayerOne);
    // final Database db = database;
    // await db.insert(tableNamePlayer, onePlayer.toMap());
    // print("INSERTED");

    // final List<Map<String, dynamic>> maps = await database.query(tableNamePlayer);
    // print(maps);
  }

  Future<void> _createDb() async {
    database = await openDatabase(
      join(await getDatabasesPath(), 'leaderboard_database.db'),
      onCreate: (Database db, int version) {
        print("new table: $tableNamePlayer created.");
        return db.execute(
          '''
          create table "$tableNamePlayer" (
            "${PlayerField.id}" integer primary key,
            "${PlayerField.timestamp}" integer not null,
            "${PlayerField.rank}" integer not null,
            "${PlayerField.name}" text not null,
            "${PlayerField.games}" integer not null,
            "${PlayerField.wins}" integer not null,
            "${PlayerField.losses}" integer not null,
            "${PlayerField.rating}" integer not null,
            "${PlayerField.profileId}" integer not null,
            "${PlayerField.winRate}" integer not null,
            "${PlayerField.previousRating}" integer
          )
          ''',
        );
      },
      onUpgrade: (Database db, int oldVersion, int newVersion) {
        print("oldVersion: $oldVersion, newVersion: $newVersion");
        if (oldVersion < newVersion) {
          db.execute('''ALTER TABLE "$tableNamePlayer" ADD COLUMN timestamp integer''');
          print("upgraded");
        }
      },
      version: 1,
    );
  }

  Future<void> _resetDb() async {
    await _deleteDb().then((_) async => await _createDb());
  }

  Future<void> _deleteDb() async {
    databaseFactory.deleteDatabase(await getDatabasesPath());
    print("deleted");
  }
}
