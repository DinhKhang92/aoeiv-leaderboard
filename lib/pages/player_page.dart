import 'package:aoeiv_leaderboard/config/config.dart';
import 'package:aoeiv_leaderboard/config/styles/colors.dart';
import 'package:aoeiv_leaderboard/cubit/rating_history_data_cubit.dart';
import 'package:aoeiv_leaderboard/cubit/rating_history_mode_selector_cubit.dart';
import 'package:aoeiv_leaderboard/models/player.dart';
import 'package:aoeiv_leaderboard/utils/get_leaderboard_id.dart';
import 'package:aoeiv_leaderboard/widgets/background.dart';
import 'package:aoeiv_leaderboard/widgets/centered_circular_progress_indicator.dart';
import 'package:aoeiv_leaderboard/widgets/header.dart';
import 'package:aoeiv_leaderboard/widgets/line_chart.dart';
import 'package:aoeiv_leaderboard/widgets/rating_history_mode_selector.dart';
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
    BlocProvider.of<RatingHistoryModeSelectorCubit>(context).clear();

    _fetchRatingHistoryData();
    super.initState();
  }

  Future<void> _fetchRatingHistoryData() async {
    BlocProvider.of<RatingHistoryDataCubit>(context).fetchRatingHistoryData(LeaderboardId.oneVOne.id, widget.player.profileId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const Background(),
          SafeArea(
            child: Container(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Header(headerTitle: AppLocalizations.of(context)!.pageTitlePlayerDetails),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: _buildRatingHistoryModeSelectors(),
                  ),
                  const SizedBox(height: 30),
                  Text("Name: ${widget.player.name}"),
                  Text("MMR: ${widget.player.mmr}"),
                  Text("Wins: ${widget.player.totalWins}"),
                  Text("Losses: ${widget.player.totalLosses}"),
                  Text("Winrate: ${widget.player.winRate} %"),
                  const SizedBox(height: 30),
                  const Align(
                    alignment: Alignment.center,
                    child: Text(
                      "- MMR History -",
                      style: TextStyle(
                        color: Color(0xffB6B6B6),
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  _buildRatingHistoryLineChart(),
                  const SizedBox(height: 15),
                ],
              ),
            ),
          ),
        ],
      ),
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
            return TestLineChart(ratingHistoryData: state.ratingHistoryData);
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  List<Widget> _buildRatingHistoryModeSelectors() {
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
            BlocBuilder<RatingHistoryModeSelectorCubit, RatingHistoryModeSelectorState>(
              builder: (context, state) {
                return InkWell(
                  onTap: () {
                    if (state.index != index) {
                      BlocProvider.of<RatingHistoryModeSelectorCubit>(context).setIndex(index);

                      final int leaderboardId = getLeaderboardId(index);
                      BlocProvider.of<RatingHistoryDataCubit>(context).fetchRatingHistoryData(leaderboardId, widget.player.profileId);
                    }
                  },
                  child: RatingHistoryModeSelector(
                    label: label,
                    labelColor: secondaryColor,
                    backgroundColor: state.index == index ? primaryColor : const Color(0xffB6B6B6),
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
