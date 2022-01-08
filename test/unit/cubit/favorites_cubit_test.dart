import 'package:aoeiv_leaderboard/cubit/favorites_cubit.dart';
import 'package:aoeiv_leaderboard/exceptions/fetch_data_exception.dart';
import 'package:aoeiv_leaderboard/models/favorite.dart';
import 'package:aoeiv_leaderboard/repositories/favorites_repository.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'favorites_cubit_test.mocks.dart';

@GenerateMocks([FavoritesRepository])
void main() {
  final MockFavoritesDataRepository _mockFavoritesDataRepository = MockFavoritesDataRepository();

  late FavoritesCubit _favoritesCubit;

  setUp(() {
    _favoritesCubit = FavoritesCubit(favoritesDataRepository: _mockFavoritesDataRepository);
  });
  group("FavoritesCubit", () {
    blocTest<FavoritesCubit, FavoritesState>(
      "emits FavoritesLoadinag and FavoritesLoaded after init",
      build: () {
        when(_mockFavoritesDataRepository.loadFavorites()).thenAnswer((realInvocation) async => [
              Favorite.fromJSON(const {"leaderboard_id": 17, "profile_id": 123123, "name": "T0nb3rry"})
            ]);

        return _favoritesCubit;
      },
      act: (cubit) => cubit.init(),
      expect: () => [isA<FavoritesLoading>(), isA<FavoritesLoaded>()],
    );
    blocTest<FavoritesCubit, FavoritesState>(
      "emits FavoritesLoadinag and FavoritesLoaded after updating favorites",
      build: () {
        when(_mockFavoritesDataRepository.updateFavorites(17, 123123, "T0nb3rry")).thenAnswer((realInvocation) async => [
              Favorite.fromJSON(const {"leaderboard_id": 17, "profile_id": 123123, "name": "T0nb3rry"})
            ]);

        return _favoritesCubit;
      },
      act: (cubit) => cubit.updateFavorites(17, 123123, "T0nb3rry"),
      expect: () => [isA<FavoritesLoading>(), isA<FavoritesLoaded>()],
    );
    blocTest<FavoritesCubit, FavoritesState>(
      "emits FavoritesLoadinag and FavoritesLoaded after fetching a favorite",
      build: () {
        when(_mockFavoritesDataRepository.fetchLeaderboardDataByProfileId(17, 123123)).thenThrow(FetchDataException("failed"));

        return _favoritesCubit;
      },
      act: (cubit) => cubit.fetchFavorite(17, 123123),
      expect: () => [isA<FavoritesLoading>(), isA<FavoritesError>()],
    );
  });
}
