import 'package:aoeiv_leaderboard/config/styles/theme.dart';
import 'package:aoeiv_leaderboard/cubit/bottom_navigation_bar_cubit.dart';
import 'package:aoeiv_leaderboard/cubit/leaderboard_data_cubit.dart';
import 'package:aoeiv_leaderboard/cubit/rating_history_data_cubit.dart';
import 'package:aoeiv_leaderboard/cubit/rating_history_mode_selector_cubit.dart';
import 'package:aoeiv_leaderboard/routes/route_generator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final LeaderboardDataCubit _leaderboardDataCubit = LeaderboardDataCubit();
  final RatingHistoryDataCubit _ratingHistoryDataCubit = RatingHistoryDataCubit();
  final BottomNavigationBarCubit _bottomNavigationBarCubit = BottomNavigationBarCubit();
  final RatingHistoryModeSelectorCubit _ratingHistoryModeSelectorCubit = RatingHistoryModeSelectorCubit();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LeaderboardDataCubit>(create: (_) => _leaderboardDataCubit),
        BlocProvider<RatingHistoryDataCubit>(create: (_) => _ratingHistoryDataCubit),
        BlocProvider<BottomNavigationBarCubit>(create: (_) => _bottomNavigationBarCubit),
        BlocProvider<RatingHistoryModeSelectorCubit>(create: (_) => _ratingHistoryModeSelectorCubit),
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
