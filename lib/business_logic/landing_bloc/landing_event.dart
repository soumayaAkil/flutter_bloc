part of '../landing_bloc/landing_bloc.dart';

 class LandingEvent {
  const LandingEvent();

  @override
  List<Object> get props => [];
}

class TabChange extends LandingEvent {
  final int tabIndex;


  TabChange({required this.tabIndex});
}


class StartDateChange extends LandingEvent {
  final String date;


  StartDateChange({required this.date});
}


class EndDateChange extends LandingEvent {
  final String date;


  EndDateChange({required this.date});
}
