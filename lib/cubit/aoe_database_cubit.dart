import 'package:aoeiv_leaderboard/utils/aoe_database.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'aoe_database_state.dart';

class AoeDatabaseCubit extends Cubit<AoeDatabaseState> {
  final AoeDatabase _aoeDatabase = AoeDatabase();

  AoeDatabaseCubit() : super(AoeDatabaseInitial());

  Future<void> initDb() async {
    emit(AoeDatabaseLoading());
    await _aoeDatabase.init();
    emit(AoeDatabaseLoaded());
  }
}
