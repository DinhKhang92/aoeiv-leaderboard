import 'package:aoeiv_leaderboard/config/styles/colors.dart';
import 'package:aoeiv_leaderboard/cubit/bottom_navigation_bar_cubit.dart';
import 'package:aoeiv_leaderboard/cubit/leaderboard_data_cubit.dart';
import 'package:aoeiv_leaderboard/cubit/rating_history_data_cubit.dart';
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

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LeaderboardDataCubit>(create: (_) => _leaderboardDataCubit),
        BlocProvider<RatingHistoryDataCubit>(create: (_) => _ratingHistoryDataCubit),
        BlocProvider<BottomNavigationBarCubit>(create: (_) => _bottomNavigationBarCubit),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          textTheme: TextTheme(
            headline1: TextStyle(
              color: primaryColor,
              fontSize: 20,
              fontWeight: FontWeight.w400,
            ),
            bodyText1: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
            bodyText2: const TextStyle(
              color: Colors.white,
              fontSize: 14,
            ),
          ),
          iconTheme: IconThemeData(
            color: primaryColor,
          ),
          dataTableTheme: const DataTableThemeData(
            columnSpacing: 15,
            horizontalMargin: 0,
            dividerThickness: 0,
            headingTextStyle: TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
            dataTextStyle: TextStyle(color: Colors.white),
          ),
          bottomNavigationBarTheme: BottomNavigationBarThemeData(
            elevation: 0,
            showUnselectedLabels: true,
            selectedItemColor: primaryColor,
            unselectedItemColor: const Color(0xffB6B6B6),
            backgroundColor: Colors.transparent,
            type: BottomNavigationBarType.fixed,
          ),
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
