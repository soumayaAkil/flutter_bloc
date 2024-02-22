import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../app/constants/my_colors.dart';
import '../../app/util/util_functions.dart';
import '../../business_logic/landing_bloc/landing_bloc.dart';
import '../../data/models/dossier_analyse_model.dart';
import '../../data/repository/dossier_repository.dart';
import '../../data/web_services/dossier_web_services.dart';
import 'dossier_screen.dart';

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
  const DHomeScreen2(),
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
  late List<DossierAnalyse> allDossierAnalyse;
  final _searchTextController = TextEditingController();
  DossierAnalyseRepository dossiersRepository =
      DossierAnalyseRepository(DossierWebService());

  DateTime dateDeb =
      DateTime(DateTime.now().year-2, DateTime.now().month, DateTime.now().day);

  DateTime dateDFin =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

  bool _isSearching = false;

  var textValue = 'Non validé';

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
          icon: const Icon(Icons.clear, color: MyColors.lightGrey),
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
    var forAndroid = TargetPlatform.android;
    return BlocConsumer<LandingBloc, LandingState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: MyColors.colorPrimary,
            leading: _isSearching
                ? const BackButton(
                    color: MyColors.grayClair,
                  )
                : Container(),
            title: _isSearching ? _buildSearchField() : _buildAppBarTitle(),
            actions: _buildAppBarActions(),
            scrolledUnderElevation: 4.0,
          ),
          body: Column(
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
                              final difference = dateDFin.difference(dateDeb);
                              // 16591
                              if (difference.inDays > 7) {
                                print(
                                    "intervaaaaallll grand ${difference.inDays}");

                               showAlertDialog(context);
                              }
                              //APIDATE
                              String convertedDateDeb =
                                  UtilFunctions.getFormatDate(dateDeb);
                              BlocProvider.of<LandingBloc>(context)
                                  .add(StartDateChange(date: convertedDateDeb));
                            },
                            child: Text(
                              "${dateDeb.day}/${dateDeb.month}/${dateDeb.year}",
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
                                    dateDeb.year, dateDeb.month, dateDeb.day),
                                lastDate: new DateTime(2200),
                              );
                              if (newDate == null) return;
                              setState(() => dateDFin = newDate);
                              final difference = dateDFin.difference(dateDeb);
                              // 16591
                              if (difference.inDays > 7) {
                                print(
                                    "intervaaaaallll grand ${difference.inDays}");

                                showAlertDialog(context);
                              }

                              //APIDATE
                              String convertedDateFin =
                                  UtilFunctions.getFormatDate(dateDFin);

                              BlocProvider.of<LandingBloc>(context)
                                  .add(EndDateChange(date: convertedDateFin));

/*
                          BlocProvider.of<DossieranalyseBloc>(context).add(
                              LoadDossiersEvent(
                                  convertedDateDeb, convertedDateFin, STATUT, ASC));
                          */
                            },
                            child: Text(
                              "${dateDFin.day}/${dateDFin.month}/${dateDFin.year}",
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
          bottomNavigationBar: BottomNavigationBar(
            items: bottomNavItems,
            currentIndex: state.tabIndex,
            selectedItemColor: Theme.of(context).colorScheme.primary,
            unselectedItemColor: Colors.grey,
            onTap: (index) {
              BlocProvider.of<LandingBloc>(context)
                  .add(TabChange(tabIndex: index));
            },
          ),
        );
      },
    );
  }

  showAlertDialog(BuildContext context) {
    late AlertDialog alert;
    return {
      alert = AlertDialog(
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
      ),

      // show the dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          Future.delayed(const Duration(milliseconds: 800), () {
            Navigator.of(context).pop(true);
          });
          return alert;
        },
      ),
    };
  }
}
