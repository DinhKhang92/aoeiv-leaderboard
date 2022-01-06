part of 'favorites_cubit.dart';

abstract class FavoritesState extends Equatable {
  final List<Favorite> favorites;
  const FavoritesState({required this.favorites});

  @override
  List<Object> get props => [favorites];
}

class FavoritesInitial extends FavoritesState {
  const FavoritesInitial({required List<Favorite> favorites}) : super(favorites: favorites);
}

class FavoritesLoading extends FavoritesState {
  const FavoritesLoading({required List<Favorite> favorites}) : super(favorites: favorites);
}

class FavoritesLoaded extends FavoritesState {
  const FavoritesLoaded({required List<Favorite> favorites}) : super(favorites: favorites);
}
