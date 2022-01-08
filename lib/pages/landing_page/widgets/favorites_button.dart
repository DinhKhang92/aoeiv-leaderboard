import 'package:aoeiv_leaderboard/config/styles/colors.dart';
import 'package:aoeiv_leaderboard/config/styles/spacing.dart';
import 'package:aoeiv_leaderboard/config/styles/theme.dart';
import 'package:aoeiv_leaderboard/cubit/favorites_cubit.dart';
import 'package:aoeiv_leaderboard/exceptions/no_data_exception.dart';
import 'package:aoeiv_leaderboard/models/favorite.dart';
import 'package:aoeiv_leaderboard/models/rating_history_screen_args.dart';
import 'package:aoeiv_leaderboard/pages/landing_page/widgets/favorites_modal_bottom_sheet.dart';
import 'package:aoeiv_leaderboard/widgets/centered_circular_progress_indicator.dart';
import 'package:aoeiv_leaderboard/widgets/custom_box_shadow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FavoritesButton extends StatefulWidget {
  const FavoritesButton({Key? key}) : super(key: key);

  @override
  _FavoritesButtonState createState() => _FavoritesButtonState();
}

class _FavoritesButtonState extends State<FavoritesButton> {
  @override
  Widget build(BuildContext context) {
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
        boxShadow: customBoxShadow,
      ),
      child: IconButton(
        icon: const Icon(Icons.star),
        onPressed: () => _showModalBottomSheet(),
      ),
    );
  }

  Future<dynamic> _showModalBottomSheet() {
    return showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return const FavoritesModalBottomSheet();
      },
    );
  }
}
