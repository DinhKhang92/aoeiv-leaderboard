import 'package:aoeiv_leaderboard/config/styles/colors.dart';
import 'package:aoeiv_leaderboard/config/styles/spacing.dart';
import 'package:aoeiv_leaderboard/cubit/game_mode_selector_cubit.dart';
import 'package:aoeiv_leaderboard/cubit/match_history_data_cubit.dart';
import 'package:aoeiv_leaderboard/cubit/rating_history_data_cubit.dart';
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
import 'package:aoeiv_leaderboard/widgets/rating_history_mode_selector.dart';
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
    _clearRatingHistoryGameMode();
    _initGameMode();
    _fetchData(widget.leaderboardId);
    super.initState();
  }

  void _clearRatingHistoryGameMode() {
    BlocProvider.of<GameModeSelectorCubit>(context).clearRatingHistoryGameMode();
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Header(headerTitle: widget.player.name),
                SizedBox(height: Spacing.xl.spacing),
                _buildRatingHistoryModeSelectors(),
                SizedBox(height: Spacing.l.spacing),
                const PlayerStats(),
                SizedBox(height: Spacing.xl.spacing),
                Expanded(
                  child: ListView(
                    physics: const ClampingScrollPhysics(),
                    children: [
                      BlocBuilder<GameModeSelectorCubit, GameModeSelectorState>(
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
                      ),
                    ],
                  ),
                ),
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
          child: Row(
            children: _getRatingHistoryModeSelectors(),
          ),
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
                  flex: 1,
                  fit: FlexFit.tight,
                  child: InkWell(
                    onTap: () {
                      if (state.ratingHistoryGameModeIndex != index) {
                        BlocProvider.of<GameModeSelectorCubit>(context).setRatingHistoryGameMode(index);

                        final int leaderboardId = mapIndexToLeaderboardId(index);
                        _fetchData(leaderboardId);
                      }
                    },
                    child: RatingHistoryModeSelector(
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
}
