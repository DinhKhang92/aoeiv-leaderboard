import 'dart:async';

import 'package:aoeiv_leaderboard/config/config.dart';
import 'package:aoeiv_leaderboard/config/styles/colors.dart';
import 'package:aoeiv_leaderboard/config/styles/spacing.dart';
import 'package:aoeiv_leaderboard/config/styles/theme.dart';
import 'package:aoeiv_leaderboard/cubit/favorites_cubit.dart';
import 'package:aoeiv_leaderboard/cubit/game_mode_selector_cubit.dart';
import 'package:aoeiv_leaderboard/cubit/leaderboard_data_cubit.dart';
import 'package:aoeiv_leaderboard/exceptions/no_data_exception.dart';
import 'package:aoeiv_leaderboard/models/favorite.dart';
import 'package:aoeiv_leaderboard/models/player.dart';
import 'package:aoeiv_leaderboard/models/rating_history_screen_args.dart';
import 'package:aoeiv_leaderboard/utils/debouncer.dart';
import 'package:aoeiv_leaderboard/utils/map_index_to_leaderboard_id.dart';
import 'package:aoeiv_leaderboard/utils/map_index_to_game_mode.dart';
import 'package:aoeiv_leaderboard/widgets/background.dart';
import 'package:aoeiv_leaderboard/widgets/bottom_shader.dart';
import 'package:aoeiv_leaderboard/widgets/centered_circular_progress_indicator.dart';
import 'package:aoeiv_leaderboard/pages/landing_page/widgets/custom_bottom_navigation_bar.dart';
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
                _buildSearchbarSection(),
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
      child: BottomShader(
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

  Widget _buildSearchbarSection() {
    return IntrinsicHeight(
      child: Row(
        children: [
          _buildSearchBar(),
          SizedBox(width: Spacing.s.spacing),
          _buildFavoritesButton(),
        ],
      ),
    );
  }

  Widget _buildFavoritesButton() {
    return Container(
      width: 50,
      height: double.infinity,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            kcTertiaryColor,
            kcFavoritesButtonColor,
          ],
        ),
        borderRadius: BorderRadius.circular(kbBorderRadius),
        boxShadow: const [
          BoxShadow(
            color: kcSecondaryColor,
            offset: Offset(3.0, 3.0),
            blurRadius: 6.0,
          ),
        ],
      ),
      child: IconButton(
        icon: const Icon(Icons.star),
        onPressed: () => _showModalBottomSheet(),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Expanded(
      child: Container(
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
      ),
    );
  }

  Future<dynamic> _showModalBottomSheet() {
    return showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Scaffold(
          body: Container(
            padding: EdgeInsets.only(
              top: Spacing.m.spacing,
              bottom: MediaQuery.of(context).padding.bottom,
              left: Spacing.m.spacing,
              right: Spacing.m.spacing,
            ),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  kcFavoritesButtonColor,
                  kcSecondaryColor,
                ],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(alignment: Alignment.center, child: Text("Favorites", style: Theme.of(context).textTheme.headline2?.copyWith(color: kcPrimaryColor))),
                SizedBox(height: Spacing.l.spacing),
                Expanded(
                  child: BlocConsumer<FavoritesCubit, FavoritesState>(
                    listener: (context, state) {
                      if (state is FavoritesNavigation) {
                        Navigator.of(context).pushNamed(
                          '/player',
                          arguments: RatingHistoryScreenArgs(leaderboardId: state.leaderboardId!, player: state.favorite!),
                        );
                      }
                      if (state is FavoritesError) {
                        final String errorMessage =
                            state.error is NoDataException ? AppLocalizations.of(context)!.errorMessageNoDataFound : AppLocalizations.of(context)!.errorMessageFetchData;
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            duration: const Duration(milliseconds: 2500),
                            backgroundColor: kcTertiaryColor,
                            content: Wrap(
                              spacing: Spacing.s.spacing,
                              children: [
                                const Icon(Icons.warning),
                                Text(errorMessage),
                              ],
                            ),
                          ),
                        );
                      }
                    },
                    builder: (context, state) {
                      if (state is FavoritesLoading) {
                        return const CenteredCircularProgressIndicator();
                      }

                      return ListView.separated(
                        separatorBuilder: (context, index) => SizedBox(height: Spacing.xs.spacing),
                        physics: const ClampingScrollPhysics(),
                        itemCount: state.favorites.length,
                        itemBuilder: (context, index) {
                          final Favorite favorite = state.favorites[index];

                          return Container(
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  kcTertiaryColor,
                                  kcFavoritesButtonColor,
                                ],
                              ),
                              boxShadow: const [
                                BoxShadow(
                                  color: kcSecondaryColor,
                                  offset: Offset(3.0, 3.0),
                                  blurRadius: 6.0,
                                ),
                              ],
                              borderRadius: BorderRadius.circular(kbBorderRadius),
                            ),
                            child: ListTile(
                              onTap: () => BlocProvider.of<FavoritesCubit>(context).fetchFavorite(favorite.leaderboardId, favorite.profileId),
                              dense: true,
                              title: Text(
                                favorite.name,
                                style: Theme.of(context).textTheme.bodyText2,
                              ),
                              trailing: const Icon(
                                Icons.arrow_forward_ios,
                                color: kcPrimaryColor,
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
