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
          _buildHeader(context),
          _buildDisclaimerContent(context),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.all(Spacing.m.spacing),
        child: Header(headerTitle: AppLocalizations.of(context)!.pageTitleDisclaimer),
      ),
    );
  }

  Widget _buildDisclaimerContent(BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: Spacing.m.spacing),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          border: Border.all(color: kcPrimaryColor),
          borderRadius: BorderRadius.circular(5),
        ),
        child: _buildDisclaimerText(context),
      ),
    );
  }

  Widget _buildDisclaimerText(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(Spacing.m.spacing),
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
    );
  }
}
