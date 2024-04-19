part of 'home_bloc.dart';


@immutable
abstract class HomeState {
  final int tabIndex;
  final String startDate;
  final String endDate;
  const HomeState({required this.tabIndex, required this.startDate, required this.endDate});
}

class HomeInitial extends HomeState {
  const HomeInitial({required super.tabIndex, required super.startDate, required super.endDate});
}