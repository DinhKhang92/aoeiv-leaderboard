import 'package:aoeiv_leaderboard/config/styles/theme.dart';
import 'package:aoeiv_leaderboard/cubit/aoe_database_cubit.dart';
import 'package:aoeiv_leaderboard/cubit/game_mode_selector_cubit.dart';
import 'package:aoeiv_leaderboard/cubit/leaderboard_data_cubit.dart';
import 'package:aoeiv_leaderboard/cubit/match_history_data_cubit.dart';
import 'package:aoeiv_leaderboard/cubit/rating_history_data_cubit.dart';
import 'package:aoeiv_leaderboard/providers/leaderboard_data_provider.dart';
import 'package:aoeiv_leaderboard/providers/match_history_data_provider.dart';
import 'package:aoeiv_leaderboard/providers/rating_history_data_provider.dart';
import 'package:aoeiv_leaderboard/repositories/leaderboard_data_repository.dart';
import 'package:aoeiv_leaderboard/repositories/match_history_data_repository.dart';
import 'package:aoeiv_leaderboard/repositories/rating_history_data_repository.dart';
import 'package:aoeiv_leaderboard/routes/route_generator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final MatchHistoryDataProvider _matchHistoryDataProvider = MatchHistoryDataProvider();
  final LeaderboardDataProvider _leaderboardDataProvider = LeaderboardDataProvider();
  final RatingHistoryDataProvider _ratingHistoryDataProvider = RatingHistoryDataProvider();

  late final LeaderboardDataRepository _leaderboardDataRepository = LeaderboardDataRepository(leaderboardDataProvider: _leaderboardDataProvider);
  late final RatingHistoryDataRepository _ratingHistoryDataRepository =
      RatingHistoryDataRepository(leaderboardDataProvider: _leaderboardDataProvider, ratingHistoryDataProvider: _ratingHistoryDataProvider);
  late final MatchHistoryDataRepository _matchHistoryDataRepository = MatchHistoryDataRepository(matchHistoryDataProvider: _matchHistoryDataProvider);

  late final LeaderboardDataCubit _leaderboardDataCubit = LeaderboardDataCubit(leaderboardDataRepository: _leaderboardDataRepository);
  late final RatingHistoryDataCubit _ratingHistoryDataCubit = RatingHistoryDataCubit(ratingHistoryDataRepository: _ratingHistoryDataRepository);
  late final MatchHistoryDataCubit _matchHistoryDataCubit = MatchHistoryDataCubit(matchHistoryDataRepository: _matchHistoryDataRepository);
  final GameModeSelectorCubit _gameModeSelectorCubit = GameModeSelectorCubit();
  final AoeDatabaseCubit _aoeDatabaseCubit = AoeDatabaseCubit();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LeaderboardDataCubit>(create: (_) => _leaderboardDataCubit),
        BlocProvider<RatingHistoryDataCubit>(create: (_) => _ratingHistoryDataCubit),
        BlocProvider<GameModeSelectorCubit>(create: (_) => _gameModeSelectorCubit),
        BlocProvider<MatchHistoryDataCubit>(create: (_) => _matchHistoryDataCubit),
        BlocProvider<AoeDatabaseCubit>(create: (_) => _aoeDatabaseCubit),
      ],
      child: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
            FocusManager.instance.primaryFocus?.unfocus();
          }
        },
        child: MaterialApp(
          title: 'AoE4-Leaderboard',
          debugShowCheckedModeBanner: false,
          theme: ktTheme,
          initialRoute: '/',
          onGenerateRoute: RouteGenerator.generateRoute,
          supportedLocales: const [
            Locale('en', ''),
          ],
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
        ),
      ),
    );
  }
}
