part of 'landing_bloc.dart';


@immutable
abstract class LandingState {
  final int tabIndex;
  final String startDate;
  final String endDate;
  const LandingState({required this.tabIndex, required this.startDate, required this.endDate});
}

class LandingInitial extends LandingState {
  const LandingInitial({required super.tabIndex, required super.startDate, required super.endDate});
}