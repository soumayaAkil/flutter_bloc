part of 'dossier_detail_bloc.dart';

 class DossierDetailBlocEvent extends Equatable {
  const DossierDetailBlocEvent();

  @override
  List<Object> get props => [];
}
class LoadDetailEvent implements DossierDetailBlocEvent {

 const LoadDetailEvent(this.dossierAnalyse);

 final DossierDto dossierAnalyse;


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
class SwitchValideEvent implements DossierDetailBlocEvent {

 const SwitchValideEvent();

 @override
 // TODO: implement props
 List<Object> get props => throw UnimplementedError();

 @override
 // TODO: implement stringify
 bool? get stringify => throw UnimplementedError();

}
class FeedBackEvent implements DossierDetailBlocEvent {
 final String commentaire;
 final bool acontroler;
 const FeedBackEvent(this.commentaire, this.acontroler);

 @override
 // TODO: implement props
 List<Object> get props => throw UnimplementedError();

 @override
 // TODO: implement stringify
 bool? get stringify => throw UnimplementedError();


}
class selectDetailEvent implements DossierDetailBlocEvent {
 final DossierAnalyseDetail detail;
 const selectDetailEvent(this.detail);

 @override
 // TODO: implement props
 List<Object> get props => throw UnimplementedError();

 @override
 // TODO: implement stringify
 bool? get stringify => throw UnimplementedError();


}class checkboxEvent implements DossierDetailBlocEvent {
 final bool check;
 const checkboxEvent(this.check);

 @override
 // TODO: implement props
 List<Object> get props => throw UnimplementedError();

 @override
 // TODO: implement stringify
 bool? get stringify => throw UnimplementedError();


}
class LoadATBEvent implements DossierDetailBlocEvent {

 const LoadATBEvent(this.dossierAnalyse);

 final DossierDto dossierAnalyse;


 @override
 // TODO: implement props
 List<Object> get props => throw UnimplementedError();

 @override
 // TODO: implement stringify
 bool? get stringify => throw UnimplementedError();


}
class UpdateATBEvent implements DossierDetailBlocEvent {

 const UpdateATBEvent(this.commentaire);

 final String commentaire;


 @override
 // TODO: implement props
 List<Object> get props => throw UnimplementedError();

 @override
 // TODO: implement stringify
 bool? get stringify => throw UnimplementedError();


}class AddActionEvent implements DossierDetailBlocEvent {

 const AddActionEvent(this.sender_type,this.numDossier,this.solde,this.action,this.status,this.sender_id,this.destinataire,this.user);

 final String sender_type;
 final String numDossier;
 final double solde;
 final String action;
 final int status;
 final String sender_id;
 final String destinataire;
 final String user;

 @override
 // TODO: implement props
 List<Object> get props => throw UnimplementedError();

 @override
 // TODO: implement stringify
 bool? get stringify => throw UnimplementedError();


}