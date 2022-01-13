import 'dart:math';

import 'package:aoeiv_leaderboard/config/styles/colors.dart';
import 'package:aoeiv_leaderboard/config/styles/spacing.dart';
import 'package:aoeiv_leaderboard/cubit/favorites_cubit.dart';
import 'package:aoeiv_leaderboard/cubit/game_mode_selector_cubit.dart';
import 'package:aoeiv_leaderboard/cubit/match_history_data_cubit.dart';
import 'package:aoeiv_leaderboard/cubit/rating_history_data_cubit.dart';
import 'package:aoeiv_leaderboard/exceptions/no_data_exception.dart';
import 'package:aoeiv_leaderboard/models/match.dart';
import 'package:aoeiv_leaderboard/models/match_player.dart';
import 'package:aoeiv_leaderboard/models/player.dart';
import 'package:aoeiv_leaderboard/models/rating.dart';
import 'package:aoeiv_leaderboard/models/rating_history_screen_args.dart';
import 'package:aoeiv_leaderboard/routes/route_generator.dart';
import 'package:aoeiv_leaderboard/utils/map_id_to_civ_asset_name.dart';
import 'package:aoeiv_leaderboard/utils/map_index_to_leaderboard_id.dart';
import 'package:aoeiv_leaderboard/utils/map_map_type_to_map_name.dart';
import 'package:aoeiv_leaderboard/utils/map_timestamp_to_match_date_label.dart';
import 'package:aoeiv_leaderboard/widgets/bottom_shader.dart';
import 'package:aoeiv_leaderboard/widgets/centered_circular_progress_indicator.dart';
import 'package:aoeiv_leaderboard/widgets/error_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MatchHistorySection extends StatefulWidget {
  final Player player;
  const MatchHistorySection({required this.player, Key? key}) : super(key: key);

  @override
  _MatchHistorySectionState createState() => _MatchHistorySectionState();
}

