part of 'email_bloc.dart';

 class EmailEvent extends Equatable {
  const EmailEvent();

  @override
  List<Object> get props => [];
}
class EmailChanged extends EmailEvent {
  final String email;

  const EmailChanged(this.email);

  @override
  List<Object> get props => [email];
}
