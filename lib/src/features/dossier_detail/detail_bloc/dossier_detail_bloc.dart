import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:prolab_mobile/src/features/dossier_detail/dossier_detail.dart';

import '../../../../data/models/dossier_analyse_model.dart';
import '../../../../data/models/dossier_detail.dart';
import '../../../../data/repository/dossier_repository.dart';

part 'dossier_detail_event.dart';
part 'dossier_detail_state.dart';

class DossierDetailBloc
    extends Bloc<DossierDetailBlocEvent, DossierDetailBlocState> {
  final DossierAnalyseRepository dossierAnalyseRepository;
  DossierDetailBloc(this.dossierAnalyseRepository)
      : super(DossierDetailBlocInitial()) {
    on<DossierDetailBlocEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<LoadDetailEvent>((event, emit) async {
      log("[event detail]");
      emit(state.copyWith(isLoadingDetail: true));
      try {
        final res =
            await dossierAnalyseRepository.getDetailDossier(event.nenreg);
        log("${res} [log detail]");
        emit(state.copyWith(details: res, isLoadingDetail: false));
      } catch (e) {
        emit(state.copyWith(isLoadingDetail: false));
        print("catch bloc ");
        print(e);
      }
    });
    on<LoadDetailPreviousEvent>((event, emit) async {
      log("[event detail]");
      emit(state.copyWith(isLoadingDetail: true));
      try {
        log("77777",error: event.dossier);
        final res =
            await dossierAnalyseRepository.getDetailDossierPrevious(event.dossier);
        log("${res} [log detail]");
        emit(state.copyWith(details: res, isLoadingDetail: false));
      } catch (e) {
        emit(state.copyWith(isLoadingDetail: false));
        print("catch bloc ");
        print(e);
      }
    });
    on<LoadDetailNextEvent>((event, emit) async {
      log("[event detail]");
      emit(state.copyWith(isLoadingDetail: true));
      try {
        log("77777",error: event.dossier);
        final res =
            await dossierAnalyseRepository.getDetailDossierNext(event.dossier);
        log("${res} [log detail]");
        emit(state.copyWith(details: res, isLoadingDetail: false));
      } catch (e) {
        emit(state.copyWith(isLoadingDetail: false));
        print("catch bloc ");
        print(e);
      }
    });
  }
}
