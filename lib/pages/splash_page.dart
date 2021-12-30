import 'package:aoeiv_leaderboard/cubit/aoe_database_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    _initDb();
    super.initState();
  }

  Future<void> _initDb() async {
    await BlocProvider.of<AoeDatabaseCubit>(context).initDb();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return BlocListener<AoeDatabaseCubit, AoeDatabaseState>(
      listener: (context, state) {
        if (state is AoeDatabaseLoaded) {
          Navigator.of(context).pushNamed('/landing');
        }
      },
      child: Center(
        child: Container(
          width: 100,
          height: 100,
          color: Colors.red,
          child: const Text("SPLASH SCREEN"),
        ),
      ),
    );
  }
}
