part of 'dossier_detail_bloc.dart';

 class DossierDetailBlocEvent extends Equatable {
  const DossierDetailBlocEvent();

  @override
  List<Object> get props => [];
}
class LoadDetailEvent implements DossierDetailBlocEvent {

 const LoadDetailEvent(this.nenreg);

 final String nenreg;


 @override
 // TODO: implement props
 List<Object> get props => throw UnimplementedError();

  @override
  // TODO: implement stringify
  bool? get stringify => throw UnimplementedError();


}
class LoadDetailPreviousEvent implements DossierDetailBlocEvent {

 const LoadDetailPreviousEvent(this.dossier);

 final DossierAnalyse dossier;


 @override
 // TODO: implement props
 List<Object> get props => throw UnimplementedError();

 @override
 // TODO: implement stringify
 bool? get stringify => throw UnimplementedError();


}
class LoadDetailNextEvent implements DossierDetailBlocEvent {

 const LoadDetailNextEvent(this.dossier);

 final DossierAnalyse dossier;


 @override
 // TODO: implement props
 List<Object> get props => throw UnimplementedError();

 @override
 // TODO: implement stringify
 bool? get stringify => throw UnimplementedError();


}