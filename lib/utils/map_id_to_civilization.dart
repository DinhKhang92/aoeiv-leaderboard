import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

String mapIdToCivilization(BuildContext context, int id) {
  switch (id) {
    case 0:
      return AppLocalizations.of(context)!.pieChardLabelAbbasidDynasty;
    case 1:
      return AppLocalizations.of(context)!.pieChardLabelChinese;
    case 2:
      return AppLocalizations.of(context)!.pieChardLabelDelhiSultanate;
    case 3:
      return AppLocalizations.of(context)!.pieChardLabelEnglish;
    case 4:
      return AppLocalizations.of(context)!.pieChardLabelFrench;
    case 5:
      return AppLocalizations.of(context)!.pieChardLabelHolyRomanEmpire;
    case 6:
      return AppLocalizations.of(context)!.pieChardLabelMongols;
    case 7:
      return AppLocalizations.of(context)!.pieChardLabelRus;
    default:
      return "Unknown";
  }
}
