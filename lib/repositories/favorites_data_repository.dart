import 'package:aoeiv_leaderboard/config/config.dart';
import 'package:aoeiv_leaderboard/exceptions/no_data_exception.dart';
import 'package:aoeiv_leaderboard/models/favorite.dart';
import 'package:aoeiv_leaderboard/models/player.dart';
import 'package:aoeiv_leaderboard/providers/leaderboard_data_provider.dart';
import 'package:aoeiv_leaderboard/database/aoe_database.dart';
import 'package:http/http.dart';

class FavoritesDataRepository {
  final LeaderboardDataProvider leaderboardDataProvider;
  final AoeDatabase _aoeDatabase = AoeDatabase();
  final Config _config = Config();
  final Client _client = Client();

  FavoritesDataRepository({required this.leaderboardDataProvider});

  Future<void> initDb() async => await _aoeDatabase.initDb();

  Future<List<Favorite>> updateFavorites(int leaderboardId, int profileId, String name) async {
    final Favorite favorite = Favorite.fromJSON({
      FavoriteField.profileId: profileId,
      FavoriteField.leaderboardId: leaderboardId,
      FavoriteField.name: name,
    });

    final List<dynamic> savedFavorites = await _aoeDatabase.getFavorites();
    final List<Favorite> favorites = savedFavorites.map((json) => Favorite.fromJSON(json)).toList();
    final bool shouldAddFavorite = favorites.where((Favorite favorite) => favorite.profileId == profileId).toList().isEmpty;

    if (shouldAddFavorite) {
      _aoeDatabase.addFavorite(favorite);
      favorites.add(favorite);
    } else {
      _aoeDatabase.removeFavorite(favorite);
      favorites.remove(favorite);
    }

    return favorites;
  }

  Future<List<Favorite>> loadFavorites() async {
    final List savedFavorites = await _aoeDatabase.getFavorites();
    final List<Favorite> favorites = savedFavorites.map((json) => Favorite.fromJSON(json)).toList();
    return favorites;
  }

  Future<Player> fetchLeaderboardDataByProfileId(int leaderboardId, int profileId) async {
    final String url = "${_config.leaderboardBaseUrl}&leaderboard_id=$leaderboardId&profile_id=$profileId";
    final Map jsonData = await leaderboardDataProvider.fetchLeaderboardData(_client, url);

    final List<Player> players = _parsePlayers(jsonData);

    if (players.isEmpty) {
      throw NoDataException("No Player data found for profile_id: $profileId");
    }

    return players.first;
  }

  List<Player> _parsePlayers(Map jsonData) {
    final List leaderboardData = jsonData['leaderboard'];
    return leaderboardData.map((leaderboard) => Player.fromJson(leaderboard)).toList();
  }
}
