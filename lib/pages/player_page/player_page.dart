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
import 'package:aoeiv_leaderboard/widgets/tutorial_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

class PlayerPage extends StatefulWidget {
  final Player player;
  final int leaderboardId;

  const PlayerPage({required this.leaderboardId, required this.player, Key? key}) : super(key: key);

  @override
  _PlayerPageState createState() => _PlayerPageState();
}

class _PlayerPageState extends State<PlayerPage> {
  final GlobalKey _favoritesButtonKey = GlobalKey();

  @override
  void initState() {
    _clearPlayerDetailNavigation();
    _initGameMode();
    _fetchData(widget.leaderboardId);
    _showTutorial();
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
            padding: EdgeInsets.all(Spacing.m.value),
            child: Column(
              children: [
                _buildHeader(),
                SizedBox(height: Spacing.xl.value),
                _buildRatingHistoryModeSelectors(),
                SizedBox(height: Spacing.l.value),
                const PlayerStats(),
                SizedBox(height: Spacing.xl.value),
                _buildContent(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHeader() {
    return Header(
      headerTitle: widget.player.name,
      trailing: BlocConsumer<FavoritesCubit, FavoritesState>(
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
        builder: (context, state) {
          final bool couldAddFavorite = state.favorites.where((Favorite favorite) => favorite.profileId == widget.player.profileId).toList().isEmpty;

          return InkWell(
            key: _favoritesButtonKey,
            onTap: () => BlocProvider.of<FavoritesCubit>(context).updateFavorites(widget.leaderboardId, widget.player.profileId, widget.player.name),
            child: couldAddFavorite ? const Icon(Icons.star_border) : const Icon(Icons.star),
          );
        },
      ),
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

  void _showTutorial() {
    final TutorialCoachMark tutorial = TutorialCoachMark(
      context,
      hideSkip: true,
      targets: [
        TargetFocus(
          enableOverlayTab: true,
          keyTarget: _favoritesButtonKey,
          contents: [
            TargetContent(
              align: ContentAlign.bottom,
              child: Builder(builder: (context) {
                return TutorialContent(
                  title: AppLocalizations.of(context)!.tutorialFavoritesListHeader,
                  description: AppLocalizations.of(context)!.tutorialFavoriteAddDescription,
                );
              }),
            )
          ],
        ),
      ],
    );

    Future.delayed(const Duration(milliseconds: 700), () {
      tutorial.show();
    });
  }
}
