import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

String mapTimestampToMatchDateLabel(BuildContext context, int timestamp) {
  final DateTime matchTimestamp = DateTime.fromMillisecondsSinceEpoch(timestamp);
  final DateTime now = DateTime.now();

  final int minutes = now.difference(matchTimestamp).inMinutes;
  if (minutes < 60) {
    return AppLocalizations.of(context)!.playerDetailMatchHistoryTimeInMinutes(minutes);
  }

  final int hours = now.difference(matchTimestamp).inHours;
  if (hours < 24) {
    return AppLocalizations.of(context)!.playerDetailMatchHistoryTimeInHours(hours);
  }

  final int days = (now.difference(matchTimestamp).inDays);
  if (days < 7) {
    return AppLocalizations.of(context)!.playerDetailMatchHistoryTimeInDays(days);
  }

  final int weeks = (days / 7).floor();
  if (weeks < 5) {
    return AppLocalizations.of(context)!.playerDetailMatchHistoryTimeInWeeks(weeks);
  }

  final int months = (weeks / 4).floor();
  return AppLocalizations.of(context)!.playerDetailMatchHistoryTimeInMonths(months);
}
