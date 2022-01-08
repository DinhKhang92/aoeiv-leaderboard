import 'package:aoeiv_leaderboard/models/favorite.dart';
import 'package:aoeiv_leaderboard/models/player.dart';
import 'package:aoeiv_leaderboard/repositories/favorites_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'favorites_state.dart';

class FavoritesCubit extends Cubit<FavoritesState> {
  final FavoritesRepository favoritesDataRepository;
  FavoritesCubit({required this.favoritesDataRepository}) : super(const FavoritesInitial(favorites: []));

  Future<void> init() async {
    emit(FavoritesLoading(favorites: state.favorites, favorite: state.favorite, leaderboardId: state.leaderboardId));
    await favoritesDataRepository.initDb();
    final List<Favorite> favorites = await favoritesDataRepository.loadFavorites();
    emit(FavoritesLoaded(favorites: favorites, favorite: state.favorite, leaderboardId: state.leaderboardId));
  }

  Future<void> updateFavorites(int leaderboardId, int profileId, String name) async {
    emit(FavoritesLoading(favorites: state.favorites, favorite: state.favorite, leaderboardId: state.leaderboardId));
    final List<Favorite> favorites = await favoritesDataRepository.updateFavorites(leaderboardId, profileId, name);
    emit(FavoritesLoaded(favorites: favorites, favorite: state.favorite, leaderboardId: state.leaderboardId));
  }

  Future<void> fetchFavorite(int leaderboardId, int profileId) async {
    try {
      emit(FavoritesLoading(favorites: state.favorites));
      final Player favorite = await favoritesDataRepository.fetchLeaderboardDataByProfileId(leaderboardId, profileId);
      emit(FavoritesNavigation(favorites: state.favorites, favorite: favorite, leaderboardId: leaderboardId));
    } on Exception catch (error, _) {
      emit(FavoritesError(error: error, favorites: state.favorites, favorite: state.favorite, leaderboardId: state.leaderboardId));
    }
  }
}
