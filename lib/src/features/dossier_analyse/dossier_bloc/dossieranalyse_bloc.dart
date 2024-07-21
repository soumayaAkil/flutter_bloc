import 'dart:async';
import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/config/config.dart';
import '../../../../core/constants/strings/strings.dart';
import '../../../../core/util/util_functions.dart';
import '../../../../data/models/dossier_analyse_model.dart';
import '../../../../data/models/dossier_pagination.dart';
import '../../../../data/repository/dossier_repository.dart';
import '../../../../data/models/dossier_analyse_model.dart';
import '../../../../data/models/searchCriteria.dart';
import '../../../../data/repository/dossier_repository.dart';
import '../../home/home_bloc/home_bloc.dart';

part 'dossieranalyse_event.dart';
part 'dossieranalyse_state.dart';

class DossieranalyseBloc
    extends Bloc<DossieranalyseEvent, DossieranalyseState> {
  final DossierAnalyseRepository dossierAnalyseRepository;
  List<DossierDto> dossiers = [];
  int page = 0;
  // String asc = ASC;
  bool isLoadingMore = true;

  DossieranalyseBloc(this.dossierAnalyseRepository)
      : super(DossieranalyseInitial()) {
    on<LoadDossiersEvent>(_onCustomHomeEvent);
    on<LoadMoreDossiersEvent>((event, emit) async {
      isLoadingMore = true;
      print(page);

      page++;
      print(page);
      emit(state.copyWith(isLoading: true, isLoadingMore: true));
      try {
        DossierPagination?  result2= null;
        print(event.searchCriteriaGroup[0].searchCriterias?[0].value);
        if (state.filtre == "valide" || state.valide == false) {
          if (state.filtreDetails != "") {
            result2 = await dossierAnalyseRepository.getValideFiltreDossier(
                state.sort,
                page,
                event.dateDebFiltre, event.dateFinFiltre,
                event.searchCriteriaGroup, UtilFunctions.filtreBackValide(
                state.filtre, state.filtreDetails, state.recherche));
          }
          else {
            result2 = await dossierAnalyseRepository.getValideDossier(
                state.sort, page, event.dateDebFiltre, event.dateFinFiltre);
          }
        }
        else {
          result2 = await dossierAnalyseRepository.getDossier(
              state.sort, page, event.searchCriteriaGroup);
        }
        print(result2!.content!.length );
        if (result2!.content!.length < SIZEPAGINATION) {
          isLoadingMore = false;
          emit(state.copyWith(isLoadingMore: false));
          log("${state.isLoadingMore}hhhh");
          print("vide");
        }
        emit(state.copyWith(toatlDossiers: result2!.totalElements,
            dossiers: [...state.dossiers, ...?result2.content], isLoading: false));
      } catch (e) {
        emit(state.copyWith(isLoading: false, isLoadingMore: false));
        print("catch bloc $e");
        // emit(const DossieranalyseError("erreur"));
      }
    });
    on<SortDossiersEvent>((event, emit) async {
      List<SearchCriteriaGroup> ListsearchCriteriaGroups = [];
      List<SearchCriteria> ListCriterias = [];
      if (event is SortDossiersEvent) {
        emit(state.copyWith(sort: event.asc));
        emit(state.copyWith(isLoading: true, dossiers:null ));
        try {
          DossierPagination? resultSort = null;
          page = 0;
          ListsearchCriteriaGroups = UtilFunctions.formatSearchCriteria(
              event.startDate, event.endDate,
              state.filtre,
              state.recherche, state.filtreDetails);
          if (state.filtre == "valide" || state.valide == false) {
            if (state.filtreDetails != "") {
              resultSort =
              await dossierAnalyseRepository.getValideFiltreDossier(
                  state.sort,
                  page,
                  event.startDate, event.endDate, ListsearchCriteriaGroups,
                  UtilFunctions.filtreBackValide(
                      state.filtre, state.filtreDetails, state.recherche));
            }
            else {
              resultSort = await dossierAnalyseRepository.getValideDossier(
                  state.sort, page, event.startDate, event.endDate);
            }
          }
          else {
            // date ou recherche
            log(state.recherche + "ttt");

            ListsearchCriteriaGroups = UtilFunctions.formatSearchCriteria(
                event.startDate, event.endDate, state.filtre, state.recherche,
                state.filtreDetails);

            resultSort = await dossierAnalyseRepository.getDossier(
                state.sort, page, ListsearchCriteriaGroups);
          }
          /*
          ListsearchCriteriaGroups=UtilFunctions.formatSearchCriteria(
              event.startDate, event.endDate, "date", null,state.filtreDetails);
          page = 0;
           resultSort = await dossierAnalyseRepository.getDossier(
               state.sort, page, ListsearchCriteriaGroups);
          log("sortinng");
          */
          log("${resultSort!.content!.length}");
          emit(state.copyWith(toatlDossiers: resultSort!.totalElements,dossiers: resultSort.content, isLoading: false));
        } catch (e) {
          emit(state.copyWith(isLoading: false));
          print("catch bloc sorting ");
          print(e);
        }
      }
    });
    on<InitSortEvent>((event, emit) async {
      if (event is InitSortEvent) {
        emit(state.copyWith(sort: ASC));}});
  }
  Future<FutureOr<void>> _onCustomHomeEvent(
    LoadDossiersEvent event,
    Emitter<DossieranalyseState> emit,
  ) async {
    //  emit(DossieranalyseState(dossiers: event.dossiers));
    if (event is LoadDossiersEvent) {
    //Future<void> loadData(  ) async {
    emit(state.copyWith(isLoading: true,recherche: event.recherche,valide:event.valide,filtre: event.filtre,filtreDetails:event.filtreDetails));
    try {

      page = 0;
         DossierPagination?  result= null;
      if (event.filtre == "recherche") {
        emit(state.copyWith(recherche: event.recherche));

      }
      log("wwww ${event.filtre}");
      if (event.filtre == "valide" || event.valide==false) {
        log("aaa");
      if (event.filtreDetails !=""|| event.recherche!="") {
        log("bbb");
        result = await dossierAnalyseRepository.getValideFiltreDossier(
            state.sort,
            page,
            event.dateDebFiltre,event.dateFinFiltre,event.searchCriteriaGroup,UtilFunctions.filtreBackValide(event.filtre,event.filtreDetails,event.recherche));
      }
        else{
        result = await dossierAnalyseRepository.getValideDossier(
            state.sort,
            page,
            event.dateDebFiltre, event.dateFinFiltre);
      }
        }else {
        log("blocccc");
         result = await dossierAnalyseRepository.getDossier(
            state.sort,
            page,
            event.searchCriteriaGroup);
      }

      emit(state.copyWith(dossiers: result!.content,toatlDossiers: result!.totalElements, isLoading: false));
    } catch (e) {
      emit(state.copyWith(isLoading: false));
      print("catch bloc $e ");
      // emit(const DossieranalyseError("erreur"));
    }
    }
  }
}
/*
    on<LoadDossiersEvent>((event, emit) async {
      if(event is LoadDossiersEvent){
        emit(DossieranalyseInitial());
        try{
          print("emit loded");
          this.dossiers =await dossierAnalyseRepository.getDossier(event.dateDeb,event.dateFin,event.statut,event.asc);

          emit(DossieranalyseLoaded(dossiers));
      }catch (e){
        emit(DossieranalyseError("erreur"));
      }
      }
    });
    */
