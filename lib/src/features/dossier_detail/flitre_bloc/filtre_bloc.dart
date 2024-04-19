import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

part 'filtre_event.dart';
part 'filtre_state.dart';

class FiltreBloc extends Bloc<FiltreEvent, FiltreState> {
  FiltreBloc() : super(FiltreInitial(tabIndexC: true,tabIndexR: true,tabIndexH: true)) {
    on<FiltreEvent>((event, emit) {
      if (event is IndexChangeC) {
        print(event.tabIndexC);
        emit(FiltreInitial(tabIndexC: event.tabIndexC,tabIndexR: state.tabIndexR,tabIndexH: state.tabIndexH) );
      }
      if (event is IndexChangeR) {
        print(event.tabIndexR);
        emit(FiltreInitial(tabIndexC: state.tabIndexC,tabIndexR: event.tabIndexR,tabIndexH: state.tabIndexH) );
      }
      if (event is IndexChangeH) {
        print(event.tabIndexH);
        emit(FiltreInitial(tabIndexC: state.tabIndexC,tabIndexR: state.tabIndexR,tabIndexH:event.tabIndexH) );
      }
      if (event is IndexReset) {
        emit(FiltreInitial(tabIndexC: true,tabIndexR: true,tabIndexH:true) );
      }
    });
  }
}
