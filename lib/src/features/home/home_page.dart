import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prolab_mobile/src/features/reglement/reglement_page.dart';
import '../../../core/constants/my_colors.dart';
import '../../../core/constants/strings/strings.dart';
import '../../../core/util/util_functions.dart';
import '../../../data/models/dossier_analyse_model.dart';
import '../../../data/repository/dossier_repository.dart';
import '../../../data/web_services/dossier_web_services.dart';
import '../dossier_analyse/dossier_bloc/dossieranalyse_bloc.dart';
import '../dossier_analyse/dossier_screen.dart';
import '../dossier_detail/antiboigramme_screen.dart';
import '../dossier_detail/pieces_jointe.dart';
import '../notification/notification_service.dart';
import '../parametre/parametre_page.dart';
import '../tableau_de_bord/tableau_bord_page.dart';
import 'home_bloc/home_bloc.dart';

List<BottomNavigationBarItem> bottomNavItems = const <BottomNavigationBarItem>[
  BottomNavigationBarItem(
    icon: Icon(Icons.drive_file_move_rounded),
    label: 'Dossier Analyse',
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
  const TableauBordScreen(),
  const ReglementScreen(),
  const ParametreScreen(),
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
          appBar: state.tabIndex != 0
              ? AppBar(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(15),
              ),

            ),
            backgroundColor: MyColors.colorPrimary,
            title: Center(
              child: getTitle(state.tabIndex),
            ),
            iconTheme: IconThemeData(
              color: Colors.white, // Change the color here
            ),
            actions: <Widget>[
              IconButton(
                  icon: Icon(Icons.add_alert),
                  onPressed: () {
                    NotificationService()
                        .showNotification(title: ' titre de notifiaction', body: 'contenu!');
                    })
            ],
          )
              :
          AppBar(
            backgroundColor: MyColors.colorPrimary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(15),
              ),

            ),
            title: Center(
              child: Column(children: [

              BlocBuilder<DossieranalyseBloc, DossieranalyseState>(
        builder: (context, state) {
          log("[home_page] state =>  $state");
          return     Text(
            'Dossier (s) :${ context.read<DossieranalyseBloc>().state.toatlDossiers }',
            style: TextStyle(color: MyColors.white),
          );
        }),


                ]),
            ),
            iconTheme: IconThemeData(
              color: Colors.white, // Change the color here
            ),
            actions: <Widget>[
              IconButton(
                  icon: Icon(Icons.add_alert),
                  onPressed: () {
                    NotificationService()
                        .showNotification(title: 'Sample title', body: 'It works!');
                  })
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
                              const Text("Date" ,style: const TextStyle(
                             fontSize: 16),),
                              const SizedBox(width: 10),
                              Container(
                                margin: EdgeInsets.only(right: 5),
                                padding:EdgeInsets.only(left: 10.0, right: 10),
                                decoration: BoxDecoration(
                                
                                border: Border.all(
                                    color: Colors.grey,
                                    width: 1.0,
                                    ), // no shadow color set, defaults to black
                                borderRadius:
                                const BorderRadius.all(Radius.circular(5)),
                             ),
                                child: InkWell(
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
                              ),
                             // const SizedBox(width: 20),
                              const Text("au" ,style: const TextStyle(
                                   fontSize: 16),),

                              Container(
                                margin: EdgeInsets.only(left: 5),
                                padding:EdgeInsets.only(left: 10.0, right: 10),
                                decoration: BoxDecoration(

                                  border: Border.all(
                                    color: Colors.grey,
                                    width: 1.0,
                                  ), // no shadow color set, defaults to black
                                  borderRadius:
                                  const BorderRadius.all(Radius.circular(5)),
                                ),
                                child: InkWell(
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

   getTitle(int tabIndex) {
    if (tabIndex == 1) {
      return Text(
        'Tableau de bord ',
        style: TextStyle(color: MyColors.white),
      );
    } else if (tabIndex == 2) {
      return Text(
        'Liste des règlements',
        style: TextStyle(color: MyColors.white),
      );
    } else if (tabIndex == 3) {
      return Text(
        ' Paramétres',
        style: TextStyle(color: MyColors.white),
      );
    }
  }

}


