import 'dart:developer';
import 'dart:ffi';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../data/models/stat_model.dart';
import '../../../../data/repository/dossier_repository.dart';

part 'stat_event.dart';
part 'stat_state.dart';

class StatBloc extends Bloc<StatEvent, StatState> {
  final DossierAnalyseRepository dossierAnalyseRepository;
  StatBloc(this.dossierAnalyseRepository) : super(StatInitial()) {
    on<StatEvent>((event, emit) async {
      if (event is LoadStat) {
        emit(state.copyWith(
            isLoadingStat: true,
            ));
        try {
          final res = await dossierAnalyseRepository
              .getStatDossiers(event.dateDebut,event.dateFin);

          emit(state.copyWith(statDao: res, isLoadingStat: false));
        } catch (e) {
          emit(state.copyWith(isLoadingStat: false));
          print("catch bloc ");
          print(e);
        }
     }
    });
  }
}
