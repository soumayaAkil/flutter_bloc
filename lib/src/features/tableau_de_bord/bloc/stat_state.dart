part of 'stat_bloc.dart';

 class StatState extends Equatable {
  const StatState({ this.statDao=null, this.isLoadingStat= false});
  final StatDao? statDao;
  final bool isLoadingStat;
  @override
  List<Object> get props => [ if(statDao!=null){statDao},isLoadingStat];

  StatState copyWith({
   StatDao? statDao,
   bool? isLoadingStat,
  }) {
   return StatState(
    statDao: statDao ?? this.statDao,
    isLoadingStat: isLoadingStat ?? this.isLoadingStat,

   );
  }
}

 class StatInitial extends StatState {
  StatInitial();

}
