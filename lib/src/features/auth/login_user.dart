import 'dart:developer';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/constants/my_colors.dart';
import '../../../core/util/util_functions.dart';
import '../../../data/models/login.dart';
import '../../../main.dart';
import '../../../router.dart';
import 'login_bloc/login_bloc.dart';

class LoginsPage extends StatefulWidget {
  const LoginsPage({super.key});

  @override
  State<StatefulWidget> createState() => LoginState();
}

class LoginState extends State {
  int touchedIndex = -1;
  late   TextEditingController passwordController = TextEditingController();
  late   TextEditingController nomController = TextEditingController();
  bool visible = false;
  bool _obscureText = true;
  bool _showError = false;
  bool _showErrorNom = false;
  late FocusNode _pwFocus;
  late FocusNode _nomFocus;
  @override
  void initState() {
    super.initState();
    _pwFocus = FocusNode();
    _nomFocus = FocusNode();
    passwordController = TextEditingController();
    nomController = TextEditingController();

    // Ajouter un listener pour les changements de focus
    _pwFocus.addListener(() {
      if (!_pwFocus.hasFocus) {
        // Valider le texte lorsque le champ de texte perd le focus
        setState(() {
          _showError = passwordController.text.isEmpty;
        });
      }
    });
    _nomFocus.addListener(() {
      if (!_nomFocus.hasFocus) {
        setState(() {
          _showErrorNom = nomController.text.isEmpty;
        });
      }
    });
  }
  Future userLogin() async {
    String nom = nomController.text.trimRight().trimLeft();
    String password = passwordController.text.trimRight().trimLeft();

  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(15),
          ),

        ),
        backgroundColor: MyColors.colorPrimary,
        centerTitle: true,
        title: Column(children: [
          Text(
            'Login',
            style: TextStyle(color: MyColors.white),
          ),
        ]),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          height: MediaQuery.of(context).size.height - 50,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Column(
                children: <Widget>[

                  ClipRRect(
                    borderRadius: BorderRadius.only(

                    ),
                    child: Image.asset('assets/images/logosama.png',
                    ),
                  ),

                ],
              ),
              Column(
                children: <Widget>[
                  Form(

                    child: Column(children: <Widget>[


                      Container(
                          height:60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            color: MyColors.colorPrimary.withOpacity(0.5),
                          ),
                          padding: EdgeInsets.only(left: 20),
                          child: TextField(
                              controller: nomController,
                              obscureText: false,
                              keyboardType: TextInputType.emailAddress,
                              textInputAction: TextInputAction.next,
                              onSubmitted: (input) {

                              },
                             // onTap: _validate,
                              autocorrect: true,
                              focusNode: _nomFocus,
                              decoration: InputDecoration(
                                  errorText:_showErrorNom  ? "Nom obligatoire " : null,
                                  border: InputBorder.none,
                                  hintText: " Nom de l'utilisateur",
                                  prefixIcon: Icon(Icons.person)))),
                      Container(
                          margin: EdgeInsets.only(top: 20),
                          height: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            color: MyColors.colorPrimary.withOpacity(0.5),
                          ),
                          padding: EdgeInsets.only(left: 20),
                          child: TextField(
                            obscureText: _obscureText,
                              controller:passwordController ,
                              textInputAction: TextInputAction.done,
                              onSubmitted: (input) {},
                              onTap: _validate,
                              focusNode: _pwFocus,

                              decoration: InputDecoration(
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      _obscureText ? Icons.visibility : Icons.visibility_off,
                                      color: Theme.of(context).primaryColorDark,
                                    ),
                                    onPressed: _toggle,
                                  ),
                                  errorText:_showError  ? "Mot de passe obligatoire " : null,
                                  border: InputBorder.none,
                                  hintText: ' ********',
                                  prefixIcon: Icon(Icons.vpn_key))),),



                    ]),
                  ),



                ],
              ),
              Container(
                  padding: const EdgeInsets.only(top: 3, left: 3),

                  child: ElevatedButton(
                    onPressed: () {

    Login login=Login(nomController.text.trimRight().trimLeft(),
    UtilFunctions.encrypt(passwordController.text.trimRight().trimLeft()));
    log("[logiiiin nomm]"+nomController.text.toString());
    log("[logiiiin paswd]"+UtilFunctions.encrypt(passwordController.text.trimRight().trimLeft()));
    context.read<LoginBloc>().add(VerifLoginEvent(login));
    if(_showErrorNom || _showError)
      {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Nom et Mot de passe sont obligatoires !'),
            backgroundColor: Colors.red,
            duration: Duration(seconds: 2),
          ),
        );
      }else
    if( context.read<LoginBloc>().state.tokenUtilisateur!="")
      {
    Navigator.pushAndRemoveUntil(context,MaterialPageRoute(builder: (context) =>ProlabApp(appRouter: AppRouter())),(Route<dynamic> route) => false,);
    }else
      {
        passwordController.text="";
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Nom et Mot de passe  invalide!'),
            backgroundColor: Colors.red,
            duration: Duration(seconds: 2),
          ),
        );
      }
                    },
                    child: const Text(
                      "valider",
                      style: TextStyle(fontSize: 20,color: MyColors.white,fontWeight: FontWeight.w700),
                    ),
                    style: ElevatedButton.styleFrom(
                      shape: const StadiumBorder(),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      backgroundColor: MyColors.colorPrimary,
                    ),
                  )
              ),

            ],
          ),
        ),
      ),
    );
  }



  void _validate() {
    isValidPassword(passwordController.text.toString() );

  }

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  bool isValidPassword( String password) {
    if ((password.length == 0)&&(password!=null)) {
      return false;
    }
    return true;
  }




}

