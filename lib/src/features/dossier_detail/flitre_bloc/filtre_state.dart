part of 'filtre_bloc.dart';
@immutable
abstract class FiltreState extends Equatable {
  final bool tabIndexC;
  final bool tabIndexR;
  final bool tabIndexH;
  const FiltreState({required this.tabIndexC, required this.tabIndexR,required this.tabIndexH});
  
  @override
  List<Object> get props => [tabIndexC,tabIndexR,tabIndexH];
}

 class FiltreInitial extends FiltreState {
  FiltreInitial({required super.tabIndexC,required super.tabIndexR,required super.tabIndexH});
}
