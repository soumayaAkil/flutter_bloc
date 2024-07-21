part of 'dossier_detail_bloc.dart';

 class DossierDetailBlocState extends Equatable {
  final bool isLoadingDetail;
  final bool isLoadingATB;
  final bool valide;
  final bool signer;
  final DossierDto dossierAnalyse;
   final List<DetailCQI> details;
  //final List<DossierAnalyseDetail> details;
  final DossierAnalyseDetail? detailSelectionner;
  final String commentaire;
  final bool acontroler;
  final bool check;
  final List<Antibiogramme> antibiogrammes;
  final  int checkupdateATBA;
  final  int succesJob;

  const DossierDetailBlocState({this.isLoadingDetail=true, required this.dossierAnalyse,this.valide=false
  ,this.signer=false ,this.details =const [],this.commentaire="", this.acontroler=false, this.detailSelectionner=null,
   this.check=false,this.antibiogrammes=const [],this.isLoadingATB=false ,this.checkupdateATBA=0,this.succesJob=0});
  
  @override
  List<Object> get props => [checkupdateATBA,details , isLoadingDetail, dossierAnalyse,valide,signer,
   commentaire,acontroler,check,antibiogrammes,isLoadingATB,if(detailSelectionner!=null){detailSelectionner},succesJob];

  DossierDetailBlocState copyWith({
   List<DetailCQI>? details,
  // List<DossierAnalyseDetail>? details,
   List<Antibiogramme>? antibiogrammes,
   DossierAnalyseDetail? detailSelectionner,
   bool? isLoadingDetail,
   bool? isLoadingATB,
   bool? valide,
   bool? signer,
   String? commentaire,
   bool? acontroler,
   bool? check,
   DossierDto? dossierAnalyse,
   int? checkupdateATBA,
   int? succesJob,

  }) {
   return DossierDetailBlocState(
    isLoadingDetail: isLoadingDetail ?? this.isLoadingDetail,
    isLoadingATB: isLoadingATB ?? this.isLoadingATB,
    details: details ?? this.details,
    antibiogrammes: antibiogrammes ?? this.antibiogrammes,
    valide: valide ?? this.valide,
    signer: signer ?? this.signer,
    commentaire: commentaire ?? this.commentaire,
    acontroler: acontroler ?? this.acontroler,
    dossierAnalyse: dossierAnalyse ?? this.dossierAnalyse,
    detailSelectionner: detailSelectionner ?? this.detailSelectionner,
    check: check ?? this.check,
    checkupdateATBA: checkupdateATBA ?? this.checkupdateATBA,
    succesJob: succesJob ?? this.succesJob,
   );
  }
}



 class DossierDetailBlocInitial extends DossierDetailBlocState {
  DossierDetailBlocInitial({ required super.dossierAnalyse});

}
