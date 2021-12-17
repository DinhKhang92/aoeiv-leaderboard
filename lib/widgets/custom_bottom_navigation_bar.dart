import 'package:aoeiv_leaderboard/config/styles/colors.dart';
import 'package:aoeiv_leaderboard/cubit/game_mode_selector_cubit.dart';
import 'package:aoeiv_leaderboard/cubit/leaderboard_data_cubit.dart';
import 'package:aoeiv_leaderboard/utils/map_index_to_leaderboard_id.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final TextEditingController searchFieldController;

  const CustomBottomNavigationBar({required this.searchFieldController, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GameModeSelectorCubit, GameModeSelectorState>(
      builder: (context, state) {
        return BottomNavigationBar(
          backgroundColor: kcSecondaryColor,
          onTap: (index) => index != state.leaderboardGameModeIndex ? _handleBottomNavbarOnTap(context, index) : null,
          currentIndex: state.leaderboardGameModeIndex,
          items: [
            BottomNavigationBarItem(icon: const Icon(Icons.person_outline), label: AppLocalizations.of(context)!.bottomNavigationBarLabel1v1),
            BottomNavigationBarItem(icon: const Icon(Icons.group_outlined), label: AppLocalizations.of(context)!.bottomNavigationBarLabel2v2),
            BottomNavigationBarItem(icon: const Icon(Icons.groups_outlined), label: AppLocalizations.of(context)!.bottomNavigationBarLabel3v3),
            BottomNavigationBarItem(icon: const Icon(Icons.groups_outlined), label: AppLocalizations.of(context)!.bottomNavigationBarLabel4v4),
          ],
        );
      },
    );
  }

  void _handleBottomNavbarOnTap(BuildContext context, int index) {
    searchFieldController.clear();
    final int leaderboardId = mapIndexToLeaderboardId(index);

    BlocProvider.of<GameModeSelectorCubit>(context).setLeaderboardGameMode(index);
    BlocProvider.of<LeaderboardDataCubit>(context).fetchLeaderboardData(leaderboardId);
  }
}
