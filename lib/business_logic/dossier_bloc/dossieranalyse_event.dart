part of 'dossieranalyse_bloc.dart';
// extends Equatable
@immutable
abstract class DossieranalyseEvent{
  const DossieranalyseEvent();

  @override
  List<Object> get props => [];
}
class LoadDossiersEvent implements DossieranalyseEvent {
  final String dateDeb ;
  final String dateFin;
  final String statut  ;
  final String asc ;
  @override
  List<Object> get props => [];
   LoadDossiersEvent( this.dateDeb, this.dateFin, this.statut, this.asc ){

   }


}
