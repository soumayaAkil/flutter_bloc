part of 'stat_bloc.dart';

 class StatEvent extends Equatable {
  const StatEvent();

  @override
  List<Object> get props => [];
 }
  class LoadStat extends StatEvent {
  final String dateDebut;
  final String dateFin;


  LoadStat(this.dateDebut, this.dateFin);

}
