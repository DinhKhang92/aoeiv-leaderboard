import 'package:aoeiv_leaderboard/config/styles/colors.dart';
import 'package:aoeiv_leaderboard/config/styles/spacing.dart';
import 'package:aoeiv_leaderboard/cubit/match_history_data_cubit.dart';
import 'package:aoeiv_leaderboard/exceptions/no_data_exception.dart';
import 'package:aoeiv_leaderboard/models/match.dart';
import 'package:aoeiv_leaderboard/models/match_player.dart';
import 'package:aoeiv_leaderboard/models/player.dart';
import 'package:aoeiv_leaderboard/utils/map_id_to_civ_asset_name.dart';
import 'package:aoeiv_leaderboard/utils/map_map_type_to_map_name.dart';
import 'package:aoeiv_leaderboard/utils/map_timestamp_to_match_date_label.dart';
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
      child: BlocBuilder<MatchHistoryDataCubit, MatchHistoryDataState>(
        builder: (context, state) {
          if (state is MatchHistoryDataLoaded) {
            return _buildMatchHistoryLoaded(state.filteredMatches);
          }

          if (state is MatchHistoryDataError) {
            final String errorMessage =
                state.error is NoDataException ? AppLocalizations.of(context)!.errorMessageNoDataFound : AppLocalizations.of(context)!.errorMessageFetchData;
            return ErrorDisplay(errorMessage: errorMessage);
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildMatchHistoryLoaded(List<Match> matches) {
    return ListView.builder(
      physics: const ClampingScrollPhysics(),
      itemCount: matches.length,
      itemBuilder: (context, index) {
        final Match match = matches[index];
        final String map = mapMapTypeToMapName(context, match.mapType);
        final String mapAssetName = map.toLowerCase().replaceAll(' ', '_');
        final List<MatchPlayer> players = match.matchPlayers;
        final List<MatchPlayer> myself = players.where((MatchPlayer player) => player.profileId == widget.player.profileId).toList();
        final int myTeamId = myself.first.team ?? -1;
        final List<MatchPlayer> mates = players.where((MatchPlayer player) => player.team == myTeamId).toList();
        final List<MatchPlayer> opponents = players.where((MatchPlayer player) => player.team != myTeamId).toList();
        final DateTime now = DateTime.now();
        final DateTime timestamp = DateTime.fromMillisecondsSinceEpoch(match.timestamp);
        int hours = (now.difference(timestamp).inHours);

        return ExpansionTile(
          tilePadding: const EdgeInsets.symmetric(horizontal: 0),
          iconColor: kcPrimaryColor,
          collapsedIconColor: kcPrimaryColor,
          title: Text(
            map,
            style: Theme.of(context).textTheme.bodyText1,
          ),
          subtitle: Text(
            mapTimestampToMatchDateLabel(context, match.timestamp),
            style: Theme.of(context).textTheme.headline6,
          ),
          childrenPadding: EdgeInsets.symmetric(vertical: Spacing.xxs.spacing),
          children: _buildMatchDetails(mates, opponents, index),
          leading: Container(
            decoration: BoxDecoration(border: Border.all(color: kcHintColor)),
            child: Image.asset("assets/maps/$mapAssetName.png"),
          ),
        );
      },
    );
  }

  List<Widget> _buildMatchDetails(List<MatchPlayer> mates, List<MatchPlayer> opponents, int i) {
    return List.generate(
      mates.length,
      (int index) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: Spacing.xs.spacing, vertical: Spacing.xxs.spacing),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                constraints: const BoxConstraints(maxWidth: 28),
                child: Image.asset("assets/civs/${mapIdToCivAssetName(mates[index].civilizationId)}.png"),
              ),
              SizedBox(width: Spacing.s.spacing),
              Expanded(child: Text(mates[index].name)),
              SizedBox(width: Spacing.m.spacing),
              Expanded(child: Text(opponents[index].name, textAlign: TextAlign.end)),
              SizedBox(width: Spacing.s.spacing),
              Container(
                constraints: const BoxConstraints(maxWidth: 28),
                child: Image.asset("assets/civs/${mapIdToCivAssetName(opponents[index].civilizationId)}.png"),
              ),
            ],
          ),
        );
      },
    );
  }
}
