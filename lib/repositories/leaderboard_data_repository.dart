import 'package:aoeiv_leaderboard/config/config.dart';
import 'package:aoeiv_leaderboard/models/player.dart';
import 'package:aoeiv_leaderboard/providers/leaderboard_data_provider.dart';
import 'package:aoeiv_leaderboard/utils/aoe_database.dart';
import 'package:aoeiv_leaderboard/utils/map_leaderboard_id_to_table.dart';
import 'package:http/http.dart';
import 'package:sqflite/sqflite.dart';

class LeaderboardDataRepository {
  final AoeDatabase _aoeDatabase = AoeDatabase();
  final LeaderboardDataProvider leaderboardDataProvider;
  final Config _config = Config();
  final Client _client = Client();

  LeaderboardDataRepository({required this.leaderboardDataProvider});

  Future<List<Player>> fetchLeaderboardData(int leaderboardId) async {
    final String url = "${_config.leaderboardBaseUrl}&leaderboard_id=$leaderboardId&start=1&count=${_config.leaderboardCount}";
    late final Database database = _aoeDatabase.database;
    late final int minToFetch = _aoeDatabase.minToFetch;
    final String table = mapLeaderboardIdToTable(leaderboardId);

    int? count = Sqflite.firstIntValue(await database.rawQuery('SELECT COUNT(*) FROM "$table"'));

    if (count == null || count < 1) {
      await _fetchDataAndSaveToDb(database, table, url);
    }

    final List<Map<String, dynamic>> leaderboardFirstPlayerData = await database.query(
      table,
      orderBy: PlayerField.rank,
      limit: 1,
    );
    final Map<String, dynamic> leaderboardDataFirst = leaderboardFirstPlayerData.first;
    final int now = DateTime.now().millisecondsSinceEpoch;
    final bool shouldUpdateDb = now - leaderboardDataFirst[PlayerField.timestamp] > minToFetch * 60 * 1000;

    if (shouldUpdateDb) {
      await _fetchDataAndUpdateDb(database, table, url);
    }

    final List<Map<String, dynamic>> leaderboardData = await database.query(
      table,
      orderBy: PlayerField.rank,
      limit: _config.leaderboardCount,
    );

    return leaderboardData.map((Map playerData) => Player.fromJson(playerData)).toList();
  }

  Future<List<Player>> searchPlayer(int leaderboardId, String playerName) async {
    final String url = "${_config.leaderboardBaseUrl}&leaderboard_id=$leaderboardId&search=$playerName&count=${_config.leaderboardCount}";
    final Map jsonData = await leaderboardDataProvider.fetchLeaderboardData(_client, url);

    return _parsePlayers(jsonData);
  }

  Future<void> _fetchDataAndSaveToDb(Database database, String table, String url) async {
    final Map jsonData = await leaderboardDataProvider.fetchLeaderboardData(_client, url);
    final List<Player> players = _parsePlayers(jsonData);

    final int timestamp = DateTime.now().millisecondsSinceEpoch;
    for (Player player in players) {
      await database.insert(
        table,
        {
          ...player.toMap(),
          PlayerField.timestamp: timestamp,
        },
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
  }

  Future<void> _fetchDataAndUpdateDb(Database database, String table, String url) async {
    final Map jsonData = await leaderboardDataProvider.fetchLeaderboardData(_client, url);
    final List<Player> players = _parsePlayers(jsonData);

    final int timestamp = DateTime.now().millisecondsSinceEpoch;
    for (Player player in players) {
      await database.update(
        table,
        {
          ...player.toMap(),
          PlayerField.timestamp: timestamp,
        },
        where: 'profile_id = ?',
        whereArgs: [player.profileId],
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
  }

  List<Player> _parsePlayers(Map jsonData) {
    final List leaderboardData = jsonData['leaderboard'];
    return leaderboardData.map((leaderboard) => Player.fromJson(leaderboard)).toList();
  }
}
