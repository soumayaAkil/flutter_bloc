

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../dossier_analyse/dossier_bloc/dossieranalyse_bloc.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial(tabIndex:0, startDate: "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year-2}"
  , endDate:"${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}"
  )) {
    on<HomeEvent>((event, emit) {
      if (event is TabChange) {
        print(event.tabIndex);
        emit(HomeInitial(tabIndex: event.tabIndex, endDate: state.endDate, startDate: state.startDate));
      }

      if(event is StartDateChange){
        print("startdate event");
        emit(HomeInitial(tabIndex: state.tabIndex, endDate: state.endDate, startDate: event.date));
      }

      if(event is EndDateChange){
        emit(HomeInitial(tabIndex: state.tabIndex, endDate: event.date, startDate: state.startDate));
      }
    });
  }
}

