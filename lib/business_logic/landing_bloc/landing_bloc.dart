import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'landing_event.dart';
part 'landing_state.dart';

class LandingBloc extends Bloc<LandingEvent, LandingState> {
  LandingBloc() : super(LandingInitial(tabIndex:0, startDate: "${DateTime.now().year-4}/${DateTime.now().month}/${DateTime.now().day} "
  , endDate:"${DateTime.now().year}/${DateTime.now().month}/${DateTime.now().day} "
  )) {
    on<LandingEvent>((event, emit) {
      if (event is TabChange) {
        print(event.tabIndex);
        emit(LandingInitial(tabIndex: event.tabIndex, endDate: state.endDate, startDate: state.startDate));
      }

      if(event is StartDateChange){
        print("startdate event");
        emit(LandingInitial(tabIndex: state.tabIndex, endDate: state.endDate, startDate: event.date));
      }

      if(event is EndDateChange){
        emit(LandingInitial(tabIndex: state.tabIndex, endDate: event.date, startDate: state.startDate));
      }
    });
  }
}

