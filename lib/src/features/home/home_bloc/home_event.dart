part of '../home_bloc/home_bloc.dart';

 class HomeEvent {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class TabChange extends HomeEvent {
  final int tabIndex;


  TabChange({required this.tabIndex});
}


class StartDateChange extends HomeEvent {
  final String date;


  StartDateChange({required this.date});
}


class EndDateChange extends HomeEvent {
  final String date;


  EndDateChange({required this.date});
}
