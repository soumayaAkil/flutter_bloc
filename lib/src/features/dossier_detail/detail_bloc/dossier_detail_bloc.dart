import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:prolab_mobile/data/models/antibiogramme.dart';
import 'package:prolab_mobile/src/features/dossier_detail/dossier_detail.dart';

import '../../../../core/util/util_functions.dart';
import '../../../../data/models/dossier_analyse_model.dart';
import '../../../../data/models/dossier_detail.dart';
import '../../../../data/repository/dossier_repository.dart';

part 'dossier_detail_event.dart';
part 'dossier_detail_state.dart';

class DossierDetailBloc
    extends Bloc<DossierDetailBlocEvent, DossierDetailBlocState> {
  final DossierAnalyseRepository dossierAnalyseRepository;
  DossierDetailBloc(this.dossierAnalyseRepository)
      : super(DossierDetailBlocInitial(dossierAnalyse: DossierDto(ignoreSolde: 0))) {
    on<DossierDetailBlocEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<LoadDetailEvent>((event, emit) async {
      log("[event detail]");
      log(event.dossierAnalyse.dossierAnalyse.toString());

      emit(state.copyWith(
          isLoadingDetail: true,
          dossierAnalyse: event.dossierAnalyse!,
          valide: (event.dossierAnalyse.dossierAnalyse!.statut!! & 4) > 0,
          acontroler: event.dossierAnalyse!.acontroler));
      log("tttttttttttttttttttt");
      log(state.dossierAnalyse.dossierAnalyse.toString());
      try {
        final res = await dossierAnalyseRepository
            .getDetailDossier(event.dossierAnalyse!.dossierAnalyse!.nenreg!!);

        emit(state.copyWith(details: res, isLoadingDetail: false));
      } catch (e) {
        emit(state.copyWith(isLoadingDetail: false));
        print("catch bloc ");
        print(e);
      }
    });
    on<LoadDetailPreviousEvent>((event, emit) async {
      emit(state.copyWith(isLoadingDetail: true));
      try {
        final res = await dossierAnalyseRepository
            .getDetailDossierPrevious(event.dossier);
        log("${res} [log detail previous]");
        emit(state.copyWith(
          details: res?.dossierDetail,
          dossierAnalyse: res?.dossierDTO,
          isLoadingDetail: false,
        ));
      } catch (e) {
        emit(state.copyWith(isLoadingDetail: false));
        print("catch bloc ");
        print(e);
      }
    });
    on<LoadDetailNextEvent>((event, emit) async {
      emit(state.copyWith(isLoadingDetail: true));
      try {
        final res =
            await dossierAnalyseRepository.getDetailDossierNext(event.dossier);
        log("${res} [log detail next]");
        emit(state.copyWith(
            details: res?.dossierDetail,
          dossierAnalyse: res?.dossierDTO,
          isLoadingDetail: false));
      } catch (e) {
        emit(state.copyWith(isLoadingDetail: false));
        print("catch bloc ");
        print(e);
      }
    });
    on<SwitchValideEvent>((event, emit) async {
      try {
        final result = await dossierAnalyseRepository.switchValideDossier(
            "", 0, state.dossierAnalyse);
        emit(state.copyWith(
            valide: (result.dossierAnalyse!.statut! & 4) > 0,
            dossierAnalyse: result,
            signer: (result.dossierAnalyse!.statut! & 4) > 0));
      } catch (e) {
        print("catch bloc ");
        print(e);
      }
    });
    on<FeedBackEvent>((event, emit) async {
      try {
        final result = await dossierAnalyseRepository.addFeedbackDetailDossier(
            "",
            0,
            state.detailSelectionner!,
            (state.commentaire != event.commentaire) ? event.commentaire : "",
            event.acontroler);

        if (result == 1) {
          log("iiiiiiiiiiiii");
          log(state.commentaire.toString());
          log(event.commentaire.toString());
          if (state.commentaire != event.commentaire) {
            state.detailSelectionner!.commentaire = event.commentaire;

            emit(state.copyWith(commentaire: event.commentaire));
          }
          state.detailSelectionner!.toControl = event.acontroler;

          emit(state.copyWith(acontroler: event.acontroler));
        }
      } catch (e) {
        print("catch bloc ");
        print(e);
      }
    });
    on<selectDetailEvent>((event, emit) async {
      try {
        emit(state.copyWith(
            detailSelectionner: event.detail,
            check: event.detail.toControl,
            commentaire: event.detail.commentaire,
            acontroler: event.detail.toControl));
      } catch (e) {
        print("catch bloc ");
        print(e);
      }
    });
    on<checkboxEvent>((event, emit) async {
      try {
        emit(state.copyWith(check: event.check));
      } catch (e) {
        print("catch bloc ");
        print(e);
      }
    });

    on<LoadATBEvent>((event, emit) async {
      emit(state.copyWith(isLoadingATB: true));
      try {
        final res = await dossierAnalyseRepository
            .getListATB(event.dossierAnalyse!.dossierAnalyse!.nenreg!!);
        emit(state.copyWith(
            antibiogrammes: res,
            isLoadingATB: false,
            commentaire:
                UtilFunctions.rtfToPlain(res![0].Remarque.toString())));
      } catch (e) {
        emit(state.copyWith(isLoadingATB: false));
        print("catch bloc ");
        print(e);
      }
    });
    on<UpdateATBEvent>((event, emit) async {
      emit(state.copyWith(isLoadingATB: true));
      try {
        final check = await dossierAnalyseRepository.getListUpdateATB(
            state.antibiogrammes[0], event.commentaire);
        emit(state.copyWith(checkupdateATBA: check, isLoadingATB: false));
        if (check == 1) {
          emit(state.copyWith(commentaire: event.commentaire));
        }
      } catch (e) {
        emit(state.copyWith(isLoadingATB: false));
        print("catch bloc ");
        print(e);
      }
    });
    on<AddActionEvent>((event, emit) async {
      try {
        emit(state.copyWith(succesJob: 0));
        log(event.user);
        final check = await dossierAnalyseRepository.setcreateJob(
            event.sender_type,event.numDossier,event.solde,event.action,event.status,event.sender_id,event.destinataire,event.user);
        log("[5raa]"+check.toString());
          emit(state.copyWith( succesJob: check));

      } catch (e) {
        emit(state.copyWith(succesJob: 0));
        print("catch bloc ");
        print(e);
      }
    });
  }
}
