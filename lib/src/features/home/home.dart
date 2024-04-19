/*
import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';

import '../../app/constants/my_colors.dart';
import '../../app/constants/strings/strings.dart';
import '../../app/util/util_functions.dart';
import '../../business_logic/dossier_bloc/dossieranalyse_bloc.dart';

import '../../data/models/dossier_analyse_model.dart';
import '../../data/repository/dossier_repository.dart';
import '../../data/web_services/dossier_web_services.dart';
import '../widgets/home_page_item.dart';

@RoutePage()
class DossierScreeens extends StatefulWidget {
  const DossierScreeens({Key? key}) : super(key: key);

  @override
  State<DossierScreeens> createState() => _DossierScreeensState();
}

class _DossierScreeensState extends State<DossierScreeens> {
  late List<DossierAnalyse> allDossierAnalyse;
  final _searchTextController = TextEditingController();
  DossierAnalyseRepository dossiersRepository =
      DossierAnalyseRepository(DossierWebService());
  bool _isSearching = false;

  bool isSwitched = false;
  var textValue = 'Non validé';
  DateTime dateDeb =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  DateTime noww = DateTime.now();
  DateTime dateDFin =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

  bool verifApi=true;

  Widget _buildSearchField() {
    return TextField(
      controller: _searchTextController,
      cursorColor: MyColors.grayClair,
      decoration: InputDecoration(
        hintText: 'Recherche',
        border: InputBorder.none,
        hintStyle: TextStyle(color: MyColors.grayClair, fontSize: 18),
      ),
      style: TextStyle(color: MyColors.grayClair, fontSize: 18),
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
          icon: Icon(
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
    //BlocProvider.of<DossieranalyseBloc>(context).dossiers;
    //call    BlocProvider.of<CubitCubit>(context).getAllDossiers();
  }

  Widget buildBlocWidget() { 
    return BlocBuilder<DossieranalyseBloc, DossieranalyseState>(
        builder: (context, state) {
   
    if (state is DossieranalyseInitial) {
        // allDossierAnalyse = (state).dossiers;
        allDossierAnalyse = (state).dossiers;
        return buildLoadedListWidgets();
      } else {
        return showLoadingIndicator();
       
      } 
    });   
    
        
   
    /*
    return BlocBuilder<CubitCubit, CubitState>(
        //return BlocBuilder<DossieranalyseBloc, DossieranalyseState>(
        builder: (context, state) {
      //if (state is DossieranalyseLoaded) {
      if (state is DossiersLoaded){
       // allDossierAnalyse = (state).dossiers;
        allDossierAnalyse=(state).dossiers;
        return buildLoadedListWidgets();
      } else {
        return showLoadingIndicator();
      }
    });
    */
  }

  Widget showLoadingIndicator() {
    return Center(
      child: CircularProgressIndicator(
        color: MyColors.lightGrey,
      ),
    );
  }

  Widget buildLoadedListWidgets() {
    return SingleChildScrollView(
      child: Container(
        child: Column(children: [
          buildDossiersList(),
        ]),
      ),
    );
  }

