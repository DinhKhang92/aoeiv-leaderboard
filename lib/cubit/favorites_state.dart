part of 'favorites_cubit.dart';

abstract class FavoritesState extends Equatable {
  final List<Favorite> favorites;
  final Player? favorite;
  final int? leaderboardId;
  final Exception? error;

  const FavoritesState({required this.favorites, this.favorite, this.leaderboardId, this.error});

  @override
  List<Object> get props => [favorites];
}

class FavoritesInitial extends FavoritesState {
  const FavoritesInitial({required List<Favorite> favorites}) : super(favorites: favorites);
}

class FavoritesLoading extends FavoritesState {
  const FavoritesLoading({required List<Favorite> favorites, Player? favorite, int? leaderboardId}) : super(favorites: favorites, favorite: favorite, leaderboardId: leaderboardId);
}

class FavoritesLoaded extends FavoritesState {
  const FavoritesLoaded({required List<Favorite> favorites, Player? favorite, int? leaderboardId}) : super(favorites: favorites, favorite: favorite, leaderboardId: leaderboardId);
}

class FavoritesNavigation extends FavoritesState {
  const FavoritesNavigation({required List<Favorite> favorites, required Player favorite, required int leaderboardId})
      : super(favorites: favorites, favorite: favorite, leaderboardId: leaderboardId);
}

class FavoritesError extends FavoritesState {
  const FavoritesError({final Exception? error, required List<Favorite> favorites, Player? favorite, int? leaderboardId})
      : super(favorites: favorites, favorite: favorite, leaderboardId: leaderboardId, error: error);
}
