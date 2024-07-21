import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prolab_mobile/data/models/dossier_analyse_model.dart';
import 'package:prolab_mobile/data/models/reglement_model.dart';

import '../../../core/constants/my_colors.dart';
import '../home/home_bloc/home_bloc.dart';
import '../home/home_page.dart';
import 'general_page.dart';
import 'test_page.dart';

class ParametreScreen extends StatefulWidget {
  const ParametreScreen({
    super.key,
  });
  @override
  _ParametreState createState() => _ParametreState();
}

class _ParametreState extends State<ParametreScreen> {
  late List<Reglement> allRegs;
  _ParametreState();


  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {

          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                GestureDetector(
                child: Row(
                  mainAxisAlignment :MainAxisAlignment.start,
                  children: [
                    Icon(Icons.build_circle_sharp, color: Colors.grey,),
                    SizedBox(width: 5,),
                    Text("Général",style: TextStyle( fontSize: 20),),


                  ],
                ),
                onTap: () {
                  Navigator.of(context).push(_createRoute(GeneralPage()));
                  /*
                  BlocProvider.of<HomeBloc>(context)
                      .add(TabChange(tabIndex: 2));
                  if( BlocProvider
                      .of<HomeBloc>(context)
                      .state
                      .tabIndex   ==2){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>

                          MultiBlocProvider(
                            providers: [
                              BlocProvider(
                                create: (context) => HomeBloc(),
                              ),
                            ],
                            child: const HomePage(),
                            // child: const DossierDetail(),
                          ),

                      ),
                    );
                  }
                  */
                },

              ),
    GestureDetector(
    child: Row(
    mainAxisAlignment :MainAxisAlignment.start,
    children: [
    Icon(Icons.build_circle_sharp, color: Colors.grey,),
    SizedBox(width: 5,),
    Text("Général",style: TextStyle( fontSize: 20),),


    ],
    ),
        onTap: (){
          Navigator.of(context).push(_createRoute(TestPage()));
        }),
                ]
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



