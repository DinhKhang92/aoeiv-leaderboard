import 'package:aoeiv_leaderboard/config/config.dart';
import 'package:aoeiv_leaderboard/config/styles/colors.dart';
import 'package:aoeiv_leaderboard/cubit/bottom_navigation_bar_cubit.dart';
import 'package:aoeiv_leaderboard/cubit/leaderboard_data_cubit.dart';
import 'package:aoeiv_leaderboard/models/player.dart';
import 'package:aoeiv_leaderboard/widgets/background.dart';
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
              Color(0xff151925),
              Color(0xff151925),
            ],
          ),
        ),
        child: BlocBuilder<BottomNavigationBarCubit, BottomNavigationBarState>(
          builder: (context, state) {
            return BottomNavigationBar(
              onTap: (index) => _handleBottomNavbarOnTap(context, index),
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

    if (index == 0) {
      BlocProvider.of<LeaderboardDataCubit>(context).fetchLeaderboardData(LeaderboardId.oneVOne.id);
    } else if (index == 1) {
      BlocProvider.of<LeaderboardDataCubit>(context).fetchLeaderboardData(LeaderboardId.twoVTwo.id);
    } else if (index == 2) {
      BlocProvider.of<LeaderboardDataCubit>(context).fetchLeaderboardData(LeaderboardId.threeVThree.id);
    } else if (index == 3) {
      BlocProvider.of<LeaderboardDataCubit>(context).fetchLeaderboardData(LeaderboardId.fourVFour.id);
    } else {
      BlocProvider.of<LeaderboardDataCubit>(context).fetchLeaderboardData(LeaderboardId.oneVOne.id);
    }
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
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(width: 60, child: Text(AppLocalizations.of(context)!.leaderboardLabelRank, style: Theme.of(context).textTheme.bodyText1)),
                    SizedBox(width: 50, child: Text(AppLocalizations.of(context)!.leaderboardLabelMmr, style: Theme.of(context).textTheme.bodyText1)),
                    Expanded(child: Text(AppLocalizations.of(context)!.leaderboardLabelName, style: Theme.of(context).textTheme.bodyText1)),
                    Text(AppLocalizations.of(context)!.leaderboardLabelWinRate, textAlign: TextAlign.end, style: Theme.of(context).textTheme.bodyText1),
                  ],
                ),
                const SizedBox(height: 15),
                BlocBuilder<LeaderboardDataCubit, LeaderboardDataState>(
                  builder: (context, state) {
                    if (state is LeaderboardDataLoading) {
                      return _buildLeaderboardLoading();
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

  Expanded _buildLeaderboardLoading() {
    return Expanded(
      child: Center(
        child: CircularProgressIndicator(color: primaryColor),
      ),
    );
  }

  Widget _buildLeaderboard(List leaderboardData) {
    return Expanded(
      child: ListView.separated(
        padding: const EdgeInsets.only(top: 15),
        separatorBuilder: (context, index) => const SizedBox(height: 30),
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
                  constraints: const BoxConstraints(minWidth: 30),
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
        color: Color(0xffECECEC),
        borderRadius: BorderRadius.all(
          Radius.circular(5),
        ),
      ),
      child: TextField(
        style: const TextStyle(fontSize: 14),
        controller: _searchFieldController,
        textAlignVertical: TextAlignVertical.center,
        cursorColor: const Color(0xff2C3B4D),
        decoration: InputDecoration(
          hintText: AppLocalizations.of(context)!.searchbarHintText,
          hintStyle: const TextStyle(fontSize: 12, color: Color(0xff4E4E4E)),
          contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
          isDense: true,
          border: InputBorder.none,
          suffixIcon: IconButton(
            icon: const Icon(Icons.clear),
            color: const Color(0xff2C3B4D),
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
