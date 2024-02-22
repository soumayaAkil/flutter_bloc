import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import '../../data/repository/dossier_repository.dart';

import '../../data/models/dossier_analyse_model.dart';


part 'dossieranalyse_event.dart';
part 'dossieranalyse_state.dart';

class DossieranalyseBloc extends Bloc<DossieranalyseEvent, DossieranalyseState> {
  final DossierAnalyseRepository dossierAnalyseRepository ;
   List<DossierAnalyse> dossiers = [];
  
  DossieranalyseBloc( this.dossierAnalyseRepository) : super(DossieranalyseInitial()) {
    on<LoadDossiersEvent>((event, emit) async {
      if(event is LoadDossiersEvent){
        // emit loading state
        //call api
        //loded state - Error state
        emit(DossieranalyseInitial());
        try{
       // final todos = await todos   api ;
          print("emit loded");
          /*
          dossierAnalyseRepository.getDossier().then((dossiers){
            emit(DossieranalyseLoaded(dossiers));
            this.dossiers = dossiers;
          });
          */
          this.dossiers =await dossierAnalyseRepository.getDossier(event.dateDeb,event.dateFin,event.statut,event.asc);
        
          emit(DossieranalyseLoaded(dossiers));
      }catch (e){
        emit(DossieranalyseError("erreur"));
      }
      }
    });
  }
  /*
  List<DossierAnalyse> getAllDossier(){
    dossierAnalyseRepository.getDossier().then((dossiers){
       emit(DossieranalyseLoaded(dossiers));
       this.dossiers = dossiers;
       });
       return dossiers;

    })
  }
  */
}







