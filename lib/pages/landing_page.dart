import 'package:aoeiv_leaderboard/config/config.dart';
import 'package:aoeiv_leaderboard/config/styles/colors.dart';
import 'package:aoeiv_leaderboard/config/styles/spacing.dart';
import 'package:aoeiv_leaderboard/cubit/bottom_navigation_bar_cubit.dart';
import 'package:aoeiv_leaderboard/cubit/leaderboard_data_cubit.dart';
import 'package:aoeiv_leaderboard/models/player.dart';
import 'package:aoeiv_leaderboard/utils/get_leaderboard_id.dart';
import 'package:aoeiv_leaderboard/widgets/background.dart';
import 'package:aoeiv_leaderboard/widgets/centered_circular_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  final TextEditingController _searchFieldController = TextEditingController();

  @override
  void initState() {
    fetchLeaderboardData();
    super.initState();
  }

  @override
  void dispose() {
    _searchFieldController.dispose();
    super.dispose();
  }

  Future<void> fetchLeaderboardData() async {
    await BlocProvider.of<LeaderboardDataCubit>(context).fetchLeaderboardData(LeaderboardId.oneVOne.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [
              kcSecondaryColor,
              kcSecondaryColor,
            ],
          ),
        ),
        child: BlocBuilder<BottomNavigationBarCubit, BottomNavigationBarState>(
          builder: (context, state) {
            return BottomNavigationBar(
              onTap: (index) {
                if (index != state.index) {
                  _handleBottomNavbarOnTap(context, index);
                }
              },
              currentIndex: state.index,
              items: [
                BottomNavigationBarItem(icon: const Icon(Icons.person_outline), label: AppLocalizations.of(context)!.bottomNavigationBarLabel1v1),
                BottomNavigationBarItem(icon: const Icon(Icons.group_outlined), label: AppLocalizations.of(context)!.bottomNavigationBarLabel2v2),
                BottomNavigationBarItem(icon: const Icon(Icons.groups_outlined), label: AppLocalizations.of(context)!.bottomNavigationBarLabel3v3),
                BottomNavigationBarItem(icon: const Icon(Icons.schema_outlined), label: AppLocalizations.of(context)!.bottomNavigationBarLabel4v4),
              ],
            );
          },
        ),
      ),
      body: _buildBody(),
    );
  }

  void _handleBottomNavbarOnTap(BuildContext context, int index) {
    _searchFieldController.clear();

    BlocProvider.of<BottomNavigationBarCubit>(context).setIndex(index);

    final int leaderboardId = getLeaderboardId(index);
    BlocProvider.of<LeaderboardDataCubit>(context).fetchLeaderboardData(leaderboardId);
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
                SizedBox(height: Spacing.xl.spacing),
                _buildSearchbar(),
                SizedBox(height: Spacing.l.spacing),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(width: 60, child: Text(AppLocalizations.of(context)!.leaderboardLabelRank, style: Theme.of(context).textTheme.bodyText1)),
                    SizedBox(width: 50, child: Text(AppLocalizations.of(context)!.leaderboardLabelMmr, style: Theme.of(context).textTheme.bodyText1)),
                    Expanded(child: Text(AppLocalizations.of(context)!.leaderboardLabelName, style: Theme.of(context).textTheme.bodyText1)),
                    Text(AppLocalizations.of(context)!.leaderboardLabelWinRate, textAlign: TextAlign.end, style: Theme.of(context).textTheme.bodyText1),
                  ],
                ),
                SizedBox(height: Spacing.m.spacing),
                BlocBuilder<LeaderboardDataCubit, LeaderboardDataState>(
                  builder: (context, state) {
                    if (state is LeaderboardDataLoading) {
                      return const Expanded(child: CenteredCircularProgressIndicator());
                    }
                    if (state is LeaderboardDataLoaded) {
                      final List data = _searchFieldController.text.isEmpty ? state.leaderboardData : state.filteredPlayers;

                      return _buildLeaderboard(data);
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
      child: ListView.separated(
        padding: EdgeInsets.only(top: Spacing.m.spacing),
        separatorBuilder: (context, index) => SizedBox(height: Spacing.xl.spacing),
        itemCount: leaderboardData.length,
        itemBuilder: (context, index) {
          final Player player = leaderboardData[index];
          return InkWell(
            onTap: () => Navigator.of(context).pushNamed('/player', arguments: player),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(constraints: const BoxConstraints(minWidth: 60), child: Text("${player.rank}")),
                Container(constraints: const BoxConstraints(minWidth: 50), child: Text("${player.mmr}")),
                Expanded(child: Text(player.name)),
                Container(
                  constraints: BoxConstraints(minWidth: Spacing.xl.spacing),
                  child: Text("${player.winRate} %", textAlign: TextAlign.end),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        BlocBuilder<BottomNavigationBarCubit, BottomNavigationBarState>(
          builder: (context, state) {
            final String mode = _getMode(state.index);

            return Text(
              AppLocalizations.of(context)!.appTitle(mode),
              style: Theme.of(context).textTheme.headline1,
            );
          },
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
        color: kcSearchbarColor,
        borderRadius: BorderRadius.all(
          Radius.circular(5),
        ),
      ),
      child: TextField(
        controller: _searchFieldController,
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
          hintText: AppLocalizations.of(context)!.searchbarHintText,
          suffixIcon: IconButton(
            icon: const Icon(Icons.clear),
            color: kcTertiaryColor,
            onPressed: () {
              _searchFieldController.clear();
              BlocProvider.of<LeaderboardDataCubit>(context).searchPlayer(_searchFieldController.text);
            },
          ),
        ),
        onChanged: (playerName) => BlocProvider.of<LeaderboardDataCubit>(context).searchPlayer(playerName.toLowerCase()),
      ),
    );
  }

  String _getMode(int bottomNavbarIndex) {
    switch (bottomNavbarIndex) {
      case 0:
        return AppLocalizations.of(context)!.bottomNavigationBarLabel1v1;
      case 1:
        return AppLocalizations.of(context)!.bottomNavigationBarLabel2v2;
      case 2:
        return AppLocalizations.of(context)!.bottomNavigationBarLabel3v3;
      case 3:
        return AppLocalizations.of(context)!.bottomNavigationBarLabel4v4;
      default:
        return AppLocalizations.of(context)!.bottomNavigationBarLabel1v1;
    }
  }
}
