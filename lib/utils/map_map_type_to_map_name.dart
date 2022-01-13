import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

String mapMapTypeToMapName(BuildContext context, int mapType) {
  switch (mapType) {
    case 0:
      return AppLocalizations.of(context)!.mapNameDryArabia;
    case 1:
      return AppLocalizations.of(context)!.mapNameLipany;
    case 2:
      return AppLocalizations.of(context)!.mapNameHighView;
    case 3:
      return AppLocalizations.of(context)!.mapNameMountainPass;
    case 4:
      return AppLocalizations.of(context)!.mapNameAncientSpires;
    case 5:
      return AppLocalizations.of(context)!.mapNameDanubeRiver;
    case 6:
      return AppLocalizations.of(context)!.mapNameBlackForest;
    case 7:
      return AppLocalizations.of(context)!.mapNameMongolianHeights;
    case 8:
      return AppLocalizations.of(context)!.mapNameAltai;
    case 9:
      return AppLocalizations.of(context)!.mapNameConfluence;
    case 10:
      return AppLocalizations.of(context)!.mapNameFrenchPass;
    case 11:
      return AppLocalizations.of(context)!.mapNameHillAndDale;
    case 12:
      return AppLocalizations.of(context)!.mapNameKingOfTheHill;
    case 13:
      return AppLocalizations.of(context)!.mapNameWarringIslands;
    case 14:
      return AppLocalizations.of(context)!.mapNameArchipelago;
    case 15:
      return AppLocalizations.of(context)!.mapNameNagari;
    case 16:
      return AppLocalizations.of(context)!.mapNameBoulderBay;

    default:
      return "Unknown";
  }
}
