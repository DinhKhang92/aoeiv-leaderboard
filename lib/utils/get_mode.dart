import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

String getMode(BuildContext context, int index) {
  switch (index) {
    case 0:
      return AppLocalizations.of(context)!.bottomNavigationBarLabel1v1;
    case 1:
      return AppLocalizations.of(context)!.bottomNavigationBarLabel2v2;
    case 2:
      return AppLocalizations.of(context)!.bottomNavigationBarLabel3v3;
    case 3:
      return AppLocalizations.of(context)!.bottomNavigationBarLabel4v4;
    default:
      return AppLocalizations.of(context)!.bottomNavigationBarLabel1v1;
  }
}
