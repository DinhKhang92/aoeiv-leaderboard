import 'package:aoeiv_leaderboard/config/styles/colors.dart';
import 'package:aoeiv_leaderboard/config/styles/spacing.dart';
import 'package:aoeiv_leaderboard/widgets/background.dart';
import 'package:aoeiv_leaderboard/widgets/header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DisclaimerPage extends StatelessWidget {
  const DisclaimerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const Background(),
          SafeArea(
            bottom: false,
            child: Container(
              padding: const EdgeInsets.all(15),
              child: Header(headerTitle: AppLocalizations.of(context)!.pageTitleDisclaimer),
            ),
          ),
          Center(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: Spacing.m.spacing),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                border: Border.all(color: kcPrimaryColor),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text: AppLocalizations.of(context)!.disclaimerCaption,
                      children: [
                        const TextSpan(text: "\n\n"),
                        TextSpan(text: AppLocalizations.of(context)!.disclaimerText),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
