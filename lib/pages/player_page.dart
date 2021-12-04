import 'package:aoeiv_leaderboard/config/config.dart';
import 'package:aoeiv_leaderboard/cubit/rating_history_data_cubit.dart';
import 'package:aoeiv_leaderboard/models/player.dart';
import 'package:aoeiv_leaderboard/widgets/background.dart';
import 'package:aoeiv_leaderboard/widgets/header.dart';
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
            bottom: false,
            child: Container(
              padding: const EdgeInsets.all(15),
              child: Column(
                children: [
                  Header(headerTitle: AppLocalizations.of(context)!.pageTitlePlayerDetails),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
