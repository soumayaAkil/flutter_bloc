import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';
import '../../../core/constants/my_colors.dart';
import '../../../core/constants/strings/strings.dart';
import '../../../core/util/util_functions.dart';
import '../../../data/models/dossier_analyse_model.dart';
import '../../../data/models/searchCriteria.dart';
import '../../../data/repository/dossier_repository.dart';
import '../../../data/web_services/dossier_web_services.dart';
import '../dossier_detail/flitre_bloc/filtre_bloc.dart';
import '../home/home_bloc/home_bloc.dart';
import 'dossier_bloc/dossieranalyse_bloc.dart';
import 'home_page_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late List<DossierDto> allDossierAnalyse;
  DossierAnalyseRepository dossiersRepository =
      DossierAnalyseRepository(DossierWebService());
  bool isSwitched = true;
  var textValue = 'Non validé';

  ScrollController scrollController = ScrollController();

  bool _searchIsOpen = false;

  TextEditingController mycontroller = new TextEditingController();

  late String val;

  late String valueRecherche;

  String iconFiltre='assets/images/filtreD.png';

  @override
  void initState() {
    super.initState();

    //WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    final startDate = context.read<HomeBloc>().state.startDate;
    final endDate = context.read<HomeBloc>().state.endDate;
    List<SearchCriteriaGroup> ListsearchCriteriaGroup = [];
    ListsearchCriteriaGroup =
        UtilFunctions.formatSearchCriteria(startDate, endDate, "date", BlocProvider.of<DossieranalyseBloc>(context).state.recherche,BlocProvider.of<DossieranalyseBloc>(context).state.filtreDetails);
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        List<SearchCriteriaGroup> ListsearchCriteriaGroups;
        if (context.read<DossieranalyseBloc>().state.filtre == "recherche") {
          // add recherche criteria
          log("recherche log");
          log(valueRecherche);
          ListsearchCriteriaGroups = UtilFunctions.formatSearchCriteria(
              context.read<HomeBloc>().state.startDate,
              context.read<HomeBloc>().state.endDate,
              "recherche",
              valueRecherche,BlocProvider.of<DossieranalyseBloc>(context).state.filtreDetails);
        }
      else if (context.read<DossieranalyseBloc>().state.filtre ==
          "date") {
          ListsearchCriteriaGroups = UtilFunctions.formatSearchCriteria(
              context.read<HomeBloc>().state.startDate,
              context.read<HomeBloc>().state.endDate,
              "date",
              context.read<DossieranalyseBloc>().state.recherche,BlocProvider.of<DossieranalyseBloc>(context).state.filtreDetails);

      }
        else {
          ListsearchCriteriaGroups = UtilFunctions.formatSearchCriteria(
              context.read<HomeBloc>().state.startDate,
              context.read<HomeBloc>().state.endDate,
              context.read<DossieranalyseBloc>().state.filtre ,
              context.read<DossieranalyseBloc>().state.recherche,BlocProvider.of<DossieranalyseBloc>(context).state.filtreDetails);
        }

        context.read<DossieranalyseBloc>().add(LoadMoreDossiersEvent(
              ListsearchCriteriaGroups,
              context.read<HomeBloc>().state.startDate,
              context.read<HomeBloc>().state.endDate
            ));
      }
    });
    context
        .read<DossieranalyseBloc>()
        .add(LoadDossiersEvent("", "", ListsearchCriteriaGroup,BlocProvider.of<DossieranalyseBloc>(context).state.recherche,BlocProvider.of<DossieranalyseBloc>(context).state.valide,  "date",BlocProvider.of<DossieranalyseBloc>(context).state.filtreDetails));
    //.add(event)
    // .loadData(startDate, endDate, STATUT, ASC);
  }

  Widget buildBlocWidget() {
    return BlocBuilder<DossieranalyseBloc, DossieranalyseState>(
      builder: (context, state) {
        print(state);
        /*  if (state.isLoading) {
          return showLoadingIndicator();
        } else {

        }  */

        allDossierAnalyse = (state).dossiers;
        log("length");
        log(allDossierAnalyse.length.toString());
        return Expanded(
          child: ListView.builder(
            controller: scrollController,
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            padding: EdgeInsets.zero,
            //itemCount: allDossierAnalyse.length,
            itemCount: allDossierAnalyse.length,
            itemBuilder: (context, index) {
              if (index < allDossierAnalyse.length) {
                log("resultFlag");
                log( allDossierAnalyse[index].dossierAnalyse!.resultFlag.toString());
                return DossierItem(
                    allDossierAnalyse[index],
                    UtilFunctions.getColor(
                        allDossierAnalyse[index].dossierAnalyse!.resultFlag!,
                        allDossierAnalyse[index].dossierAnalyse!.statut!));
              } else {
                log("${state.isLoadingMore} no more data ");
                return Center(
                    child: state.isLoadingMore
                        ? const CircularProgressIndicator()
                        : const Text("no more data to load "));
              }
            },
          ),
        );
      },
    );
  }

  Widget showLoadingIndicator() {
    return const Center(
      child: CircularProgressIndicator(
        color: MyColors.lightGrey,
      ),
    );
  }

  Widget _buildAppBarTitle() {
    return const Text(
      'Liste des Dossiers',
      style: TextStyle(color: MyColors.grayClair),
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
    var dropdownValue;

    return
      Expanded(
      child: Column(children: [
        Container(
            height: 40.0,
            child: Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10),
                child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                          width: (MediaQuery.of(context).size.width * .54),
                          child: _searchIsOpen
                              ? TextField(
                                  controller: mycontroller,
                                  textAlignVertical: TextAlignVertical.bottom,
                                  enabled: _searchIsOpen,
                                  decoration: InputDecoration(
                                    suffixIcon: InkWell(
                                      child: _searchIsOpen
                                          ? Icon(Icons.cancel)
                                          : null,
                                      onTap: () {
                                        //refresh
                                        mycontroller.clear();
                                        List<SearchCriteriaGroup>
                                            ListsearchCriteriaGroup = [];
                                        ListsearchCriteriaGroup =
                                            UtilFunctions.formatSearchCriteria(
                                                context
                                                    .read<HomeBloc>()
                                                    .state
                                                    .startDate,
                                                context
                                                    .read<HomeBloc>()
                                                    .state
                                                    .endDate,
                                                "date",
                                                "",BlocProvider.of<DossieranalyseBloc>(context).state.filtreDetails);
                                        context.read<DossieranalyseBloc>().add(
                                            LoadDossiersEvent(
                                                "",
                                                "",
                                                ListsearchCriteriaGroup,BlocProvider.of<DossieranalyseBloc>(context).state.recherche,
                                                true,
                                                "date",BlocProvider.of<DossieranalyseBloc>(context).state.filtreDetails));
                                        final position = scrollController
                                            .position.minScrollExtent;
                                        scrollController.animateTo(
                                          //duration of scrolling up
                                          duration: Duration(milliseconds: 400),
                                          position,
                                          //animation style
                                          curve: Curves.linear,
                                        );
                                        setState(() {
                                          isSwitched=true;
                                          toggleSwitch;
                                        });
                                      },
                                    ),
                                    filled: true,
                                    fillColor: const Color(0xfff1f1f1),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: BorderSide.none,
                                    ),
                                    hintText: "Recherche",
                                    /* suffixIcon: InkWell(
                                onTap: (){

                                },
                                child: const Icon(Icons.search)),
                            // suffixIcon: const Icon(Icons.send_rounded),
                            suffixIconColor: Colors.black,

                            */
                                  ),
                                  onSubmitted: (value) {
                                    valueRecherche = value;
                                    log("{ ${BlocProvider.of<HomeBloc>(context).state.startDate}");
                                    var ListsearchCriteriaGroup =
                                        UtilFunctions.formatSearchCriteria(
                                            BlocProvider.of<HomeBloc>(context)
                                                .state
                                                .startDate,
                                            BlocProvider.of<HomeBloc>(context)
                                                .state
                                                .endDate,
                                            "recherche",
                                            value,BlocProvider.of<DossieranalyseBloc>(context).state.filtreDetails);

                                    context.read<DossieranalyseBloc>().add(
                                        LoadDossiersEvent(
                                            "",
                                            "",
                                            ListsearchCriteriaGroup,value,BlocProvider.of<DossieranalyseBloc>(context).state.valide,
                                            "recherche",BlocProvider.of<DossieranalyseBloc>(context).state.filtreDetails));
                                    final position = scrollController
                                        .position.minScrollExtent;
                                    scrollController.animateTo(
                                      //duration of scrolling up
                                      duration: Duration(milliseconds: 400),
                                      position,
                                      //animation style
                                      curve: Curves.linear,
                                    );
                                  },
                                )
                              : TextField(
                                  controller: mycontroller,
                                  textAlignVertical: TextAlignVertical.bottom,
                                  enabled: !_searchIsOpen,
                                  decoration: InputDecoration(
                                    suffixIcon: InkWell(
                                      child: _searchIsOpen
                                          ? Icon(Icons.cancel)
                                          : null,
                                    ),
                                    filled: true,
                                    fillColor: const Color(0xfff1f1f1),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: BorderSide.none,
                                    ),
                                    hintText: "Recherche",
                                  ),
                                  onTap: () {
                                    setState(() {
                                      _searchIsOpen = !_searchIsOpen;
                                    });
                                  },
                                )),
                      InkWell(
                        onTap: () {},
                        child: Icon(Icons.search),
                      )
                      /*  AnimatedContainer(
                        duration: const Duration(milliseconds: 500),
                        width: _searchIsOpen
                            ? (MediaQuery.of(context).size.width * .6)
                            :0,
                        child: TextField(
                          controller: mycontroller,
                          textAlignVertical: TextAlignVertical.bottom,
                      enabled: _searchIsOpen,
                          decoration: InputDecoration(
                            suffixIcon: InkWell(
                              child: _searchIsOpen ? Icon(Icons.cancel) : null,
                              onTap: () {
                                mycontroller.clear();
                              },
                            ),
                            filled: true,
                            fillColor: const Color(0xfff1f1f1),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide.none,
                            ),

                            hintText: "Recherche",
                            /* suffixIcon: InkWell(
                                onTap: (){

                                },
                                child: const Icon(Icons.search)),
                            // suffixIcon: const Icon(Icons.send_rounded),
                            suffixIconColor: Colors.black,

                            */
                          ),

                          onSubmitted: (value) {
                           // log(mycontroller.text);
                            log(value);
                            log("{ ${BlocProvider
                                .of<HomeBloc>(context)
                                .state
                                .startDate}");

                            List<SearchCriteriaGroup> ListsearchCriteriaGroup = [];
                            List<SearchCriteria> ListsearchCriteria = [];
                            List<SearchCriteria> ListsearchCriteriaNom = [];
                            final s1 = SearchCriteria(
                              key: "datePrelevement",
                              operation: ">",
                              orPredicate: false,
                              value: "${ BlocProvider
                                  .of<HomeBloc>(context)
                                  .state
                                  .startDate} 00:00:00",
                            );
                            final s2 = SearchCriteria(
                              key: "datePrelevement",
                              operation: "<",
                              orPredicate: false,
                              value: "${ BlocProvider
                                  .of<HomeBloc>(context)
                                  .state
                                  .endDate} 23:59:59",
                            );
                            final s3 = SearchCriteria(
                              key: "statut",
                              operation: "<",
                              orPredicate: false,
                              value: STATUT,
                            );
                            final s4 = SearchCriteria(
                              key: "patient.nom",
                              operation: "like",
                              orPredicate: false,
                              value: "%${value}%",
                            );
                            final s5 = SearchCriteria(
                              key: "patient.prenom",
                              operation: "like",
                              orPredicate: true,
                              value: "%${value}%",
                            );
                            ListsearchCriteria.add(s1);
                            ListsearchCriteria.add(s2);
                            ListsearchCriteria.add(s3);
                            ListsearchCriteriaNom.add(s4);
                            ListsearchCriteriaNom.add(s5);
                            final sg = SearchCriteriaGroup(orPredicate: false, searchCriterias: ListsearchCriteria);
                            final sg2 = SearchCriteriaGroup(orPredicate: false, searchCriterias: ListsearchCriteriaNom);
                            ListsearchCriteriaGroup.add(sg);
                            ListsearchCriteriaGroup.add(sg2);
                            context.read<DossieranalyseBloc>().add(LoadDossiersEvent(
                                BlocProvider
                                    .of<HomeBloc>(context)
                                    .state
                                    .startDate,
                                BlocProvider
                                    .of<HomeBloc>(context)
                                    .state
                                    .endDate,
                                STATUT,
                                ListsearchCriteriaGroup));


                          },
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            _searchIsOpen = !_searchIsOpen;
                          });
                        },
                        child: Icon(Icons.search),
                      )
                      */
                    ],
                  ),

                  //   IconButton(icon: Icon(Icons.search), onPressed: () {}),
                  /*     Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SearchAnchor(builder:
                        (BuildContext context, SearchController controller) {
                      return SearchBar(
                        controller: controller,
                        padding: const MaterialStatePropertyAll<EdgeInsets>(
                            EdgeInsets.symmetric(horizontal: 16.0)),
                        onTap: () {
                          controller.openView();
                        },
                        onChanged: (_) {
                          controller.openView();
                        },
                        leading: const Icon(Icons.search),
                      );
                    }, suggestionsBuilder:
                        (BuildContext context, SearchController controller) {
                      return List<ListTile>.generate(5, (int index) {
                        final String item = 'item $index';
                        return ListTile(
                          title: Text(item),
                          onTap: () {
                            setState(() {
                              controller.closeView(item);
                            });
                          },
                        );
                      });
                    }),
                  ),

*/
                  SizedBox(
                    width: 60,
                    height: 40,
                    child: FittedBox(
                      fit: BoxFit.fill,
                      child: Switch(
                        onChanged: toggleSwitch,
                        value: isSwitched,
                        activeTrackColor: MyColors.colorPrimary,
                      ),
                    ),
                  ),

                  Positioned(
                    top: 0,
                    right: 0,
                    child:
                    Container(
                      width: 50,
                       margin: EdgeInsets.symmetric(horizontal: 2,),
                        /*Container(
                      //width: 80,
                     // margin: EdgeInsets.symmetric(horizontal: 2,),
                      alignment: Alignment.bottomRight,
                      child: DropdownButton<String>(
                        value: dropdownValue,
                        icon: Icon(Icons.more_vert),
                        items: <String>[
                          'Complet',
                          'Non  ',
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child:


/*
                            RadioListTile<String>(
                              title: const Text('C'),
                              value: value,
                              groupValue: "chap1",
                              onChanged: (String? value) {
                                setState(() {
                                 // selectedAnswerChapterB = value!;
                                });
                              },
                            ),
                                  */


                            Text("$value"),

                          );
                           }).toList(),
                        onChanged: (String? value) {},
                      ),
                    ),
                    */
                       child: InkWell(
                            child: Image.asset(iconFiltre),
                            onTap: () {
                              /*
                              BlocProvider(
                                  create: (context) => FiltreBloc(),
                              child: showAlertDialog(context),
                              );
                              */
                              showAlertDialog(context);
                            }),
                  ),
                  ),
                ]))),
        OfflineBuilder(
          connectivityBuilder: (
            BuildContext context,
            ConnectivityResult connectivity,
            Widget child,
          ) {
            final bool connected = connectivity != ConnectivityResult.none;

            if (connected) {
              return BlocListener<HomeBloc, HomeState>(
                  listener: (context, value) {
                    List<SearchCriteriaGroup> ListsearchCriteriaGroup = [];

                    ListsearchCriteriaGroup =
                        UtilFunctions.formatSearchCriteria(
                            value.startDate, value.endDate, "date",  context.read<DossieranalyseBloc>().state.recherche,BlocProvider.of<DossieranalyseBloc>(context).state.filtreDetails);
                    context.read<DossieranalyseBloc>().add(LoadDossiersEvent(
                        "", "", ListsearchCriteriaGroup,BlocProvider.of<DossieranalyseBloc>(context).state.recherche,BlocProvider.of<DossieranalyseBloc>(context).state.valide, "date",BlocProvider.of<DossieranalyseBloc>(context).state.filtreDetails));
                    final position = scrollController.position.minScrollExtent;
                    scrollController.animateTo(
                      //duration of scrolling up
                      duration: Duration(milliseconds: 400),
                      position,
                      //animation style
                      curve: Curves.linear,
                    );
                  },
                  child: buildBlocWidget());

              /*
                  BlocListener<HomeBloc, HomeState>(
                    listener: (context, value) {
                      List<SearchCriteriaGroup> ListsearchCriteriaGroup = [];
                      List<SearchCriteria> ListsearchCriteria = [];
                      final s1 = SearchCriteria(
                        key: "datePrelevement",
                        operation: ">",
                        orPredicate: false,
                        value: "${value.startDate} 00:00:00",
                      );
                      final s2 = SearchCriteria(
                        key: "datePrelevement",
                        operation: "<",
                        orPredicate: false,
                        value: "${value.endDate} 23:59:59",
                      );
                      final s3 = SearchCriteria(
                        key: "statut",
                        operation: "<",
                        orPredicate: false,
                        value: STATUT,
                      );
                      ListsearchCriteria.add(s1);
                      ListsearchCriteria.add(s2);
                      ListsearchCriteria.add(s3);
                      final sg = SearchCriteriaGroup(
                          orPredicate: false,
                          searchCriterias: ListsearchCriteria);
                      ListsearchCriteriaGroup.add(sg);
                      context.read<DossieranalyseBloc>().add(LoadDossiersEvent(
                          value.startDate,
                          value.endDate,
                          STATUT,
                          ASC,
                          ListsearchCriteriaGroup));
                      //   DossieranalyseBloc(dossiersRepository)..add( LoadDossiersEvent(value.startDate, value.endDate,STATUT,ASC));
                    },

              );

           */
            } else {
              return buildNoInternetWidget();
            }
          },
          child: showLoadingIndicator(),
        ),
      ]),
    );
  }

  void toggleSwitch(bool value) {
    log(mycontroller.text.toString());
    if (isSwitched == true) {
      setState(() {
        isSwitched = false;
        textValue = 'Validé';

        List<SearchCriteriaGroup> ListsearchCriteriaGroup = [];
log("6666666666666");
log("6666 ${BlocProvider.of<DossieranalyseBloc>(context).state.filtreDetails}");
log("5555 ${BlocProvider.of<DossieranalyseBloc>(context).state.recherche}");
        ListsearchCriteriaGroup = UtilFunctions.formatSearchCriteria(
            BlocProvider.of<HomeBloc>(context).state.startDate,
            BlocProvider.of<HomeBloc>(context).state.endDate,
            "valide",
            BlocProvider.of<DossieranalyseBloc>(context).state.recherche,BlocProvider.of<DossieranalyseBloc>(context).state.filtreDetails);
        context.read<DossieranalyseBloc>().add(LoadDossiersEvent(
            BlocProvider.of<HomeBloc>(context).state.startDate,
            BlocProvider.of<HomeBloc>(context).state.endDate,
            ListsearchCriteriaGroup,
            BlocProvider.of<DossieranalyseBloc>(context).state.recherche,false,
            "valide",BlocProvider.of<DossieranalyseBloc>(context).state.filtreDetails));
        final position = scrollController.position.minScrollExtent;
        scrollController.animateTo(
          //duration of scrolling up
          duration: Duration(milliseconds: 400),
          position,
          //animation style
          curve: Curves.linear,
        );
      });
      print('Switch Button is ON');
      print(BlocProvider.of<HomeBloc>(context).state.startDate);
      print(BlocProvider.of<HomeBloc>(context).state.endDate);
    } else {
      print('Switch Button is OFF');
      print(BlocProvider.of<HomeBloc>(context).state.startDate);
      setState(() {
        isSwitched = true;
        textValue = 'Non Validé';
        List<SearchCriteriaGroup> ListsearchCriteriaGroup = [];

        ListsearchCriteriaGroup = UtilFunctions.formatSearchCriteria(
            BlocProvider.of<HomeBloc>(context).state.startDate,
            BlocProvider.of<HomeBloc>(context).state.endDate,
            "date",
            context.read<DossieranalyseBloc>().state.recherche,BlocProvider.of<DossieranalyseBloc>(context).state.filtreDetails);
        context
            .read<DossieranalyseBloc>()
            .add(LoadDossiersEvent("", "", ListsearchCriteriaGroup,BlocProvider.of<DossieranalyseBloc>(context).state.recherche,  true,"date",BlocProvider.of<DossieranalyseBloc>(context).state.filtreDetails));
        final position = scrollController.position.minScrollExtent;
        scrollController.animateTo(
          //duration of scrolling up
          duration: Duration(milliseconds: 400),
          position,
          //animation style
          curve: Curves.linear,
        );
      });
    }
  }

  showAlertDialog(BuildContext contextt) {
    // show the dialog

    showDialog(
        context: contextt,
        builder: (BuildContext context2) {
          // if(2==2 ){

          return BlocProvider.value(
            value: BlocProvider.of<DossieranalyseBloc>(context),
            child: BlocBuilder<DossieranalyseBloc, DossieranalyseState>(
              builder: (contextb, state) {
                /* final state = context
                          .watch<DossieranalyseBloc>()
                          .state; */
                log('[alert_dialog] state $state');
                /* if (!state.isLoading) {
                    Navigator.pop(context);
                  }
                  */
                var result = "complet";
                var selectedOption = 1;
                return  BlocProvider.value(
                    value: BlocProvider.of<FiltreBloc>(context),
                child:
                BlocConsumer<FiltreBloc, FiltreState>(
                  listener: (context, state) {},
                  //BlocBuilder<FiltreBloc, FiltreState>(
                  builder: (contextf, state) {
                    List<SearchCriteriaGroup> ListsearchCriteriaGroup;
                    double position;
                    String filtreDetails="";
                    return AlertDialog(
                        title: Text(
                          "Filtre:",
                          style: TextStyle(color: Colors.black, fontSize: 18),
                        ),
                        content:
                            Column(
                        mainAxisSize: MainAxisSize.min,
                              children: [
                                Row(
                                  children: [
                                    Checkbox(

                                        value: context.read<FiltreBloc>().state.tabIndexC,
                                        onChanged: (value) {
                                          BlocProvider.of<FiltreBloc>(context)
                                              .add(IndexChangeC(tabIndexC: !context.read<FiltreBloc>().state.tabIndexC));

                                        },

                                    ),
                                    Text('Complet',style: TextStyle(color: Colors.black, fontSize: 18)),

                                  ],
                                ),
                                Row(
                                  children: [
                                    Checkbox(

                                      value: context.read<FiltreBloc>().state.tabIndexR,
                                      //  context.read<FiltreBloc>().state.tabIndexC,
                                      onChanged: (value) {
                                        BlocProvider.of<FiltreBloc>(context)
                                            .add(IndexChangeR(tabIndexR: !context.read<FiltreBloc>().state.tabIndexR));

                                      },

                                    ),
                                    Text('Réglé',style: TextStyle(color: Colors.black, fontSize: 18),),

                                  ],
                                ),
                                Row(
                                  children: [
                                    Checkbox(

                                      value: context.read<FiltreBloc>().state.tabIndexH,
                                      //  context.read<FiltreBloc>().state.tabIndexH,
                                      onChanged: (value) {
                                        BlocProvider.of<FiltreBloc>(context)
                                            .add(IndexChangeH(tabIndexH: !context.read<FiltreBloc>().state.tabIndexH));

                                      },

                                    ),
                                    Text('Hors normes',style: TextStyle(color: Colors.black, fontSize: 18)),

                                  ],
                                ),
                           /*
                        RadioListTile(
                          title: Text(
                                'Non',
                              ),

                                value:  2 ,
                                groupValue:  context.read<FiltreBloc>().state.tabIndexC,
                                onChanged: (value) {

                                  BlocProvider.of<FiltreBloc>(context)
                                      .add(IndexChangeC(tabIndexC: 2 ?? 0));

                                },

                            ),
                            const Text(
                              "Dossier réglé",
                              style: TextStyle(color: Colors.black, fontSize: 18),
                            ),
                            RadioListTile(
                              title:  Text(
                                'Oui',
                              ),
                                value: 1,
                                groupValue: context.read<FiltreBloc>().state.tabIndexR,
                                onChanged: (_) {
                                  BlocProvider.of<FiltreBloc>(context)
                                      .add(IndexChangeR(tabIndexR: 1 ?? 0));
                                },
                            ),
                        RadioListTile(
                          title:  Text(
                                'Non',
                              ),
                                value: 2,
                                groupValue: context.read<FiltreBloc>().state.tabIndexR,
                                onChanged: (_) {
                                  BlocProvider.of<FiltreBloc>(context)
                                      .add(IndexChangeR(tabIndexR: 2 ?? 0));
                                },

                            ),
                          */
                                  ]),
                        actions: [
                          TextButton(
                            // textColor: Colors.purple,
                            onPressed: () => {
                              if(isSwitched==false){
                                log("non valide  gris annuler filtre "),

                       ListsearchCriteriaGroup = [],

                      ListsearchCriteriaGroup = UtilFunctions.formatSearchCriteria(
                          BlocProvider.of<HomeBloc>(context).state.startDate,
                          BlocProvider.of<HomeBloc>(context).state.endDate,
                          "valide",
                          context.read<DossieranalyseBloc>().state.recherche,""),
                      context.read<DossieranalyseBloc>().add(LoadDossiersEvent(
                          BlocProvider.of<HomeBloc>(context).state.startDate,
                          BlocProvider.of<HomeBloc>(context).state.endDate,
                          ListsearchCriteriaGroup,BlocProvider.of<DossieranalyseBloc>(context).state.recherche,
                          BlocProvider.of<DossieranalyseBloc>(context).state.valide,"valide","")),

                              }else
                                {
                                  ListsearchCriteriaGroup = [],
                                  ListsearchCriteriaGroup =
                                      UtilFunctions.formatSearchCriteria(
                                          context
                                              .read<HomeBloc>()
                                              .state
                                              .startDate,
                                          context
                                              .read<HomeBloc>()
                                              .state
                                              .endDate,
                                          "date",
                                          context.read<DossieranalyseBloc>().state.recherche,""),
                                  context.read<DossieranalyseBloc>().add(
                                      LoadDossiersEvent(
                                          "",
                                          "",
                                          ListsearchCriteriaGroup,BlocProvider.of<DossieranalyseBloc>(context).state.recherche,
                                          BlocProvider.of<DossieranalyseBloc>(context).state.valide,"date","")),
                                },
                         position = scrollController
                            .position.minScrollExtent,
                        scrollController.animateTo(
                          //duration of scrolling up
                          duration: Duration(milliseconds: 400),
                          position,
                          //animation style
                          curve: Curves.linear,
                        ),
                      BlocProvider.of<FiltreBloc>(context)
                          .add(IndexReset()),
                              setState(() {
                                iconFiltre='assets/images/filtreD.png';
                              }),

                              Navigator.pop(context)},
                            child: const Text('Annuler'),
                          ),
                          TextButton(
                            // textColor: Colors.purple,
                            onPressed: () => {
                              if(context.read<FiltreBloc>().state.tabIndexC==1||context.read<FiltreBloc>().state.tabIndexC)
                                {
                                  if(context.read<FiltreBloc>().state.tabIndexR==1||context.read<FiltreBloc>().state.tabIndexR)
                                {
                                  if(context.read<FiltreBloc>().state.tabIndexH==1||context.read<FiltreBloc>().state.tabIndexH)
                                  {
                                filtreDetails="completEtregléetHN",

                                //oui oui oui
                                }else{
                                    filtreDetails="completEtreglé",

                                    //oui oui non
                                  }

                                    }else
                                    {
                                      if(context.read<FiltreBloc>().state.tabIndexH==1||context.read<FiltreBloc>().state.tabIndexH)
                                        {
                                          filtreDetails="completetHNetnonreglé",

                                          //oui oui oui
                                        }else{
                                        filtreDetails="complet",

                                        //oui non non
                                      }

                                    }

                                }else{
                                if(context.read<FiltreBloc>().state.tabIndexR==1||context.read<FiltreBloc>().state.tabIndexR)
                                {if(context.read<FiltreBloc>().state.tabIndexH==1||context.read<FiltreBloc>().state.tabIndexH)
                                  {
                                    filtreDetails="regléEtHNetnoncomplet",

                                    //non oui oui
                                  }else{
                                    filtreDetails="reglé"
                                    //non oui non
                                  }
                                }else
                                {
                                  if(context.read<FiltreBloc>().state.tabIndexH==1||context.read<FiltreBloc>().state.tabIndexH)
                                    {
                                      filtreDetails="ncomplteEtnreglé",

                                      //non non oui
                                    }else{
                                    filtreDetails="ncomplteEtnregléEtnHN"
                                    //non non non
                                  }
                                },
                                },
                              if(isSwitched==false)
                                {
                                  ListsearchCriteriaGroup = [],

                                  ListsearchCriteriaGroup = UtilFunctions.formatSearchCriteria(
                                      BlocProvider.of<HomeBloc>(context).state.startDate,
                                      BlocProvider.of<HomeBloc>(context).state.endDate,
                                      "valide",
                                      context.read<DossieranalyseBloc>().state.recherche,filtreDetails),
                                  context.read<DossieranalyseBloc>().add(LoadDossiersEvent(
                                      BlocProvider.of<HomeBloc>(context).state.startDate,
                                      BlocProvider.of<HomeBloc>(context).state.endDate,
                                      ListsearchCriteriaGroup,BlocProvider.of<DossieranalyseBloc>(context).state.recherche,
                                      BlocProvider.of<DossieranalyseBloc>(context).state.valide,"valide",filtreDetails)),

                                }
                              else{



                    ListsearchCriteriaGroup =
                    UtilFunctions.formatSearchCriteria(
                    BlocProvider.of<HomeBloc>(context)
                        .state
                        .startDate,
                    BlocProvider.of<HomeBloc>(context)
                        .state
                        .endDate,
                    "date",
                    "",filtreDetails),
                    context.read<DossieranalyseBloc>().add(
                    LoadDossiersEvent(
                        BlocProvider.of<HomeBloc>(context).state.startDate,
                        BlocProvider.of<HomeBloc>(context).state.endDate,
                    ListsearchCriteriaGroup,
                        BlocProvider.of<DossieranalyseBloc>(context).state.recherche,
                        BlocProvider.of<DossieranalyseBloc>(context).state.valide,"date",filtreDetails)),


                    },
                       position = scrollController
                          .position.minScrollExtent,
                      scrollController.animateTo(
                      //duration of scrolling up
                      duration: Duration(milliseconds: 400),
                      position,
                      //animation style
                      curve: Curves.linear,
                      ),
                              setState(() {
                    iconFiltre='assets/images/filtre.png';
                              }),

                              Navigator.pop(context),

                            },
                            child: const Text('Appliquer'),
                          ),
                        ],


                    );
                  },
                ),
                );
              },
            ),
          );
        });
  }
}
