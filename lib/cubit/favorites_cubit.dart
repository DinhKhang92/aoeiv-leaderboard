import 'package:aoeiv_leaderboard/models/favorite.dart';
import 'package:aoeiv_leaderboard/repositories/favorites_data_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'favorites_state.dart';

class FavoritesCubit extends Cubit<FavoritesState> {
  final FavoritesDataRepository favoritesDataRepository;
  FavoritesCubit({required this.favoritesDataRepository}) : super(const FavoritesInitial(favorites: []));

  Future<void> initDb() async {
    emit(FavoritesLoading(favorites: state.favorites));
    await favoritesDataRepository.initDb();
    emit(FavoritesLoaded(favorites: state.favorites));
  }

  Future<void> updateFavorites(int leaderboardId, int profileId, String name) async {
    emit(FavoritesLoading(favorites: state.favorites));
    final List<Favorite> favorites = await favoritesDataRepository.updateFavorites(leaderboardId, profileId, name);
    emit(FavoritesLoaded(favorites: favorites));
  }
}