class _MatchHistorySectionState extends State<MatchHistorySection> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocConsumer<FavoritesCubit, FavoritesState>(
        listener: (context, state) {
          if (state is FavoritesNavigation) {
            Navigator.of(context).popAndPushNamed(
              Routes.playerDetailsPage,
              arguments: RatingHistoryScreenArgs(leaderboardId: state.leaderboardId!, player: state.favorite!),
            );
          }
        },
        builder: (context, state) {
          if (state is FavoritesLoading) {
            return const CenteredCircularProgressIndicator();
          }

          if (state is FavoritesError) {
            final String errorMessage =
                state.error is NoDataException ? AppLocalizations.of(context)!.errorMessageNoDataFound : AppLocalizations.of(context)!.errorMessageFetchData;

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                duration: const Duration(milliseconds: 2500),
                backgroundColor: kcTertiaryColor,
                content: Wrap(
                  spacing: Spacing.s.value,
                  children: [const Icon(Icons.warning), Text(errorMessage)],
                ),
              ),
            );
          }

          return BlocBuilder<RatingHistoryDataCubit, RatingHistoryDataState>(
            builder: (context, state) {
              final List<Rating> ratinghistoryData = state.ratingHistoryData;

              if (state is RatingHistoryDataLoading) {
                return const CenteredCircularProgressIndicator();
              }

              if (state is RatingHistoryDataLoaded) {
                return _buildRatingHistoryDataLoaded(ratinghistoryData);
              }

              if (state is RatingHistoryDataError) {
                final String errorMessage =
                    state.error is NoDataException ? AppLocalizations.of(context)!.errorMessageNoDataFound : AppLocalizations.of(context)!.errorMessageFetchData;
                return ErrorDisplay(errorMessage: errorMessage);
              }

              return const SizedBox.shrink();
            },
          );
        },
      ),
    );
  }

  Widget _buildRatingHistoryDataLoaded(List<Rating> ratinghistoryData) {
    return BlocBuilder<MatchHistoryDataCubit, MatchHistoryDataState>(
      builder: (context, state) {
        if (state is MatchHistoryDataLoading) {
          return const CenteredCircularProgressIndicator();
        }

        if (state is MatchHistoryDataLoaded && ratinghistoryData.isNotEmpty) {
          return _buildMatchHistoryLoaded(state.filteredMatches, ratinghistoryData);
        }

        if (state is MatchHistoryDataError) {
          final String errorMessage = state.error is NoDataException ? AppLocalizations.of(context)!.errorMessageNoDataFound : AppLocalizations.of(context)!.errorMessageFetchData;
          return ErrorDisplay(errorMessage: errorMessage);
        }

        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildMatchHistoryLoaded(List<Match> matches, List<Rating> ratinghistoryData) {
    return BottomShader(
      child: ListView.builder(
        physics: const ClampingScrollPhysics(),
        padding: EdgeInsets.only(bottom: Spacing.m.value),
        itemCount: min(matches.length, ratinghistoryData.length) - 1,
        itemBuilder: (context, index) {
          final bool wonGame = ratinghistoryData[index].rating > ratinghistoryData[index + 1].rating;
          final int rating = ratinghistoryData[index].rating - ratinghistoryData[index + 1].rating;
          final Match match = matches[index];
          final String map = mapMapTypeToMapName(context, match.mapType);
          final String mapAssetName = map.toLowerCase().replaceAll(' ', '_');
          final List<MatchPlayer> players = match.matchPlayers;
          final List<MatchPlayer> myself = players.where((MatchPlayer player) => player.profileId == widget.player.profileId).toList();
          final int myTeamId = myself.first.team ?? -1;
          final List<MatchPlayer> mates = players.where((MatchPlayer player) => player.team == myTeamId).toList();
          final List<MatchPlayer> opponents = players.where((MatchPlayer player) => player.team != myTeamId).toList();

          return ExpansionTile(
            tilePadding: const EdgeInsets.symmetric(horizontal: 0),
            iconColor: kcPrimaryColor,
            collapsedIconColor: kcPrimaryColor,
            title: Text(
              map,
              style: Theme.of(context).textTheme.bodyText1,
            ),
            subtitle: Wrap(
              spacing: 2,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Text(
                  mapTimestampToMatchDateLabel(context, match.timestamp),
                  style: Theme.of(context).textTheme.headline6,
                ),
                wonGame
                    ? const Icon(Icons.arrow_upward, size: 13, color: Colors.green)
                    : const Icon(
                        Icons.arrow_downward,
                        size: 13,
                        color: Colors.red,
                      ),
                Text(
                  "${rating.abs()}",
                  style: TextStyle(
                    color: wonGame ? Colors.green : Colors.red,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
            childrenPadding: EdgeInsets.symmetric(vertical: Spacing.xxs.value),
            children: _buildMatchDetails(mates, opponents),
            leading: Container(
              decoration: BoxDecoration(border: Border.all(color: kcHintColor)),
              child: Image.asset("assets/maps/$mapAssetName.png"),
            ),
          );
        },
      ),
    );
  }

  List<Widget> _buildMatchDetails(List<MatchPlayer> mates, List<MatchPlayer> opponents) {
    final int gameModeIndex = BlocProvider.of<GameModeSelectorCubit>(context).state.ratingHistoryGameModeIndex;

    return List.generate(
      mates.length,
      (int index) {
        final MatchPlayer mate = mates[index];
        final MatchPlayer opponent = opponents[index];

        return Padding(
          padding: EdgeInsets.symmetric(horizontal: Spacing.xs.value, vertical: Spacing.xxs.value),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildMateSection(mate, gameModeIndex),
              SizedBox(width: Spacing.s.value),
              _buildOpponentSection(opponent, gameModeIndex),
            ],
          ),
        );
      },
    );
  }

  Widget _buildMateSection(MatchPlayer mate, int gameModeIndex) {
    return Expanded(
      child: InkWell(
        onTap: () => BlocProvider.of<FavoritesCubit>(context).fetchFavorite(mapIndexToLeaderboardId(gameModeIndex), mate.profileId),
        child: Wrap(
          spacing: Spacing.s.value,
          children: [
            Container(
              constraints: const BoxConstraints(maxWidth: 30),
              child: Image.asset("assets/civs/${mapIdToCivAssetName(mate.civilizationId)}"),
            ),
            Text(
              mate.name,
              style: mate.profileId == widget.player.profileId ? Theme.of(context).textTheme.bodyText2?.copyWith(color: kcPrimaryColor) : Theme.of(context).textTheme.bodyText2,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOpponentSection(MatchPlayer opponent, int gameModeIndex) {
    return Expanded(
      child: InkWell(
        onTap: () => BlocProvider.of<FavoritesCubit>(context).fetchFavorite(mapIndexToLeaderboardId(gameModeIndex), opponent.profileId),
        child: Wrap(
          spacing: Spacing.s.value,
          alignment: WrapAlignment.end,
          children: [
            Text(opponent.name),
            Container(
              constraints: const BoxConstraints(maxWidth: 30),
              child: Image.asset("assets/civs/${mapIdToCivAssetName(opponent.civilizationId)}"),
            ),
          ],
        ),
      ),
    );
  }
}
