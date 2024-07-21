part of 'email_bloc.dart';

 class EmailState extends Equatable {
  const EmailState();
  
  @override
  List<Object> get props => [];
}
class EmailInitial extends EmailState {}

class EmailValid extends EmailState {}

class EmailInvalid extends EmailState {}