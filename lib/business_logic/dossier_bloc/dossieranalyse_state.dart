part of 'dossieranalyse_bloc.dart';
// extends Equatable 
abstract class DossieranalyseState {
  const DossieranalyseState();  

  @override
  List<Object> get props => [];
}
class DossieranalyseInitial extends DossieranalyseState {
  
}

class DossieranalyseLoaded extends DossieranalyseState {
  final List<DossierAnalyse> dossiers;

 const DossieranalyseLoaded(this.dossiers);
    @override
  List<Object> get props => [dossiers];
}

class DossieranalyseError extends DossieranalyseState {
  final String message;

  const DossieranalyseError(this.message);
 
    @override
  List<Object> get props => [message];
}
