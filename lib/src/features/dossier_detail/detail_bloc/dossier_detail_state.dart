part of 'dossier_detail_bloc.dart';

 class DossierDetailBlocState extends Equatable {
  final bool isLoadingDetail;
  final List<DossierAnalyseDetail> details;
  const DossierDetailBlocState({this.isLoadingDetail=false,
   this.details =const [],});
  
  @override
  List<Object> get props => [details , isLoadingDetail];

  DossierDetailBlocState copyWith({
   List<DossierAnalyseDetail>? details,
   bool? isLoadingDetail,
  }) {
   return DossierDetailBlocState(
    isLoadingDetail: isLoadingDetail ?? this.isLoadingDetail,
    details: details ?? this.details,
   );
  }
}



 class DossierDetailBlocInitial extends DossierDetailBlocState {

}
