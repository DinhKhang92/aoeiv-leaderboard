import 'package:aoeiv_leaderboard/config/styles/theme.dart';
import 'package:aoeiv_leaderboard/cubit/game_mode_selector_cubit.dart';
import 'package:aoeiv_leaderboard/cubit/leaderboard_data_cubit.dart';
import 'package:aoeiv_leaderboard/cubit/match_history_data_cubit.dart';
import 'package:aoeiv_leaderboard/cubit/rating_history_data_cubit.dart';
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

  final LeaderboardDataRepository _leaderboardDataRepository = LeaderboardDataRepository();
  final RatingHistoryDataRepository _ratingHistoryDataRepository = RatingHistoryDataRepository();
  final MatchHistoryDataRepository _matchHistoryDataRepository = MatchHistoryDataRepository();

  late final LeaderboardDataCubit _leaderboardDataCubit = LeaderboardDataCubit(leaderboardDataRepository: _leaderboardDataRepository);
  late final RatingHistoryDataCubit _ratingHistoryDataCubit = RatingHistoryDataCubit(ratingHistoryDataRepository: _ratingHistoryDataRepository);
  late final MatchHistoryDataCubit _matchHistoryDataCubit = MatchHistoryDataCubit(matchHistoryDataRepository: _matchHistoryDataRepository);
  final GameModeSelectorCubit _gameModeSelectorCubit = GameModeSelectorCubit();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LeaderboardDataCubit>(create: (_) => _leaderboardDataCubit),
        BlocProvider<RatingHistoryDataCubit>(create: (_) => _ratingHistoryDataCubit),
        BlocProvider<GameModeSelectorCubit>(create: (_) => _gameModeSelectorCubit),
        BlocProvider<MatchHistoryDataCubit>(create: (_) => _matchHistoryDataCubit),
      ],
      child: MaterialApp(
        title: 'AoE4-Leaderboard',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          textSelectionTheme: ktTextSelectionTheme,
          inputDecorationTheme: ktInputDecorationTheme,
          textTheme: ktTextTheme,
          iconTheme: ktIconThemeData,
          bottomNavigationBarTheme: ktBottomNavigationBarTheme,
        ),
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
    );
  }
}
