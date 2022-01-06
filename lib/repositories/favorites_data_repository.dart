import 'package:aoeiv_leaderboard/models/favorite.dart';
import 'package:aoeiv_leaderboard/utils/aoe_database.dart';

class FavoritesDataRepository {
  final AoeDatabase _aoeDatabase = AoeDatabase();

  Future<void> initDb() async => await _aoeDatabase.initDb();

  Future<List<Favorite>> updateFavorites(int leaderboardId, int profileId, String name) async {
    final Favorite favorite = Favorite.fromJSON({
      "profile_id": profileId,
      "leaderboard_id": leaderboardId,
      "name": name,
    });

    final List savedFavorites = await _aoeDatabase.getFavorites();
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
}
