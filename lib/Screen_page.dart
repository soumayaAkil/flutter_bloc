import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:prolab_mobile/core/constants/my_colors.dart';
import 'package:prolab_mobile/data/repository/dossier_repository.dart';
import 'package:prolab_mobile/main.dart';
import 'package:prolab_mobile/router.dart';
import 'package:prolab_mobile/src/features/auth/login_bloc/login_bloc.dart';
import 'package:prolab_mobile/src/features/auth/screen_login_page.dart';
import 'package:video_player/video_player.dart';

import 'data/web_services/dossier_web_services.dart';


class Screen_page extends StatefulWidget {
  @override
  _Screen_pageState createState() => _Screen_pageState();
}

class _Screen_pageState extends State<Screen_page>
    with SingleTickerProviderStateMixin {
 // var _visible = true;
  late VideoPlayerController _controller;
  bool _visible = false;
  late AnimationController animationController;
  late Animation<double> animation;
  late DossierAnalyseRepository  dossiersRepository = DossierAnalyseRepository(DossierWebService());
  final FlutterSecureStorage _secureStorage = FlutterSecureStorage();
/*
  startTime() async {
    var _duration = new Duration(seconds: 3);
    return new Timer(_duration, Login);
  }


  void Login() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => LoginPage() ),
          //ProlabApp(appRouter: AppRouter(),) ),
          (Route<dynamic> route) => false,
    );
  }
  */
  void initState() {
    super.initState();
    String token = '';
    _saveToken(token);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    _controller = VideoPlayerController.asset('assets/images/sama-logo-animation.mp4');
    _controller.initialize().then((_) {
      _controller.setLooping(true);
      Timer(Duration(milliseconds: 1000),
              () {
        setState(() {
          _controller.play();
          _visible = true;
        });
      });
    });

    Future.delayed(Duration(seconds: 3), () {

      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (context) =>  LoginPage(),




          ),
              (e) => false);
    });

  /*  animationController = new AnimationController(
        vsync: this, duration: new Duration(seconds: 6));
    animation =
    new CurvedAnimation(parent: animationController, curve: Curves.easeOut);

    animation.addListener(() => this.setState(() {}));
    animationController.forward();

    setState(() {
      _visible = !_visible;
    });
    */
  //  startTime();
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Scaffold(
        body: Center(
          child: Stack(
            children: <Widget>[
              _getVideoBackground(),
            ],
          ),
        ),
      /* Container(

          child: Stack(fit: StackFit.expand, children: <Widget>[
            new Column(
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Padding(
                      padding: EdgeInsets.only(bottom: 300.0),
                      child: new Image.asset(
                        'assets/images/sama-logo-animation.mp4',
                        //height: 160.0,
                        fit: BoxFit.contain,
                      )),
                 new Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[

                        new Image.asset(
                          'assets/images/logosama.png',
                          width: animation.value * 60,
                          height: animation.value * 60,
                        ),
                        ]),


                ]),
          ]),
        )
            */
    );

  }

  @override
  void dispose() {
    super.dispose();
    if (_controller != null) {
      _controller.dispose();
      //_controller = null;
    }
  }

  _getVideoBackground() {
    return AnimatedOpacity(
      opacity: _visible ? 1.0 : 0.0,
      duration: Duration(milliseconds: 3000),
      child: VideoPlayer(_controller),
    );
  }

  _getBackgroundColor() {
    return Container(color: Colors.transparent //.withAlpha(120),
    );
  }

  _getContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
    );
  }
  Future<void> _saveToken(String token) async {
    await _secureStorage.write(key: 'token', value: token);
  }
}
