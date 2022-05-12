import 'package:aoeiv_leaderboard/cubit/rating_history_data_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PlayerStats extends StatelessWidget {
  const PlayerStats({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RatingHistoryDataCubit, RatingHistoryDataState>(
      builder: (context, state) {
        if (state is RatingHistoryDataLoaded) {
          final int mmr = state.ratingHistoryData.first.rating;
          final int wins = state.ratingHistoryData.first.totalWins;
          final int losses = state.ratingHistoryData.first.totalLosses;
          final int winRate = state.ratingHistoryData.first.winRate;
          final int previousRating = 0;
          final int mmrDifference = mmr - previousRating;

          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("#${1} | $mmr "),
              Icon(
                mmrDifference < 0 ? Icons.arrow_downward : Icons.arrow_upward,
                size: 14,
                color: mmrDifference < 0 ? Colors.red : Colors.green,
              ),
              Text(
                "${mmrDifference.abs()}",
                style: TextStyle(color: mmrDifference < 0 ? Colors.red : Colors.green),
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
        }
        return const SizedBox.shrink();
      },
    );
  }
}
