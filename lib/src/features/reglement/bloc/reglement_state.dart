part of 'reglement_bloc.dart';

 class ReglementState extends Equatable {
  const ReglementState({
   this.regs = const [],
   this.isLoadingReg = false,
  });
  final bool isLoadingReg;
  final List<Reglement> regs;
  @override
  List<Object> get props => [isLoadingReg,regs];

  ReglementState copyWith({
   List<Reglement>? regs,
   bool? isLoadingReg,
  }) {
   return ReglementState(
    regs: regs ?? this.regs,
    isLoadingReg: isLoadingReg ?? this.isLoadingReg,

   );
  }
 }


 class ReglementInitial extends ReglementState {

  ReglementInitial():super( isLoadingReg: false, regs: []);
 }
