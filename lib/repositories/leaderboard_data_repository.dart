import 'package:aoeiv_leaderboard/config/config.dart';
import 'package:aoeiv_leaderboard/models/player.dart';
import 'package:aoeiv_leaderboard/providers/leaderboard_data_provider.dart';
import 'package:aoeiv_leaderboard/utils/aoe_database.dart';
import 'package:http/http.dart';
import 'package:sqflite/sqflite.dart';

class LeaderboardDataRepository {
  final AoeDatabase _aoeDatabase = AoeDatabase();
  final LeaderboardDataProvider leaderboardDataProvider;
  final Config _config = Config();
  final Client _client = Client();

  LeaderboardDataRepository({required this.leaderboardDataProvider});

  Future<List<Player>> fetchLeaderboardData(int leaderboardId) async {
    late final Database database = _aoeDatabase.database;
    late final String tableNamePlayer = _aoeDatabase.tableNamePlayer;
    late final int minToFetch = _aoeDatabase.minToFetch;

    int? count = Sqflite.firstIntValue(await database.rawQuery('SELECT COUNT(*) FROM "$tableNamePlayer"'));

    if (count == null || count < 1) {
      print("FETCH");
      final String url = "${_config.leaderboardBaseUrl}&leaderboard_id=$leaderboardId&start=1&count=${_config.leaderboardCount}";
      final Map jsonData = await leaderboardDataProvider.fetchLeaderboardData(_client, url);
      final List<Player> players = _parsePlayers(jsonData);

      final int timestamp = DateTime.now().millisecondsSinceEpoch;
      for (Player player in players) {
        await database.insert(
          tableNamePlayer,
          {
            ...player.toMap(),
            PlayerField.timestamp: timestamp,
          },
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }
    }

    final List<Map<String, dynamic>> leaderboardData = await database.query(
      tableNamePlayer,
      orderBy: PlayerField.rank,
      limit: _config.leaderboardCount,
    );
    print(leaderboardData);
    final Map<String, dynamic> leaderboardDataFirst = leaderboardData.first;
    print(leaderboardDataFirst[PlayerField.timestamp]);
    final now = DateTime.now().millisecondsSinceEpoch;
    print(now - leaderboardDataFirst[PlayerField.timestamp]);
    final bool shouldFetchData = now - leaderboardDataFirst[PlayerField.timestamp] > minToFetch * 60 * 1000;
    print(shouldFetchData);
    // return [];
    return leaderboardData.map((Map playerData) => Player.fromJson(playerData)).toList();
  }

  Future<List<Player>> searchPlayer(int leaderboardId, String playerName) async {
    final String url = "${_config.leaderboardBaseUrl}&leaderboard_id=$leaderboardId&search=$playerName&count=${_config.leaderboardCount}";
    final Map jsonData = await leaderboardDataProvider.fetchLeaderboardData(_client, url);

    return _parsePlayers(jsonData);
  }

  List<Player> _parsePlayers(Map jsonData) {
    final List leaderboardData = jsonData['leaderboard'];
    return leaderboardData.map((leaderboard) => Player.fromJson(leaderboard)).toList();
  }
}
