part of 'dossieranalyse_bloc.dart';

// extends Equatable
class DossieranalyseState extends Equatable {
  const DossieranalyseState({
    this.sort = ASC,
    this.filtre = "date",
    this.valide = true,
    this.recherche = "",
    // filtre checkbox
    this.filtreDetails = "",
    this.dossiers = const [],
    this.isLoading = false,
    this.isPopupLoading = false,
    this.isLoadingMore = false,
  });
  final String sort;
  final String filtre;
  final bool valide;
  final String recherche;
  final String filtreDetails;
  final bool isLoading;
  final bool isPopupLoading;
  final bool isLoadingMore;
  final List<DossierDto> dossiers;
  @override
  List<Object> get props => [dossiers , sort,isLoading,isLoadingMore,recherche,filtre,valide,filtreDetails];

  DossieranalyseState copyWith({
    List<DossierDto>? dossiers,
    bool? isLoading,
    String? sort,
    String? recherche,
    String? filtre,
    bool? valide,
    String? filtreDetails,
    bool? isLoadingMore,
  }) {
    return DossieranalyseState(
      dossiers: dossiers ?? this.dossiers,
      isLoading: isLoading ?? this.isLoading,
      sort: sort ?? this.sort,
      recherche: recherche ?? this.recherche,
      filtre: filtre ?? this.filtre,
      valide: valide ?? this.valide,
      filtreDetails: filtreDetails ?? this.filtreDetails,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
    );
  }
}

class DossieranalyseInitial extends DossieranalyseState {
  DossieranalyseInitial() : super(sort: ASC, isLoading: false, dossiers: []);
}
/*

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
*/
