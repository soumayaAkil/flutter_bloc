part of 'login_bloc.dart';

 class LoginState extends Equatable {
 final String nomUtilisateur;
 final String tokenUtilisateur;
 final String tokenExpiration;
 final bool isLoadingLog;
  const LoginState({
   this.nomUtilisateur = "",
   this.tokenUtilisateur = "",
   this.tokenExpiration = "",
   this.isLoadingLog= false
 });
  
  @override
  List<Object> get props => [nomUtilisateur,tokenUtilisateur,tokenExpiration, isLoadingLog];
 LoginState copyWith({
  String? nomUtilisateur,
  String? tokenUtilisateur,  bool? isLoadingLog, String? tokenExpiration,
 }) {
  return LoginState(
   nomUtilisateur: nomUtilisateur ?? this.nomUtilisateur,
   tokenUtilisateur: tokenUtilisateur ?? this.tokenUtilisateur,
   tokenExpiration: tokenExpiration ?? this.tokenExpiration,
   isLoadingLog: isLoadingLog ?? this.isLoadingLog,

  );
 }
}

 class LoginInitial extends LoginState {}
