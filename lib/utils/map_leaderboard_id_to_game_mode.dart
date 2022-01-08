import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

String mapLeaderboardIdToGameMode(BuildContext context, int leaderboardId) {
  switch (leaderboardId) {
    case 17:
      return AppLocalizations.of(context)!.bottomNavigationBarLabel1v1;
    case 18:
      return AppLocalizations.of(context)!.bottomNavigationBarLabel2v2;
    case 19:
      return AppLocalizations.of(context)!.bottomNavigationBarLabel3v3;
    case 20:
      return AppLocalizations.of(context)!.bottomNavigationBarLabel4v4;
    default:
      return AppLocalizations.of(context)!.bottomNavigationBarLabel1v1;
  }
}
