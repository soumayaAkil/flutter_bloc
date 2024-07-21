import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:prolab_mobile/data/repository/dossier_repository.dart';
import 'dart:convert';

import '../../../core/constants/my_colors.dart';
import '../../../data/models/login.dart';
import '../../../data/web_services/dossier_web_services.dart';
import '../../../main.dart';
import '../../../router.dart';
import '../parametre/general_page.dart';
import 'login_bloc/login_bloc.dart';
import 'login_user.dart';



// ignore: camel_case_types

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);
  @override
  _loginPageState createState() => _loginPageState();
}

class _loginPageState extends State<LoginPage> {
  final FlutterSecureStorage _secureStorage = FlutterSecureStorage();
  String _token = '';
  @override
  void initState()  {

    _loadToken();

    Future.delayed(Duration(seconds: 2), ()  {

      if ((_token.isEmpty))
        {
          log("[token if] $_token");
        Navigator.of(context).push(_createRoute(GeneralPage()));
    }else{
        if(_token.isEmpty)
          {
            log("#[token] null ");
          }
      log("[token] ${_token.toString()}");
      Navigator.pushAndRemoveUntil(context,MaterialPageRoute(builder: (context) =>ProlabApp(appRouter: AppRouter())),(Route<dynamic> route) => false,);

      }
    });

    super.initState();
  }




  Future<void> _loadToken() async {
    String token = await _secureStorage.read(key: 'token') ?? '';
    setState(() {
      _token = token;
    });
  }
  late DossierAnalyseRepository  dossiersRepository = DossierAnalyseRepository(DossierWebService());

  bool visible = false;
  late FocusNode _emailFocus, _pwFocus;
  bool _obscureText = true;
  late String _password;
  late String _email;

  var mytoken;

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final nomController = TextEditingController();
  final passwordController = TextEditingController();

  Future userLogin() async {
    setState(() {
      visible = true;
    });
    String nom = nomController.text.trimRight().trimLeft();
    String password = passwordController.text.trimRight().trimLeft();
    var formdata = _formkey.currentState;
/*
    Future<void> getRecipesv() async {
      print("ggggggggggggggg");
      _vals = await TempApi.getAllTempV();
      print(_vals![0]);
    }
    */



  }


  void _validate() {

  }




  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[

                Container(
                  margin: EdgeInsets.only(top:  MediaQuery
                      .of(context)
                      .size
                      .height * 0.25),
                  child: Center(

                    child: Image.asset('assets/images/logosama.png',
                    ),
                  ),
                ),
                Text(
                  'Prolab Mobile',
                  style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold),
                ),           Container(
                  margin: EdgeInsets.only(top: 5),
                  child: Text(
                    'By Sama-Consulting',
                    style: TextStyle(
                        fontSize: 25,
                      color: Colors.grey
                        ),
                  ),
                ),
        Container(
          decoration: BoxDecoration(
            color: MyColors.colorPrimary,
            boxShadow: [
              BoxShadow(
                // color: Colors.grey.shade600,
                color: MyColors.colorPrimary,
                //  blurStyle: BlurStyle.solid,
                blurRadius: 10.0,
                spreadRadius: 1,

                offset: Offset(0, 3.0),
              ),
            ],
            border: Border.all(
                color: MyColors.colorPrimary,
                width: 2.0,
                style: BorderStyle
                    .solid), // no shadow color set, defaults to black
            borderRadius:
            const BorderRadius.all(Radius.circular(5)),
          ),

            margin: EdgeInsets.only(top: 60),
            child: TextButton(


                onPressed: () {  },
                child: Text(
                  'Se connecter',
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.w700),
                ),
            ),
        ),

              ])
      ),
    );
  }
  Route _createRoute(dynamic Page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => Page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(-1.0, 0.0); // Change to left-to-right animation
        const end = Offset.zero;
        const curve = Curves.ease;

        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        var offsetAnimation = animation.drive(tween);

        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
    );
  }
}