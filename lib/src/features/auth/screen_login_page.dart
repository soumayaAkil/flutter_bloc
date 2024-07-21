import 'package:flutter/material.dart';
import 'dart:convert';

import '../../../core/constants/my_colors.dart';
import '../../../main.dart';
import '../../../router.dart';



// ignore: camel_case_types

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);
  @override
  _loginPageState createState() => _loginPageState();
}

class _loginPageState extends State<LoginPage> {
  @override
  void initState() {
    _obscureText = true;
    _emailFocus = FocusNode();
    _pwFocus = FocusNode();


    super.initState();
  }

  bool visible = false;
  late FocusNode _emailFocus, _pwFocus;
  bool _obscureText = true;
  late String _password;
  late String _email;

  var mytoken;

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  Future userLogin() async {
    setState(() {
      visible = true;
    });
    String email = emailController.text.trimRight().trimLeft();
    String password = passwordController.text.trimRight().trimLeft();
    var formdata = _formkey.currentState;
/*
    Future<void> getRecipesv() async {
      print("ggggggggggggggg");
      _vals = await TempApi.getAllTempV();
      print(_vals![0]);
    }
    */
    var data = {'email': email, 'password': password, 'token': mytoken};



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

                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) =>
                  ProlabApp(appRouter: AppRouter())), (Route<dynamic> route) => false,
                  );
                },

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

}