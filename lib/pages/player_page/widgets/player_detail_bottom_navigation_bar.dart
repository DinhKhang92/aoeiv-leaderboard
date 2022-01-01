import 'package:aoeiv_leaderboard/config/styles/colors.dart';
import 'package:aoeiv_leaderboard/cubit/game_mode_selector_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PlayerDetailBottomNavigationBar extends StatelessWidget {
  const PlayerDetailBottomNavigationBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GameModeSelectorCubit, GameModeSelectorState>(
      builder: (context, state) {
        return BottomNavigationBar(
          backgroundColor: kcSecondaryColor,
          currentIndex: state.playerDetailModeIndex,
          onTap: (int index) => BlocProvider.of<GameModeSelectorCubit>(context).setPlayerDetailGameMode(index),
          items: [
            BottomNavigationBarItem(
              icon: const Icon(MdiIcons.chartLine),
              label: AppLocalizations.of(context)!.playerDetailBottomNavigationBarLabelMmr,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.pie_chart_outline),
              label: AppLocalizations.of(context)!.playerDetailBottomNavigationBarLabelCivs,
            ),
            BottomNavigationBarItem(
              icon: const Icon(MdiIcons.history),
              label: AppLocalizations.of(context)!.playerDetailBottomNavigationBarLabelMatches,
            )
          ],
        );
      },
    );
  }
}