/*
      itemCount: _searchTextController.text.isEmpty
          ? allCharacters.length
          : searchedForCharacters.length,
      itemBuilder: (ctx, index) {
        return CharacterItem(
          character: _searchTextController.text.isEmpty
              ? allCharacters[index]
              : searchedForCharacters[index],
              */
  Widget buildDossiersList() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      padding: EdgeInsets.zero,
      itemCount: allDossierAnalyse.length,
      itemBuilder: (context, index) {
        return DossierItem(
           allDossierAnalyse[index], UtilFunctions.getColor(allDossierAnalyse[index].resultFlag!,allDossierAnalyse[index].statut!)

        );
      },
    );
  }

  Widget _buildAppBarTitle() {
    return Text(
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
            SizedBox(
              height: 20,
            ),
            Text(
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

  List<BottomNavigationBarItem> bottomNavItems =
      const <BottomNavigationBarItem>[
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
  @override
  Widget build(BuildContext context) {
    var forAndroid = TargetPlatform.android;

    return DefaultTabController(
      // Added
      length: 4, // Added
      initialIndex: 0, //Added
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: MyColors.colorPrimary,
          leading: _isSearching
              ? BackButton(
                  color: MyColors.grayClair,
                )
              : Container(),
          title: _isSearching ? _buildSearchField() : _buildAppBarTitle(),
          actions: _buildAppBarActions(),
          scrolledUnderElevation: 4.0,

          /*  bottom: const TabBar(
          tabs: <Widget>[
            Tab(
              icon: Icon(Icons.cloud_outlined),
              text: "ghh",
            ),
            Tab(
              icon: Icon(Icons.beach_access_sharp),
              text: "aaa",
            ),
            Tab(
              icon: Icon(Icons.brightness_5_sharp),
              text: "bbb",
            ),
          ],
        ),*/
        ),
        //drawer: sideDrawer(context),  // Passed BuildContext in function.
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: MyColors.colorPrimary,
          selectedFontSize: 18,
          unselectedFontSize: 14,
          items: bottomNavItems,
          // currentIndex: state.tabIndex,
          unselectedItemColor: Colors.grey,
          onTap: (index) {
            // BlocProvider.of<LandingPageBloc>(context).add(TabChange(tabIndex: index));
          },
        ),
        body: DHomeScreen(),
        //bottomNavScreen.elementAt(state.tabIndex),
      ),
    );
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

  Widget DHomeScreen() {
    return new Column(children: [
      new Container(
        height: 40.0,

        //color: Colors.black,
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20),
          child: Row(children: [
            Text("Date"),
            SizedBox(width: 20),
            InkWell(
              onTap: () async {
    DateTime? newDate = await showDatePicker(
    context: context,
    initialDate:dateDeb,
    firstDate: DateTime(1950),
    lastDate:
    DateTime(dateDFin.year, dateDFin.month, dateDFin.day),
    );
    if (newDate == null) return;
    setState(() => dateDeb = newDate);
    final difference = dateDFin.difference(dateDeb);
    // 16591
    if (difference.inDays>7)
    {
    print("intervaaaaallll grand ${difference.inDays}");
    //showAlertDialog();
    showAlertDialog(context);
    }
    if(verifApi){
      print("kkkkkkkkkkkk");
    //APIDATE
    String convertedDateDeb =
    "${dateDeb.year.toString()}/${dateDeb.month.toString()
        .padLeft(2, '0')}/${dateDeb.day.toString().padLeft(
    2, '0')}";
    String convertedDateFin =
    "${dateDFin.year.toString()}/${dateDFin.month.toString()
        .padLeft(2, '0')}/${dateDFin.day.toString().padLeft(
    2, '0')}";
/*
    DossieranalyseBloc(dossiersRepository)
    ..add(LoadDossiersEvent(
    convertedDateDeb, convertedDateFin, STATUT, ASC));
    */
    BlocProvider.of<DossieranalyseBloc>(context).add(
    LoadDossiersEvent(
    convertedDateDeb, convertedDateFin, STATUT, ASC));
    }
              },

              child: new Text(
                "${dateDeb.year}/${dateDeb.month}/${dateDeb.day}",
                style: TextStyle(color: Colors.black, fontSize: 25),
              ),
            ),
            SizedBox(width: 20),
            Text("au"),
            SizedBox(width: 20),
            InkWell(
              onTap: () async {
                DateTime? newDate = await showDatePicker(
                  context: context,
                  initialDate: dateDFin,
                  firstDate: DateTime(dateDeb.year, dateDeb.month, dateDeb.day),
                  lastDate: new DateTime(2200),
                );
                if (newDate == null) return;
                setState(() => dateDFin = newDate);
                final difference = dateDFin.difference(dateDeb);
                // 16591
                if (difference.inDays>7)
                {
                  print("intervaaaaallll grand ${difference.inDays}");
                  //showAlertDialog();
                  showAlertDialog(context);
                }
                if(verifApi){
                  print("kkkkkkkkkkkk");
                //APIDATE
                String convertedDateDeb = UtilFunctions.getFormatDate(dateDeb);
               String convertedDateFin =UtilFunctions.getFormatDate(dateDFin);

                BlocProvider.of<DossieranalyseBloc>(context).add(
                    LoadDossiersEvent(
                        convertedDateDeb, convertedDateFin, STATUT, ASC));
              };
},
              child: new Text(
                "${dateDFin.year}/${dateDFin.month}/${dateDFin.day}",
                style: TextStyle(color: Colors.black, fontSize: 25),
              ),
            ),
          ]),
        ),
      ),
      new Container(
          height: 40.0,

// color: Colors.black,
          child: Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20),
              child: Row(children: [
                Switch(
                  onChanged: toggleSwitch,
                  value: isSwitched,
                  activeTrackColor: MyColors.colorPrimary,
                ),
//SText('$textValue', style: TextStyle(fontSize: 20),),
                SizedBox(
                  width: 200,
                ),
                IconButton(icon: Icon(Icons.search), onPressed: () {}),
                SizedBox(
                  width: 10,
                ),
                IconButton(icon: Icon(Icons.more_vert), onPressed: () {}),
              ]))),
      OfflineBuilder(
        connectivityBuilder: (
          BuildContext context,
          ConnectivityResult connectivity,
          Widget child,
        ) {
          final bool connected = connectivity != ConnectivityResult.none;

          if (connected) {
            return buildBlocWidget();
          } else {
            return buildNoInternetWidget();
          }
        },
        child: showLoadingIndicator(),
      ),
    ]);
  }

  Widget ReglementScreen() {
    return new Container(
      child: Text("Reglement"),
    );
  }

   showAlertDialog(BuildContext context) {
     late   Widget okButton ;
     late   AlertDialog alert;
     late Widget cancelButton;
     return {

     // set up the button
        okButton = TextButton(
     child: Text("OK"),
     onPressed: () {
       Navigator.of(context).pop();
     },
     ),
     // set up the buttons
   /*   cancelButton = TextButton(
     child: Text("Cancel"),
     onPressed:  () {Navigator.of(context).pop();
     verifApi=false;
       },
     ),
*/

     // set up the AlertDialog
      alert = AlertDialog(
       title: Text("Peut prondre beaucoup de temps"),
       content: Text("Date  supérieur à une semaine"),
        actions: [
          //cancelButton,
          okButton,
        ],
     ),

     // show the dialog
     showDialog(
       context: context,
       builder: (BuildContext context) {
         return alert;
       },
     ),
   };


     }
}
*/