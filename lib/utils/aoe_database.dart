import 'package:aoeiv_leaderboard/models/player.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class AoeDatabaseTable {
  static const String oneVOne = 'one_v_one';
  static const String twoVTwo = 'two_v_two';
  static const String threeVThree = 'three_v_three';
  static const String fourVFour = 'four_v_four';
}

class AoeDatabase {
  static final AoeDatabase _aoeDatabase = AoeDatabase._internal();
  final List<String> tables = [
    AoeDatabaseTable.oneVOne,
    AoeDatabaseTable.twoVTwo,
    AoeDatabaseTable.threeVThree,
    AoeDatabaseTable.fourVFour,
  ];
  final int minToFetch = 15;
  late Database database;

  factory AoeDatabase() => _aoeDatabase;

  AoeDatabase._internal();

  Future<void> init() async {
    await _resetDb();
    // await _createDb();
  }

  Future<void> _createDb() async {
    database = await openDatabase(
      join(await getDatabasesPath(), 'leaderboard_database.db'),
      onCreate: (Database db, int version) async {
        for (String table in tables) {
          await db.execute(
            '''
          create table "$table" (
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
        }
      },
      // onUpgrade: (Database db, int oldVersion, int newVersion) {
      //   if (oldVersion < newVersion) {
      //     db.execute('''ALTER TABLE "$tableNamePlayer" ADD COLUMN timestamp integer''');
      //     print("upgraded");
      //   }
      // },
      version: 1,
    );
  }

  Future<void> _resetDb() async {
    await _deleteDb().then((_) async => await _createDb());
  }

  Future<void> _deleteDb() async {
    databaseFactory.deleteDatabase(await getDatabasesPath());
  }
}
