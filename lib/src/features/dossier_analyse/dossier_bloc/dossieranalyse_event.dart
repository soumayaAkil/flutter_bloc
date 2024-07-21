part of 'dossieranalyse_bloc.dart';

// extends Equatable
@immutable
abstract class DossieranalyseEvent {
  const DossieranalyseEvent();

  @override
  List<Object> get props => [];
}

class LoadDossiersEvent implements DossieranalyseEvent {
  const LoadDossiersEvent(this.dateDebFiltre,this.dateFinFiltre,
      this.searchCriteriaGroup,this.recherche,this.valide,this.filtre,this.filtreDetails);
  // final List<DossierAnalyse> dossiers;
  final List<SearchCriteriaGroup> searchCriteriaGroup;
  final String recherche;
  final String filtre;
  final bool valide;
  final String filtreDetails;
  final String dateDebFiltre;
  final String dateFinFiltre;
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class LoadMoreDossiersEvent implements DossieranalyseEvent {
  const LoadMoreDossiersEvent(
    this.searchCriteriaGroup,
      this.dateDebFiltre,
      this.dateFinFiltre
  );
  final String dateDebFiltre;
  final String dateFinFiltre;
  final List<SearchCriteriaGroup> searchCriteriaGroup;
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class SortDossiersEvent implements DossieranalyseEvent {
  final String asc;
  final String startDate;
  final String endDate;
  const SortDossiersEvent(
    this.asc,
    this.startDate,
    this.endDate,
  );

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}
class InitSortEvent implements DossieranalyseEvent {

  const InitSortEvent();

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}
