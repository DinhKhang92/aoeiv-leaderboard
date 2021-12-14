import 'package:aoeiv_leaderboard/config/config.dart';
import 'package:aoeiv_leaderboard/config/styles/colors.dart';
import 'package:aoeiv_leaderboard/config/styles/spacing.dart';
import 'package:aoeiv_leaderboard/cubit/game_mode_selector_cubit.dart';
import 'package:aoeiv_leaderboard/cubit/match_history_data_cubit.dart';
import 'package:aoeiv_leaderboard/cubit/rating_history_data_cubit.dart';
import 'package:aoeiv_leaderboard/models/player.dart';
import 'package:aoeiv_leaderboard/utils/map_index_to_leaderboard_id.dart';
import 'package:aoeiv_leaderboard/widgets/background.dart';
import 'package:aoeiv_leaderboard/widgets/centered_circular_progress_indicator.dart';
import 'package:aoeiv_leaderboard/widgets/header.dart';
import 'package:aoeiv_leaderboard/widgets/line_chart.dart';
import 'package:aoeiv_leaderboard/widgets/rating_history_mode_selector.dart';
import 'package:aoeiv_leaderboard/widgets/section_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PlayerPage extends StatefulWidget {
  final Player player;

  const PlayerPage({required this.player, Key? key}) : super(key: key);

  @override
  _PlayerPageState createState() => _PlayerPageState();
}

class _PlayerPageState extends State<PlayerPage> {
  @override
  void initState() {
    BlocProvider.of<GameModeSelectorCubit>(context).clearRatingHistoryGameMode();
    BlocProvider.of<MatchHistoryDataCubit>(context).fetchMatchHistoryData(widget.player.profileId);

    _fetchRatingHistoryData();
    super.initState();
  }

  Future<void> _fetchRatingHistoryData() async {
    BlocProvider.of<RatingHistoryDataCubit>(context).fetchPlayerData(LeaderboardId.oneVOne.id, widget.player.profileId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
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
                _buildStats(),
                SizedBox(height: Spacing.xl.spacing),
                SectionTitle(title: AppLocalizations.of(context)!.sectionTitleMmrHistory),
                _buildRatingHistoryLineChart(),
                SizedBox(height: Spacing.m.spacing),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStats() {
    return BlocBuilder<RatingHistoryDataCubit, RatingHistoryDataState>(
      builder: (context, state) {
        final String mmr = state.ratingHistoryData.isEmpty ? "-" : "${state.ratingHistoryData.first.rating}";
        final String wins = state.ratingHistoryData.isEmpty ? "-" : "${state.ratingHistoryData.first.totalWins}";
        final String losses = state.ratingHistoryData.isEmpty ? "-" : "${state.ratingHistoryData.first.totalLosses}";
        final String winRate = state.ratingHistoryData.isEmpty ? "-" : "${state.ratingHistoryData.first.winRate}";
        final int mmrDifference = 0;
        // final int mmrDifference = state.player?.previousRating != null ? int.parse(mmr) - state.player!.previousRating! : int.parse(mmr);
        print(mmrDifference);
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("#${state.player?.rank} | $mmr "),
            Icon(
              mmrDifference > 0 ? Icons.arrow_upward : Icons.arrow_downward,
              size: 14,
              color: mmrDifference > 0 ? Colors.green : Colors.red,
            ),
            Text(
              "${mmrDifference.abs()}",
              style: TextStyle(color: mmrDifference > 0 ? Colors.green : Colors.red),
            ),
            Text(" | $winRate% - "),
            Text(
              "${wins}W ",
              style: const TextStyle(color: Colors.green),
            ),
            Text(
              "${losses}L",
              style: const TextStyle(color: Colors.red),
            ),
          ],
        );
      },
    );
  }

  void getDiff(RatingHistoryDataState state, Player player) {}

  Row _buildRatingHistoryModeSelectors() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: _getRatingHistoryModeSelectors(),
    );
  }

  Widget _buildRatingHistoryLineChart() {
    return Container(
      constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.width - 50),
      child: BlocBuilder<RatingHistoryDataCubit, RatingHistoryDataState>(
        builder: (context, state) {
          if (state is RatingHistoryDataLoading) {
            return const CenteredCircularProgressIndicator();
          }
          if (state is RatingHistoryDataLoaded) {
            return RatingLineChart(ratingHistoryData: state.ratingHistoryData);
          }
          return const SizedBox.shrink();
        },
      ),
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
                return InkWell(
                  onTap: () {
                    if (state.ratingHistoryGameModeIndex != index) {
                      BlocProvider.of<GameModeSelectorCubit>(context).setRatingHistoryGameMode(index);

                      final int leaderboardId = mapIndexToLeaderboardId(index);
                      BlocProvider.of<RatingHistoryDataCubit>(context).fetchPlayerData(leaderboardId, widget.player.profileId);
                    }
                  },
                  child: RatingHistoryModeSelector(
                    label: label,
                    labelColor: kcSecondaryColor,
                    backgroundColor: state.ratingHistoryGameModeIndex == index ? kcPrimaryColor : kcUnselectedColor,
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
