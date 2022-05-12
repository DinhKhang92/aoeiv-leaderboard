import 'dart:async';

import 'package:aoeiv_leaderboard/config/config.dart';
import 'package:aoeiv_leaderboard/config/styles/spacing.dart';
import 'package:aoeiv_leaderboard/config/tutorial.dart';
import 'package:aoeiv_leaderboard/cubit/favorites_cubit.dart';
import 'package:aoeiv_leaderboard/cubit/game_mode_selector_cubit.dart';
import 'package:aoeiv_leaderboard/cubit/leaderboard_data_cubit.dart';
import 'package:aoeiv_leaderboard/models/player.dart';
import 'package:aoeiv_leaderboard/models/rating_history_screen_args.dart';
import 'package:aoeiv_leaderboard/pages/landing_page/widgets/favorites_button.dart';
import 'package:aoeiv_leaderboard/pages/landing_page/widgets/search_bar.dart';
import 'package:aoeiv_leaderboard/routes/route_generator.dart';
import 'package:aoeiv_leaderboard/utils/map_index_to_game_mode.dart';
import 'package:aoeiv_leaderboard/utils/map_index_to_leaderboard_id.dart';
import 'package:aoeiv_leaderboard/utils/show_tutorials.dart';
import 'package:aoeiv_leaderboard/widgets/background.dart';
import 'package:aoeiv_leaderboard/widgets/bottom_shader.dart';
import 'package:aoeiv_leaderboard/widgets/centered_circular_progress_indicator.dart';
import 'package:aoeiv_leaderboard/pages/landing_page/widgets/custom_bottom_navigation_bar.dart';
import 'package:aoeiv_leaderboard/widgets/error_display.dart';
import 'package:aoeiv_leaderboard/widgets/tutorial_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  final GlobalKey _favoritesButtonKey = GlobalKey();
  final TextEditingController _searchFieldController = TextEditingController();

  @override
  void initState() {
    _initFavorites();
    _fetchLeaderboardData();
    super.initState();
  }

  @override
  void dispose() {
    _searchFieldController.dispose();
    super.dispose();
  }

  Future<void> _initFavorites() async {
    await BlocProvider.of<FavoritesCubit>(context).init();
  }

  Future<void> _fetchLeaderboardData() async {
    await BlocProvider.of<LeaderboardDataCubit>(context).fetchLeaderboardData(LeaderboardId.qmOneVOne.leaderboard);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getShowTutorial(Tutorial.favoritesLanding),
      builder: (context, snapshot) {
        if (snapshot.data == true) {
          _showTutorial();
        }

        return Scaffold(
          bottomNavigationBar: CustomBottomNavigationBar(searchFieldController: _searchFieldController),
          body: _buildBody(),
        );
      },
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
                SizedBox(height: Spacing.l.value),
                _buildSearchbarSection(),
                SizedBox(height: Spacing.l.value),
                _buildLeaderboardHeader(),
                SizedBox(height: Spacing.m.value),
                _buildLeaderboard(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSearchbarSection() {
    return IntrinsicHeight(
      child: Row(
        children: [
          _buildSearchBar(),
          SizedBox(width: Spacing.s.value),
          FavoritesButton(key: _favoritesButtonKey),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Expanded(
      child: SearchBar(
        searchFieldController: _searchFieldController,
        hintText: AppLocalizations.of(context)!.searchbarHintText,
      ),
    );
  }

  Widget _buildLeaderboardHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(width: Spacing.xxxl.value, child: Text(AppLocalizations.of(context)!.leaderboardLabelRank, style: Theme.of(context).textTheme.bodyText1)),
        SizedBox(width: Spacing.xxl.value, child: Text(AppLocalizations.of(context)!.leaderboardLabelMmr, style: Theme.of(context).textTheme.bodyText1)),
        Expanded(child: Text(AppLocalizations.of(context)!.leaderboardLabelName, style: Theme.of(context).textTheme.bodyText1)),
        Text(AppLocalizations.of(context)!.leaderboardLabelWinRate, textAlign: TextAlign.end, style: Theme.of(context).textTheme.bodyText1),
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

  Widget _buildLeaderboardDataLoaded(List leaderboardData) {
    return Expanded(
      child: BottomShader(
        child: ListView.separated(
          physics: const ClampingScrollPhysics(),
          padding: EdgeInsets.symmetric(vertical: Spacing.m.value),
          separatorBuilder: (context, index) => SizedBox(height: Spacing.xl.value),
          itemCount: leaderboardData.length,
          itemBuilder: (context, index) {
            final PlayerPreview player = leaderboardData[index];
            return BlocBuilder<GameModeSelectorCubit, GameModeSelectorState>(
              builder: (context, state) {
                return InkWell(
                  onTap: () => Navigator.of(context).pushNamed(
                    Routes.playerDetailsPage,
                    arguments: RatingHistoryScreenArgs(leaderboard: mapIndexToLeaderboard(state.leaderboardGameModeIndex), player: player),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(constraints: BoxConstraints(minWidth: Spacing.xxxl.value), child: Text("${player.rank}")),
                      Container(constraints: BoxConstraints(minWidth: Spacing.xxl.value), child: Text("${player.mmr}")),
                      Expanded(child: Text(player.name)),
                      Container(
                        constraints: BoxConstraints(minWidth: Spacing.xl.value),
                        margin: EdgeInsets.only(left: Spacing.m.value),
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
          onTap: () => Navigator.of(context).pushNamed(Routes.disclaimerPage),
          child: const Icon(Icons.info_outline_rounded),
        ),
      ],
    );
  }

  void _showTutorial() {
    final TutorialCoachMark tutorial = TutorialCoachMark(
      context,
      hideSkip: true,
      focusAnimationDuration: const Duration(milliseconds: 700),
      onFinish: () => setShowTutorial(Tutorial.favoritesLanding),
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
                  description: AppLocalizations.of(context)!.tutorialFavoritesListDescription,
                );
              }),
            )
          ],
        ),
      ],
    );

    tutorial.show();
  }
}
