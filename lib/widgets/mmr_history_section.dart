import 'package:aoeiv_leaderboard/cubit/rating_history_data_cubit.dart';
import 'package:aoeiv_leaderboard/exceptions/no_data_exception.dart';
import 'package:aoeiv_leaderboard/models/rating.dart';
import 'package:aoeiv_leaderboard/widgets/error_display.dart';
import 'package:aoeiv_leaderboard/widgets/line_chart.dart';
import 'package:aoeiv_leaderboard/widgets/section_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MmrHistorySection extends StatefulWidget {
  const MmrHistorySection({Key? key}) : super(key: key);

  @override
  _MmrHistorySectionState createState() => _MmrHistorySectionState();
}

class _MmrHistorySectionState extends State<MmrHistorySection> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RatingHistoryDataCubit, RatingHistoryDataState>(
      builder: (context, state) {
        if (state is RatingHistoryDataLoaded) {
          return Column(
            children: [
              SectionTitle(title: AppLocalizations.of(context)!.sectionTitleMmrHistory),
              _buildRatingHistoryLineChart(state.ratingHistoryData),
            ],
          );
        }

        if (state is RatingHistoryDataError) {
          final String errorMessage = state.error is NoDataException ? AppLocalizations.of(context)!.errorMessageNoDataFound : AppLocalizations.of(context)!.errorMessageFetchData;
          return ErrorDisplay(errorMessage: errorMessage);
        }

        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildRatingHistoryLineChart(List<Rating> ratingHistoryData) {
    return Container(
      constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.width - 50),
      child: RatingLineChart(ratingHistoryData: ratingHistoryData),
    );
  }
}
