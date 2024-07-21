part of 'reglement_bloc.dart';

@immutable
abstract class ReglementEvent extends Equatable {
 @override
 List<Object> get props => [];
}
  class LoadRegEvent implements ReglementEvent {
  const LoadRegEvent(this.dateDebReg,this.dateFinReg);
  final String dateDebReg;
  final String dateFinReg;
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();

  @override
  // TODO: implement stringify
  bool? get stringify => throw UnimplementedError();
  }

