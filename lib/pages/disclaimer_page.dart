import 'package:aoeiv_leaderboard/widgets/background.dart';
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
              child: _buildHeader(context),
            ),
          ),
          Center(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 15),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xffFFDB88)),
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

  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: () => Navigator.of(context).pop(),
          child: Icon(Theme.of(context).platform == TargetPlatform.iOS ? Icons.arrow_back_ios : Icons.arrow_back_ios),
        ),
        Text(
          AppLocalizations.of(context)!.pageTitleDisclaimer,
          style: Theme.of(context).textTheme.headline1,
        ),
        const SizedBox(width: 24),
      ],
    );
  }
}
