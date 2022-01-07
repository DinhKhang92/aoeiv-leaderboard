import 'package:aoeiv_leaderboard/config/styles/colors.dart';
import 'package:aoeiv_leaderboard/config/styles/spacing.dart';
import 'package:aoeiv_leaderboard/cubit/favorites_cubit.dart';
import 'package:aoeiv_leaderboard/cubit/game_mode_selector_cubit.dart';
import 'package:aoeiv_leaderboard/cubit/match_history_data_cubit.dart';
import 'package:aoeiv_leaderboard/cubit/rating_history_data_cubit.dart';
import 'package:aoeiv_leaderboard/models/favorite.dart';
import 'package:aoeiv_leaderboard/models/player.dart';
import 'package:aoeiv_leaderboard/pages/player_page/widgets/match_history_section.dart';
import 'package:aoeiv_leaderboard/pages/player_page/widgets/player_detail_bottom_navigation_bar.dart';
import 'package:aoeiv_leaderboard/utils/map_index_to_leaderboard_id.dart';
import 'package:aoeiv_leaderboard/utils/map_leaderboard_id_to_index.dart';
import 'package:aoeiv_leaderboard/widgets/background.dart';
import 'package:aoeiv_leaderboard/pages/player_page/widgets/civ_pick_section.dart';
import 'package:aoeiv_leaderboard/widgets/header.dart';
import 'package:aoeiv_leaderboard/pages/player_page/widgets/mmr_history_section.dart';
import 'package:aoeiv_leaderboard/pages/player_page/widgets/player_stats.dart';
import 'package:aoeiv_leaderboard/pages/player_page/widgets/player_detail_game_mode_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PlayerPage extends StatefulWidget {
  final Player player;
  final int leaderboardId;

  const PlayerPage({required this.leaderboardId, required this.player, Key? key}) : super(key: key);

  @override
  _PlayerPageState createState() => _PlayerPageState();
}

class _PlayerPageState extends State<PlayerPage> {
  @override
  void initState() {
    _clearPlayerDetailNavigation();
    _initGameMode();
    _fetchData(widget.leaderboardId);
    super.initState();
  }

  void _clearPlayerDetailNavigation() {
    BlocProvider.of<GameModeSelectorCubit>(context).clearPlayerDetailNavigation();
  }

  void _initGameMode() {
    BlocProvider.of<GameModeSelectorCubit>(context).setRatingHistoryGameMode(mapLeaderboardIdToIndex(widget.leaderboardId));
  }

  Future<void> _fetchData(int leaderboardId) async {
    BlocProvider.of<RatingHistoryDataCubit>(context).fetchPlayerData(leaderboardId, widget.player.profileId);
    BlocProvider.of<MatchHistoryDataCubit>(context).fetchMatchHistoryData(leaderboardId, widget.player.profileId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
      bottomNavigationBar: const PlayerDetailBottomNavigationBar(),
    );
  }

  Widget _buildBody() {
    return Stack(
      children: [
        const Background(),
        SafeArea(
          child: Container(
            padding: EdgeInsets.all(Spacing.m.spacing),
            child: Column(
              children: [
                Header(
                  headerTitle: widget.player.name,
                  trailing: BlocListener<FavoritesCubit, FavoritesState>(
                    listener: (context, state) {
                      if (state is FavoritesLoaded) {
                        final bool couldAddFavorite = state.favorites.where((Favorite favorite) => favorite.profileId == widget.player.profileId).toList().isEmpty;
                        if (!couldAddFavorite) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              duration: const Duration(milliseconds: 1200),
                              backgroundColor: kcTertiaryColor,
                              content: Text(AppLocalizations.of(context)!.playerDetailSnackbarMessageFavoriteAdded(widget.player.name)),
                            ),
                          );
                        }
                      }
                    },
                    child: BlocBuilder<FavoritesCubit, FavoritesState>(
                      builder: (context, state) {
                        final bool couldAddFavorite = state.favorites.where((Favorite favorite) => favorite.profileId == widget.player.profileId).toList().isEmpty;

                        return InkWell(
                          onTap: () => BlocProvider.of<FavoritesCubit>(context).updateFavorites(widget.leaderboardId, widget.player.profileId, widget.player.name),
                          child: couldAddFavorite ? const Icon(Icons.star_border) : const Icon(Icons.star),
                        );
                      },
                    ),
                  ),
                ),
                SizedBox(height: Spacing.xl.spacing),
                _buildRatingHistoryModeSelectors(),
                SizedBox(height: Spacing.l.spacing),
                const PlayerStats(),
                SizedBox(height: Spacing.xl.spacing),
                _buildContent(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRatingHistoryModeSelectors() {
    return BlocBuilder<MatchHistoryDataCubit, MatchHistoryDataState>(
      builder: (context, state) {
        return AbsorbPointer(
          absorbing: state is MatchHistoryDataLoading,
          child: Row(children: _getRatingHistoryModeSelectors()),
        );
      },
    );
  }

  List<Widget> _getRatingHistoryModeSelectors() {
    final List<String> buttonLabels = [
      AppLocalizations.of(context)!.bottomNavigationBarLabel1v1,
      AppLocalizations.of(context)!.bottomNavigationBarLabel2v2,
      AppLocalizations.of(context)!.bottomNavigationBarLabel3v3,
      AppLocalizations.of(context)!.bottomNavigationBarLabel4v4,
    ];
    final Map buttonLabelsMap = buttonLabels.asMap();
    return buttonLabelsMap
        .map((index, label) {
          return MapEntry(
            index,
            BlocBuilder<GameModeSelectorCubit, GameModeSelectorState>(
              builder: (context, state) {
                return Flexible(
                  fit: FlexFit.tight,
                  child: InkWell(
                    onTap: () {
                      if (state.ratingHistoryGameModeIndex != index) {
                        BlocProvider.of<GameModeSelectorCubit>(context).setRatingHistoryGameMode(index);

                        final int leaderboardId = mapIndexToLeaderboardId(index);
                        _fetchData(leaderboardId);
                      }
                    },
                    child: PlayerDetailGameModeSelector(
                      label: label,
                      labelColor: kcSecondaryColor,
                      backgroundColor: state.ratingHistoryGameModeIndex == index ? kcPrimaryColor : kcUnselectedColor,
                    ),
                  ),
                );
              },
            ),
          );
        })
        .values
        .toList();
  }

  Widget _buildContent() {
    return BlocBuilder<GameModeSelectorCubit, GameModeSelectorState>(
      builder: (context, state) {
        switch (state.playerDetailModeIndex) {
          case (0):
            return const MmrHistorySection();
          case (1):
            return const CivPickSection();
          case (2):
            return MatchHistorySection(player: widget.player);
          default:
            return const SizedBox.shrink();
        }
      },
    );
  }
}
