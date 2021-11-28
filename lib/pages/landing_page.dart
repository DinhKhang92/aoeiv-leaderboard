import 'package:aoeiv_leaderboard/cubit/leaderboard_data_cubit.dart';
import 'package:aoeiv_leaderboard/models/player.dart';
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
        _buildBackground(),
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
      child: SingleChildScrollView(
        child: DataTable(
          columns: <DataColumn>[
            DataColumn(
              label: Container(
                color: Colors.red,
                margin: const EdgeInsets.only(right: 30),
                child: Text(AppLocalizations.of(context)!.leaderboardLabelRank),
              ),
            ),
            DataColumn(
              label: Container(
                margin: const EdgeInsets.only(right: 30),
                color: Colors.blue,
                child: Text(AppLocalizations.of(context)!.leaderboardLabelMmr),
              ),
            ),
            DataColumn(
              label: Container(
                color: Colors.yellow,
                child: Text(AppLocalizations.of(context)!.leaderboardLabelName),
              ),
            ),
            DataColumn(
              label: Container(
                color: Colors.green,
                child: Text(AppLocalizations.of(context)!.leaderboardLabelWinsAndGames),
              ),
            ),
          ],
          rows: _buildPlayerRows(leaderboardData),
        ),
      ),
    );
  }

  List<DataRow> _buildPlayerRows(List leaderboardData) {
    return leaderboardData.map((playerData) {
      final Player player = playerData as Player;

      return DataRow(cells: [
        DataCell(Text("${player.rank}")),
        DataCell(Text("${player.mmr}")),
        DataCell(Text(player.name)),
        DataCell(Text("${player.totalWins}/${player.totalGames}")),
      ]);
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
          onTap: () => print("open-disclaimer"),
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

  Widget _buildBackground() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xff2C3B4D),
            Color(0xff151925),
          ],
        ),
      ),
    );
  }
}
