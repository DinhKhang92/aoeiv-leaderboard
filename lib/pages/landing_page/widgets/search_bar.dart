import 'package:aoeiv_leaderboard/config/styles/colors.dart';
import 'package:aoeiv_leaderboard/config/styles/theme.dart';
import 'package:aoeiv_leaderboard/cubit/game_mode_selector_cubit.dart';
import 'package:aoeiv_leaderboard/cubit/leaderboard_data_cubit.dart';
import 'package:aoeiv_leaderboard/utils/debouncer.dart';
import 'package:aoeiv_leaderboard/utils/map_index_to_leaderboard_id.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchBar extends StatelessWidget {
  final TextEditingController searchFieldController;
  final String? hintText;
  final Debouncer _debouncer = Debouncer(milliseconds: 700);

  SearchBar({required this.searchFieldController, this.hintText, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            controller: searchFieldController,
            textAlignVertical: TextAlignVertical.center,
            decoration: InputDecoration(
              hintText: hintText,
              suffixIcon: IconButton(
                icon: const Icon(Icons.clear),
                color: kcTertiaryColor,
                onPressed: () {
                  if (searchFieldController.text.isNotEmpty) {
                    searchFieldController.clear();
                    BlocProvider.of<LeaderboardDataCubit>(context).searchPlayer(leaderboardId, searchFieldController.text);
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
