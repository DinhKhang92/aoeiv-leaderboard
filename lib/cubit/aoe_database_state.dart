part of 'aoe_database_cubit.dart';

abstract class AoeDatabaseState extends Equatable {
  const AoeDatabaseState();

  @override
  List<Object> get props => [];
}

class AoeDatabaseInitial extends AoeDatabaseState {}

class AoeDatabaseLoading extends AoeDatabaseState {}

class AoeDatabaseLoaded extends AoeDatabaseState {}

class AoeDatabaseError extends AoeDatabaseState {}
