import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';

import '../../app/constants/my_colors.dart';
import '../../app/constants/strings/strings.dart';
import '../../app/util/util_functions.dart';
import '../../business_logic/dossier_bloc/dossieranalyse_bloc.dart';
import '../../business_logic/landing_bloc/landing_bloc.dart';
import '../../data/models/dossier_analyse_model.dart';
import '../../data/repository/dossier_repository.dart';
import '../../data/web_services/dossier_web_services.dart';
import '../widgets/home_page_item.dart';

class DHomeScreen2 extends StatefulWidget {
  const DHomeScreen2({Key? key}) : super(key: key);

  @override
  State<DHomeScreen2> createState() => _DHomeScreen2State();
}

class _DHomeScreen2State extends State<DHomeScreen2> {
  late List<DossierAnalyse> allDossierAnalyse;
  final _searchTextController = TextEditingController();
  DossierAnalyseRepository dossiersRepository =
      DossierAnalyseRepository(DossierWebService());
  bool _isSearching = false;
final currentDate = "${DateTime.now().year-4}/${DateTime.now().month}/${DateTime.now().day}";
final currentDateF = "${DateTime.now().year}/${DateTime.now().month}/${DateTime.now().day}";
  bool isSwitched = false;
  var textValue = 'Non validé';

  bool verifApi = true;

  Widget _buildSearchField() {
    return TextField(
      controller: _searchTextController,
      cursorColor: MyColors.grayClair,
      decoration: const InputDecoration(
        hintText: 'Recherche',
        border: InputBorder.none,
        hintStyle: TextStyle(color: MyColors.grayClair, fontSize: 18),
      ),
      style: const TextStyle(color: MyColors.grayClair, fontSize: 18),
      onChanged: (searchedCharacter) {
        // addSearchedFOrItemsToSearchedList(searchedCharacter);
      },
    );
  }

  List<Widget> _buildAppBarActions() {
    if (_isSearching) {
      return [
        IconButton(
          onPressed: () {
            _clearSearch();
            // pop
            Navigator.pop(context);
          },
          icon: Icon(Icons.clear, color: MyColors.lightGrey),
        ),
      ];
    } else {
      return [
        IconButton(
          onPressed: _startSearch,
          icon: const Icon(
            Icons.search,
            color: MyColors.lightGrey,
          ),
        ),
      ];
    }
  }

  void _startSearch() {
    ModalRoute.of(context)!
        .addLocalHistoryEntry(LocalHistoryEntry(onRemove: _stopSearching));

    setState(() {
      _isSearching = true;
    });
  }

  void _stopSearching() {
    _clearSearch();

    setState(() {
      _isSearching = false;
    });
  }

  void _clearSearch() {
    setState(() {
      _searchTextController.clear();
    });
  }

  @override
  void initState() {
    super.initState();

    /*
                          BlocProvider<DossieranalyseBloc>(
                  create: (BuildContext context) =>
                      DossieranalyseBloc(dossiersRepository),
                  child: BlocListener<LandingBloc, LandingState>(
                      listener: (context, value) {
                        context.read<DossieranalyseBloc>().add(LoadDossiersEvent(
                            currentDate, currentDate, STATUT, ASC));    
                                },
                      child: buildBlocWidget()));
                        */
    //BlocProvider.of<DossieranalyseBloc>(context).dossiers;
    //call    BlocProvider.of<CubitCubit>(context).getAllDossiers();
  }

  Widget buildBlocWidget() {
    return BlocBuilder<DossieranalyseBloc, DossieranalyseState>(
        builder: (context, state) {
      print(state);

      if (state is DossieranalyseLoaded) {
        // allDossierAnalyse = (state).dossiers;
        allDossierAnalyse = (state).dossiers;
        log('dossier: ${state.dossiers.length}');

        print('dossier: ${state.dossiers.length}');
        return buildLoadedListWidgets();
      } else {
        return showLoadingIndicator();
      }
    });
  }

  Widget showLoadingIndicator() {
    return const Center(
      child: CircularProgressIndicator(
        color: MyColors.lightGrey,
      ),
    );
  }

  Widget buildDossiersList() {
    return  Expanded (
      child:
    ListView.builder(
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),      
      padding: EdgeInsets.zero,
      itemCount: allDossierAnalyse.length,
      itemBuilder: (context, index) {
        return DossierItem(
            allDossierAnalyse[index],
            UtilFunctions.getColor(allDossierAnalyse[index].resultFlag!,
                allDossierAnalyse[index].statut!));
      },
    ),
    );
  }

  Widget buildLoadedListWidgets() {
    return 

        buildDossiersList();
      
    
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
    return
      BlocConsumer<DossieranalyseBloc, DossieranalyseState>(
          listener: (context, state) {},
          builder: (context, state) {
            return
       Expanded(
         child: Column(children: [
          Container(
              height: 40.0,
               
         
              child: Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20),
                  child: Row(children: [
                    Switch(
                      onChanged: toggleSwitch,
                      value: isSwitched,
                      activeTrackColor: MyColors.colorPrimary,
                    ),
                    Container(
                        color: Colors
                            .black, // constraints: BoxConstraints( maxWidth: 250),
               
                        child: Text("ddggfj")
               
                        //   IconButton(icon: Icon(Icons.search), onPressed: () {}),
               
                        ),
               
                    Container(
                      padding: const EdgeInsets.only(left: 2, right: 2),
                      alignment: Alignment.centerRight,
                      child:
                          IconButton(icon: Icon(Icons.more_vert), onPressed: () {}),
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
                return BlocProvider<DossieranalyseBloc>(
                    create: (BuildContext context) =>
                        DossieranalyseBloc(dossiersRepository),
                    child: BlocListener<LandingBloc, LandingState>(
                        listener: (context, value) {
                          context.read<DossieranalyseBloc>().add(LoadDossiersEvent(
                              value.startDate, value.endDate, STATUT, ASC));
               
               //      DossieranalyseBloc(dossiersRepository)..add( LoadDossiersEvent(value.startDate, value.endDate,STATUT,ASC));
                        },
                        child: buildBlocWidget()));
              } else {
                return buildNoInternetWidget();
              }
            },
            child: showLoadingIndicator(),
          ),
               ]),
       )
    ;
  } );
  }

  Widget bottomTabBar() {
    return BottomAppBar(
      child: Row(
        children: [
          IconButton(icon: Icon(Icons.home), onPressed: () {}),

          //SizedBox(       width: 30, ),
          IconButton(icon: Icon(Icons.dashboard), onPressed: () {}),

          //Spacer(),
          IconButton(icon: Icon(Icons.paid), onPressed: () {}),

          //Spacer(),
          //IconButton(icon: Icon(Icons.settings), onPressed: () {}),
        ],
      ),
    );
  }

  void toggleSwitch(bool value) {
    if (isSwitched == false) {
      setState(() {
        isSwitched = true;
        textValue = 'Validé';
      });
      print('Switch Button is ON');
    } else {
      setState(() {
        isSwitched = false;
        textValue = 'Non Validé';
      });
    }
  }
}
