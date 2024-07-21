part of 'login_bloc.dart';

 class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}
class VerifLoginEvent implements LoginEvent {
 const VerifLoginEvent(this.login);
 final Login login;
 @override
 // TODO: implement props
 List<Object> get props => throw UnimplementedError();

 @override
 // TODO: implement stringify
 bool? get stringify => throw UnimplementedError();
}
