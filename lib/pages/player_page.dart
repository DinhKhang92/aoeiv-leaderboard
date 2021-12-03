import 'package:aoeiv_leaderboard/config/config.dart';
import 'package:aoeiv_leaderboard/cubit/rating_history_data_cubit.dart';
import 'package:aoeiv_leaderboard/models/player.dart';
import 'package:aoeiv_leaderboard/widgets/background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
                  _buildHeader(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: () => Navigator.of(context).pop(),
          child: Icon(Theme.of(context).platform == TargetPlatform.iOS ? Icons.arrow_back_ios : Icons.arrow_back_ios),
        ),
        Text(
          widget.player.name,
          style: Theme.of(context).textTheme.headline1,
        ),
        const SizedBox(width: 24),
      ],
    );
  }
}
