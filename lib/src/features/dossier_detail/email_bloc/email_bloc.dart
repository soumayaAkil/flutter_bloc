import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'email_event.dart';
part 'email_state.dart';

class EmailBloc extends Bloc<EmailEvent, EmailState> {
  EmailBloc() : super(EmailInitial()) {
    on<EmailChanged>((event, emit) {
      if (isValidEmail(event.email)) {
        emit(EmailValid());
      } else {
        emit(EmailInvalid());
      }
    });
  }

  bool isValidEmail(String email) {
    final emailRegex = RegExp(
        r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
    return emailRegex.hasMatch(email);
  }
}
