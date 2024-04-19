import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/constants/my_colors.dart';
import '../../../core/constants/strings/strings.dart';
import '../../../core/util/util_functions.dart';
import '../../../data/models/dossier_analyse_model.dart';
import '../../../data/repository/dossier_repository.dart';
import '../../../data/web_services/dossier_web_services.dart';
import '../dossier_analyse/dossier_bloc/dossieranalyse_bloc.dart';
import '../dossier_analyse/dossier_screen.dart';
import 'home_bloc/home_bloc.dart';

List<BottomNavigationBarItem> bottomNavItems = const <BottomNavigationBarItem>[
  BottomNavigationBarItem(
    icon: Icon(Icons.home),
    label: 'Home',
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.dashboard),
    label: 'Tableau de bord',
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.paid),
    label: 'Règlement',
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.settings),
    label: 'Paramétres',
  ),
];

int currentIndex = 0;

List<Widget> bottomNavScreen = <Widget>[
  const HomeScreen(),
  const Text('Index 2: tab de bord'),
  const Text('Index 3: reglement'),
  const Text('Index 4: parametre'),
];

@RoutePage()
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
 // late List<DossierAnalyse> allDossierAnalyse;
  DossierAnalyseRepository dossiersRepository =
  DossierAnalyseRepository(DossierWebService());

  DateTime dateDeb = DateTime(
      DateTime
          .now()
          .year - 2, DateTime
      .now()
      .month, DateTime
      .now()
      .day);

  DateTime dateDFin =
  DateTime(DateTime
      .now()
      .year, DateTime
      .now()
      .month, DateTime
      .now()
      .day);

  @override
  void initState() {
    super.initState();
  }

  Widget showLoadingIndicator() {
    return const Center(
      child: CircularProgressIndicator(
        color: MyColors.lightGrey,
      ),
    );
  }

  Widget buildNoInternetWidget() {
    return Center(
      child: Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Can\'t connect .. check internet',
              style: TextStyle(
                fontSize: 22,
                color: MyColors.grayClair,
              ),
            ),
            Image.asset('assets/images/male_doc.png')
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var forAndroid = TargetPlatform.android;
    return BlocConsumer<HomeBloc, HomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: MyColors.colorPrimary,
            title: const Text(
              'Liste des Dossiers',
              style: TextStyle(color: MyColors.grayClair),
            ),
            actions: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.refresh),
                color: MyColors.lightGrey,
              ),
            ],
            scrolledUnderElevation: 4.0,
          ),
          resizeToAvoidBottomInset: false,
          body: Stack(
            alignment: Alignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  if (state.tabIndex != 3)
                    Container(
                      height: 40.0,

                      //color: Colors.black,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20.0, right: 20),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("Date"),
                              const SizedBox(width: 20),
                              InkWell(
                                onTap: () async {
                                  DateTime? newDate = await showDatePicker(
                                    context: context,
                                    initialDate: dateDeb,
                                    firstDate: DateTime(1950),
                                    lastDate: DateTime(dateDFin.year,
                                        dateDFin.month, dateDFin.day),
                                  );
                                  if (newDate == null) return;
                                  setState(() => dateDeb = newDate);
                                  final difference = dateDFin.difference(
                                      dateDeb);
                                  // 16591
                                  if (difference.inDays > 7) {
                                    print(
                                        "intervaaaaallll grand ${difference
                                            .inDays}");

                                    showAlertDialog(context);
                                  }
                                  //APIDATE
                                  String convertedDateDeb =
                                  UtilFunctions.getFormatDate(dateDeb);
                                  BlocProvider.of<HomeBloc>(context)
                                      .add(
                                      StartDateChange(date: convertedDateDeb));
                                },
                                child: Text(
                                  "${dateDeb.day}/${dateDeb.month}/${dateDeb
                                      .year}",
                                  style: const TextStyle(
                                      color: Colors.black, fontSize: 18),
                                ),
                              ),
                              const SizedBox(width: 20),
                              const Text("au"),
                              const SizedBox(width: 20),
                              InkWell(
                                onTap: () async {
                                  DateTime? newDate = await showDatePicker(
                                    context: context,
                                    initialDate: dateDFin,
                                    firstDate: DateTime(
                                        dateDeb.year, dateDeb.month,
                                        dateDeb.day),
                                    lastDate: new DateTime(2200),
                                  );
                                  if (newDate == null) return;
                                  setState(() => dateDFin = newDate);
                                  final difference = dateDFin.difference(
                                      dateDeb);
                                  // 16591
                                  if (difference.inDays > 7) {
                                    print(
                                        "intervaaaaallll grand ${difference
                                            .inDays}");

                                    showAlertDialog(context);
                                  }

                                  //APIDATE
                                  String convertedDateFin =
                                  UtilFunctions.getFormatDate(dateDFin);

                                  BlocProvider.of<HomeBloc>(context)
                                      .add(
                                      EndDateChange(date: convertedDateFin));
                                },
                                child: Text(
                                  "${dateDFin.day}/${dateDFin.month}/${dateDFin
                                      .year}",
                                  style: const TextStyle(
                                      color: Colors.black, fontSize: 18),
                                ),
                              ),
                            ]),
                      ),
                    ),
                  bottomNavScreen.elementAt(state.tabIndex),
                ],
              ),
