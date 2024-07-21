import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../../data/models/login.dart';
import '../../../../data/repository/dossier_repository.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final DossierAnalyseRepository dossierAnalyseRepository;
  final FlutterSecureStorage _secureStorage = FlutterSecureStorage();
  LoginBloc(this.dossierAnalyseRepository) : super(LoginInitial()) {
    on<LoginEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<VerifLoginEvent>((event, emit) async {
      emit(state.copyWith(isLoadingLog: true));
      try {
        final res =
        await dossierAnalyseRepository.getLogin(
            event.login );
        log("[resssssssssss]"+ res!.token.toString());


        _saveToken(res!.token.toString());

        emit(state.copyWith(nomUtilisateur: event.login.nom,tokenUtilisateur:res!.token,tokenExpiration: res!.tokenExpiration, isLoadingLog: false));
      } catch (e) {
        emit(state.copyWith(isLoadingLog: false));
        print("catch bloc login");
        print(e);
      }
    });
  }
  Future<void> _saveToken(String token) async {
    await _secureStorage.write(key: 'token', value: token);
  }
}
