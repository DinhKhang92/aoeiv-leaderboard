import 'package:aoeiv_leaderboard/config/styles/colors.dart';
import 'package:aoeiv_leaderboard/config/styles/theme.dart';
import 'package:aoeiv_leaderboard/pages/landing_page/widgets/favorites_modal_bottom_sheet.dart';
import 'package:aoeiv_leaderboard/widgets/custom_box_shadow.dart';
import 'package:flutter/material.dart';

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