/*
          BlocBuilder<DossieranalyseBloc, DossieranalyseState>(

            builder: (_, state ) {
              return
                !state.isLoading ? const SizedBox():
                AlertDialog(
                title: const Text(
                  "Ceci peut prendres quelque minutes",
                  style: TextStyle(color: Colors.black, fontSize: 18),
                ),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Image.asset(
                      'assets/images/sablier.png', // Replace with your image path
                      width: 100,
                      height: 100,
                    ),
                  ],
                ),

              );


            }
          )
  */
            ],
          ),
          floatingActionButton:
          state.tabIndex != 0
              ? null
              :
          BlocBuilder<DossieranalyseBloc, DossieranalyseState>(
              builder: (context, state) {
                log("[home_page] state =>  $state");
                return FloatingActionButton(
                  backgroundColor: MyColors.grayClair,
                  onPressed: () {
                    print("${state.sort}  stateOnpressed");
                    String op;
                    var currentasc = state.sort;
                        /*BlocProvider
                        .of<DossieranalyseBloc>(context)
                        .asc;
                    */
                    if (currentasc == ASC) {
                      op = DESC;
                    } else {
                      op = ASC;
                    }

                    context.read<DossieranalyseBloc>()
                        .add(SortDossiersEvent(op,
                        BlocProvider
                            .of<HomeBloc>(context)
                            .state
                            .startDate,
                        BlocProvider
                            .of<HomeBloc>(context)
                            .state
                            .endDate));

                  },

                  child: Column(children: [

                    RotatedBox(
                        quarterTurns: 2,
                        child: Icon(
                          state.sort ==
                              ASC
                              ? Icons.expand_circle_down
                              : Icons.expand_circle_down_outlined,
                        )),
                    Icon(state.sort == ASC
                        ? Icons.expand_circle_down_outlined
                        : Icons.expand_circle_down_rounded),
                  ]),


                );
              }),
          bottomNavigationBar: BottomNavigationBar(
            items: bottomNavItems,
            currentIndex: state.tabIndex,
            selectedItemColor: Theme
                .of(context)
                .colorScheme
                .primary,
            unselectedItemColor: Colors.grey,
            onTap: (index) {
              BlocProvider.of<HomeBloc>(context)
                  .add(TabChange(tabIndex: index));
            },
          ),
        );
      },
    );
  }

  showAlertDialog(BuildContext contextt) {
    // show the dialog

    showDialog(
        context: contextt,
        builder: (BuildContext context2) {
          // if(2==2 ){

          return
            BlocProvider.value(
              value: BlocProvider.of<DossieranalyseBloc>(context),
                child: BlocBuilder<DossieranalyseBloc, DossieranalyseState>(
                  builder: (context, state) {
                    /* final state = context
                          .watch<DossieranalyseBloc>()
                          .state; */
                    log('[alert_dialog] state $state');
                    if (!state.isLoading) {
                      Navigator.pop(context);
                    }
                    return
                      AlertDialog(
                        title: const Text(
                          "Ceci peut prendre quelques minutes",
                          style: TextStyle(color: Colors.black, fontSize: 18),
                        ),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Image.asset(
                              'assets/images/sablierV.png',
                              // Replace with your image path
                              width: 100,
                              height: 100,
                            ),
                          ],
                        ),
                
                      );
                  },
                ),);
              }
            );


  }


}


