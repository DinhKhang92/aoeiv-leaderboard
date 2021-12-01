import 'package:aoeiv_leaderboard/cubit/leaderboard_data_cubit.dart';
import 'package:aoeiv_leaderboard/models/player.dart';
import 'package:aoeiv_leaderboard/widgets/background.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  void initState() {
    fetchLeaderboardData();
    super.initState();
  }

  Future<void> fetchLeaderboardData() async {
    await BlocProvider.of<LeaderboardDataCubit>(context).fetchLeaderboardData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Stack(
      children: [
        const Background(),
        SafeArea(
          bottom: false,
          child: Container(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(),
                const SizedBox(height: 30),
                _buildSearchbar(),
                const SizedBox(height: 30),
                BlocBuilder<LeaderboardDataCubit, LeaderboardDataState>(
                  builder: (context, state) {
                    if (state is LeaderboardDataLoaded) {
                      return _buildLeaderboard(state.leaderboardData);
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLeaderboard(List leaderboardData) {
    return Expanded(
      child: DataTable2(
        lmRatio: 4,
        columns: _buildPlayerColumns(),
        rows: _buildPlayerRows(leaderboardData),
      ),
    );
  }

  List<DataColumn> _buildPlayerColumns() {
    return [
      DataColumn2(
        size: ColumnSize.M,
        label: Text(AppLocalizations.of(context)!.leaderboardLabelRank),
      ),
      DataColumn2(
        size: ColumnSize.M,
        label: Text(AppLocalizations.of(context)!.leaderboardLabelMmr),
      ),
      DataColumn2(
        size: ColumnSize.L,
        label: Text(AppLocalizations.of(context)!.leaderboardLabelName),
      ),
      DataColumn2(
        size: ColumnSize.M,
        label: Text(AppLocalizations.of(context)!.leaderboardLabelWinRate),
      ),
    ];
  }

  List<DataRow> _buildPlayerRows(List leaderboardData) {
    return leaderboardData.map((playerData) {
      final Player player = playerData as Player;

      return DataRow2(
        onTap: () => print(player.name),
        cells: [
          DataCell(Text("${player.rank}")),
          DataCell(Text("${player.mmr}")),
          DataCell(Text(player.name)),
          DataCell(Text("${player.winRate} %")),
        ],
      );
    }).toList();
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          AppLocalizations.of(context)!.appTitle("1v1"),
          style: Theme.of(context).textTheme.headline1,
        ),
        InkWell(
          onTap: () => Navigator.of(context).pushNamed('/disclaimer'),
          child: const Icon(Icons.info_outline_rounded),
        ),
      ],
    );
  }

  Widget _buildSearchbar() {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xffECECEC),
        borderRadius: BorderRadius.all(
          Radius.circular(5),
        ),
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: AppLocalizations.of(context)!.searchbarHintText,
          hintStyle: const TextStyle(fontSize: 12, color: Color(0xff4E4E4E)),
          contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
          isDense: true,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
