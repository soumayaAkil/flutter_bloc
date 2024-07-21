import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:prolab_mobile/data/models/reglement_model.dart';

import '../../../../data/repository/dossier_repository.dart';

part 'reglement_event.dart';
part 'reglement_state.dart';

class ReglementBloc extends Bloc<ReglementEvent, ReglementState> {
  final DossierAnalyseRepository dossierAnalyseRepository;

  ReglementBloc(this.dossierAnalyseRepository) : super(ReglementInitial()) {
    on<ReglementEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<LoadRegEvent>((event, emit) async {
      emit(state.copyWith(isLoadingReg: true));
      try {
        final res =
        await dossierAnalyseRepository.getListReglement(
            event.dateDebReg, event.dateFinReg );

        emit(state.copyWith(regs: res, isLoadingReg: false));
      } catch (e) {
        emit(state.copyWith(isLoadingReg: false));
        print("catch bloc reg");
        print(e);
      }
    });
  }
}
