import 'package:aoeiv_leaderboard/config/styles/spacing.dart';
import 'package:aoeiv_leaderboard/cubit/match_history_data_cubit.dart';
import 'package:aoeiv_leaderboard/utils/map_id_to_civilization.dart';
import 'package:aoeiv_leaderboard/utils/map_id_to_civilization_color.dart';
import 'package:aoeiv_leaderboard/widgets/centered_circular_progress_indicator.dart';
import 'package:aoeiv_leaderboard/widgets/pie_chart.dart';
import 'package:aoeiv_leaderboard/widgets/section_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CivPickSection extends StatefulWidget {
  const CivPickSection({Key? key}) : super(key: key);

  @override
  _CivPickSectionState createState() => _CivPickSectionState();
}

class _CivPickSectionState extends State<CivPickSection> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MatchHistoryDataCubit, MatchHistoryDataState>(
      builder: (context, state) {
        if (state is MatchHistoryDataLoading) {
          return const CenteredCircularProgressIndicator();
        }

        if (state is MatchHistoryDataLoaded && state.filteredMatches.isNotEmpty) {
          return Column(
            children: [
              SectionTitle(title: AppLocalizations.of(context)!.sectionTitleCivilizationDistribution),
              SizedBox(height: Spacing.l.spacing),
              SizedBox(
                height: MediaQuery.of(context).size.width - 4 * Spacing.m.spacing,
                width: MediaQuery.of(context).size.width,
                child: SimplePieChart(
                  civDistribution: state.civilizationDistribution,
                  totalCount: state.totalCount,
                ),
              ),
              SizedBox(height: Spacing.l.spacing),
              _buildLegend(state.civilizationDistribution),
              SizedBox(height: Spacing.l.spacing),
            ],
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildLegend(Map civDistribution) {
    civDistribution.removeWhere((key, value) => value > 0 ? false : true);

    return Wrap(
      spacing: Spacing.s.spacing,
      runSpacing: Spacing.xxs.spacing,
      children: civDistribution.entries.map((entry) {
        return Wrap(
          spacing: Spacing.xs.spacing,
          children: [
            CircleAvatar(
              backgroundColor: mapIdToCivilizationColor(int.parse(entry.key)),
              radius: 7,
            ),
            Text(mapIdToCivilization(context, int.parse(entry.key))),
          ],
        );
      }).toList(),
    );
  }
}
