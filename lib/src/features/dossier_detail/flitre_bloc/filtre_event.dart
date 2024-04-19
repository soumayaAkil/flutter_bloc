part of 'filtre_bloc.dart';

class FiltreEvent extends Equatable {
  const FiltreEvent();

  @override
  List<Object> get props => [];
}

class IndexChangeC extends FiltreEvent {
  final bool tabIndexC;
  IndexChangeC({required this.tabIndexC});
}

class IndexChangeR extends FiltreEvent {
  final bool tabIndexR;

  IndexChangeR({required this.tabIndexR});
}
class IndexChangeH extends FiltreEvent {
  final bool tabIndexH;
  IndexChangeH({required this.tabIndexH});
}
class IndexReset extends FiltreEvent {


  IndexReset();
}
