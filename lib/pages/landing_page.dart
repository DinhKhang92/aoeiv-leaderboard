import 'dart:async';

import 'package:aoeiv_leaderboard/config/config.dart';
import 'package:aoeiv_leaderboard/config/styles/colors.dart';
import 'package:aoeiv_leaderboard/config/styles/spacing.dart';
import 'package:aoeiv_leaderboard/config/styles/theme.dart';
import 'package:aoeiv_leaderboard/cubit/game_mode_selector_cubit.dart';
import 'package:aoeiv_leaderboard/cubit/leaderboard_data_cubit.dart';
import 'package:aoeiv_leaderboard/models/player.dart';
import 'package:aoeiv_leaderboard/models/rating_history_screen_args.dart';
import 'package:aoeiv_leaderboard/utils/debouncer.dart';
import 'package:aoeiv_leaderboard/utils/map_index_to_leaderboard_id.dart';
import 'package:aoeiv_leaderboard/utils/map_index_to_game_mode.dart';
import 'package:aoeiv_leaderboard/widgets/background.dart';
import 'package:aoeiv_leaderboard/widgets/centered_circular_progress_indicator.dart';
import 'package:aoeiv_leaderboard/widgets/custom_bottom_navigation_bar.dart';
import 'package:aoeiv_leaderboard/widgets/error_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  final TextEditingController _searchFieldController = TextEditingController();
  final Debouncer _debouncer = Debouncer(milliseconds: 700);

  @override
  void initState() {
    _init();
    super.initState();
  }

  @override
  void dispose() {
    _searchFieldController.dispose();
    super.dispose();
  }

  Future<void> _init() async {
    await BlocProvider.of<LeaderboardDataCubit>(context).fetchLeaderboardData(LeaderboardId.oneVOne.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CustomBottomNavigationBar(searchFieldController: _searchFieldController),
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
              children: [
                _buildHeader(),
                SizedBox(height: Spacing.l.spacing),
                _buildSearchbar(),
                SizedBox(height: Spacing.l.spacing),
                _buildLeaderboardHeader(),
                SizedBox(height: Spacing.m.spacing),
                _buildLeaderboard(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLeaderboard() {
    return BlocBuilder<LeaderboardDataCubit, LeaderboardDataState>(
      builder: (context, state) {
        if (state is LeaderboardDataLoading) {
          return const Expanded(child: CenteredCircularProgressIndicator());
        }

        if (state is LeaderboardDataLoaded) {
          final List data = _searchFieldController.text.isEmpty ? state.leaderboardData : state.searchedPlayers;

          return _buildLeaderboardDataLoaded(data);
        }
        if (state is LeaderboardDataError) {
          return Expanded(child: ErrorDisplay(errorMessage: AppLocalizations.of(context)!.errorMessageFetchData));
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildLeaderboardHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(width: Spacing.xxxl.spacing, child: Text(AppLocalizations.of(context)!.leaderboardLabelRank, style: Theme.of(context).textTheme.bodyText1)),
        SizedBox(width: Spacing.xxl.spacing, child: Text(AppLocalizations.of(context)!.leaderboardLabelMmr, style: Theme.of(context).textTheme.bodyText1)),
        Expanded(child: Text(AppLocalizations.of(context)!.leaderboardLabelName, style: Theme.of(context).textTheme.bodyText1)),
        Text(AppLocalizations.of(context)!.leaderboardLabelWinRate, textAlign: TextAlign.end, style: Theme.of(context).textTheme.bodyText1),
      ],
    );
  }

  Widget _buildLeaderboardDataLoaded(List leaderboardData) {
    return Expanded(
      child: ShaderMask(
        shaderCallback: (Rect rect) {
          return const LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [Colors.transparent, kcColorWhite],
            stops: [0.0, 0.04],
          ).createShader(rect);
        },
        child: ListView.separated(
          padding: EdgeInsets.symmetric(vertical: Spacing.m.spacing),
          separatorBuilder: (context, index) => SizedBox(height: Spacing.xl.spacing),
          itemCount: leaderboardData.length,
          itemBuilder: (context, index) {
            final Player player = leaderboardData[index];
            return BlocBuilder<GameModeSelectorCubit, GameModeSelectorState>(
              builder: (context, state) {
                return InkWell(
                  onTap: () => Navigator.of(context).pushNamed(
                    '/player',
                    arguments: RatingHistoryScreenArgs(leaderboardId: mapIndexToLeaderboardId(state.leaderboardGameModeIndex), player: player),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(constraints: BoxConstraints(minWidth: Spacing.xxxl.spacing), child: Text("${player.rank}")),
                      Container(constraints: BoxConstraints(minWidth: Spacing.xxl.spacing), child: Text("${player.mmr}")),
                      Expanded(child: Text(player.name)),
                      Container(
                        constraints: BoxConstraints(minWidth: Spacing.xl.spacing),
                        margin: EdgeInsets.only(left: Spacing.m.spacing),
                        child: Text("${player.winRate} %", textAlign: TextAlign.end),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        BlocBuilder<GameModeSelectorCubit, GameModeSelectorState>(
          builder: (context, state) {
            final String gameMode = mapIndexToGameMode(context, state.leaderboardGameModeIndex);

            return Text(
              AppLocalizations.of(context)!.appTitle(gameMode),
              style: Theme.of(context).textTheme.headline1,
            );
          },
        ),
        InkWell(
          onTap: () => Navigator.of(context).pushNamed('/disclaimer'),
          child: const Icon(Icons.info_outline_rounded),
        ),
      ],
    );
  }

  Widget _buildSearchbar() {
    return Container(
      decoration: const BoxDecoration(
        color: kcSearchbarColor,
        borderRadius: BorderRadius.all(
          Radius.circular(kbBorderRadius),
        ),
      ),
      child: BlocBuilder<GameModeSelectorCubit, GameModeSelectorState>(
        builder: (context, state) {
          final int leaderboardId = mapIndexToLeaderboardId(state.leaderboardGameModeIndex);

          return TextField(
            controller: _searchFieldController,
            textAlignVertical: TextAlignVertical.center,
            decoration: InputDecoration(
              hintText: AppLocalizations.of(context)!.searchbarHintText,
              suffixIcon: IconButton(
                icon: const Icon(Icons.clear),
                color: kcTertiaryColor,
                onPressed: () {
                  if (_searchFieldController.text.isNotEmpty) {
                    _searchFieldController.clear();
                    BlocProvider.of<LeaderboardDataCubit>(context).searchPlayer(leaderboardId, _searchFieldController.text);
                  }
                },
              ),
            ),
            onChanged: (playerName) {
              _debouncer.run(() {
                BlocProvider.of<LeaderboardDataCubit>(context).searchPlayer(leaderboardId, playerName.toLowerCase());
              });
            },
          );
        },
      ),
    );
  }
}
