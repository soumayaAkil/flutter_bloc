import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prolab_mobile/src/features/tableau_de_bord/bloc/stat_bloc.dart';
//import 'package:fl_chart/fl_chart.dart';
import '../../../core/constants/my_colors.dart';
import '../../../data/models/stat_model.dart';
import '../../../data/repository/dossier_repository.dart';
import '../../../data/web_services/dossier_web_services.dart';
import '../dossier_analyse/dossier_bloc/dossieranalyse_bloc.dart';
import '../dossier_detail/flitre_bloc/filtre_bloc.dart';
import '../home/home_bloc/home_bloc.dart';
import '../home/home_page.dart';
import '../reglement/bloc/reglement_bloc.dart';
import 'package:fl_chart/fl_chart.dart';

class TableauBordScreen extends StatefulWidget {
  const TableauBordScreen({
    super.key,
  });
  @override
  _TableauBordState createState() => _TableauBordState();
}

class _TableauBordState extends State<TableauBordScreen> {
  late StatDao statDossier;
  _TableauBordState();

  @override
  void initState() {
    context.read<StatBloc>().add(LoadStat(
          context.read<HomeBloc>().state.startDate,
          context.read<HomeBloc>().state.endDate,
        ));

    super.initState();
  }
  int touchedIndex = 0;
  @override
  Widget build(BuildContext context) {
    ScrollController scrollController = ScrollController();
    return  BlocListener<HomeBloc, HomeState>(
      listener: (context, value) {
        context.read<StatBloc>().add(LoadStat(
              context.read<HomeBloc>().state.startDate,
              context.read<HomeBloc>().state.endDate,
            ));

        final position = scrollController.position.minScrollExtent;
        scrollController.animateTo(
          //duration of scrolling up
          duration: Duration(milliseconds: 400),
          position,
          //animation style
          curve: Curves.linear,
        );
      },
      child: BlocBuilder<StatBloc, StatState>(builder: (context, state) {
        if ((state).statDao != null) {
          statDossier = (state).statDao!;

          return Expanded(
            child: SingleChildScrollView(
              primary: true,
                child: Column(children: [

              Container(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    Text("Etat Dossiers"),
                    AspectRatio(
                      aspectRatio: 1.3,
                      child: Row(
                        children: <Widget>[
                          const SizedBox(
                            height: 18,
                          ),
                          Expanded(
                            child: AspectRatio(
                              aspectRatio: 1,
                              child: PieChart(
                                PieChartData(
                                  pieTouchData: PieTouchData(
                                    touchCallback: (pieTouchResponse)
                                    //(FlTouchEvent event, pieTouchResponse)
                                    {
                                      setState(() {
                                        if (pieTouchResponse == null ||
                                            pieTouchResponse.touchedSection == null) {
                                          touchedIndex = -1;
                                          return;
                                        }
                                        touchedIndex = pieTouchResponse
                                            .touchedSection!.touchedSectionIndex;
                                      });
                                    },
                                  ),
                                  borderData: FlBorderData(
                                    show: false,
                                  ),
                                  sectionsSpace: 0,
                                  centerSpaceRadius: 40,
                                  sections: showingSections(),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            alignment: Alignment.center,
                            child: const Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Indicator(
                                  color: Colors.lightBlueAccent,
                                  text: 'Validés',
                                  isSquare: false,
                                ),
                                SizedBox(
                                  height: 4,
                                ),
                                Indicator(
                                  color: Colors.amber,
                                  text: 'Terminés',
                                  isSquare: false,
                                ),
                                SizedBox(
                                  height: 4,
                                ),
                                Indicator(
                                  color: Colors.purpleAccent,
                                  text: 'En Cours',
                                  isSquare: false,
                                ),
                                SizedBox(
                                  height: 4,
                                ),
                                Indicator(
                                  color: Colors.green,
                                  text: 'Partiellement'
                                      ,
                                  isSquare: false,
                                ),
                                SizedBox(
                                  height: 18,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                  padding: EdgeInsets.all(5),
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: MyColors.grayClair,
                   /* boxShadow: [
                      BoxShadow(
                        // color: Colors.grey.shade600,
                        color: Colors.black.withOpacity(0.2),
                        //  blurStyle: BlurStyle.solid,
                        blurRadius: 10.0,
                        spreadRadius: 1,

                        offset: Offset(0, 3.0),
                      ),
                    ],
                    */
                    border: Border.all(
                        color: MyColors.colorPrimary,
                        width: 2.0,
                        style: BorderStyle
                            .solid), // no shadow color set, defaults to black
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                  ),
                  child: Column(children: [
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                      Container(
                          //width: (MediaQuery.of(context).size.width * .54),
                          child: Text(
                        "Dossiers:  ",
                        style: TextStyle(color: Colors.blue),
                      )),
                      Container(
                          //width: (MediaQuery.of(context).size.width * .54),
                          child: Text(
                        "${statDossier.statDossier?.nbrDossiers}   ",
                      )),
                      Container(
                          //width: (MediaQuery.of(context).size.width * .54),
                          child: (statDossier.statDossier!.nbrDossiers > 1)
                              ? Text(
                                  "Dossiers",
                                )
                              : Text(
                                  "Dossier",
                                )),
                    ]),
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                      Container(
                          alignment: AlignmentDirectional.bottomStart,
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: Text(
                            "Mnt Patient:  ",
                          )),
                      Container(
                          alignment: AlignmentDirectional.centerStart,
                          width: MediaQuery.of(context).size.width * 0.3,
                          //width: (MediaQuery.of(context).size.width * .54),
                          child: Text(
                            "Mnt Société  ",
                          )),
                      Container(
                          alignment: AlignmentDirectional.bottomEnd,
                          width: MediaQuery.of(context).size.width * 0.2,
                          //width: (MediaQuery.of(context).size.width * .54),
                          child: Text(
                            "Total  ",
                          )),
                    ]),
                    Row(children: [
                      Container(
                          alignment: AlignmentDirectional.bottomStart,
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: Text(
                            "${statDossier.statDossier?.totalPatient?.toStringAsFixed(3)}  ",
                          )),
                      Container(
                          alignment: AlignmentDirectional.centerStart,
                          width: MediaQuery.of(context).size.width * 0.3,
                          //width: (MediaQuery.of(context).size.width * .54),
                          child: Text(
                            "${statDossier.statDossier?.totalSociete?.toStringAsFixed(3)}",
                          )),
                      Container(
                          alignment: AlignmentDirectional.bottomEnd,
                          width: MediaQuery.of(context).size.width * 0.2,
                          //width: (MediaQuery.of(context).size.width * .54),
                          child: Text(
                            "${(statDossier.statDossier!.totalSociete! + statDossier.statDossier!.totalPatient!).toStringAsFixed(3)}",
                          )),
                    ]),
                  ])),
              Container(
                  padding: EdgeInsets.all(5),
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: MyColors.grayClair,

                    border: Border.all(
                        color: MyColors.colorPrimary,
                        width: 2.0,
                        style: BorderStyle
                            .solid), // no shadow color set, defaults to black
                    borderRadius: const BorderRadius.all(Radius.circular(5)),
                  ),
                  child: Column(children: [
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                      Container(
                          //width: (MediaQuery.of(context).size.width * .54),
                          child: Text(
                        "Factures:  ",
                        style: TextStyle(color: Colors.blue),
                      )),
                      Container(
                          //width: (MediaQuery.of(context).size.width * .54),
                          child: Text(
                        "${statDossier.statFacture?.nbrFactures}",
                      )),
                      Container(
                          //width: (MediaQuery.of(context).size.width * .54),
                          child: (statDossier.statFacture!.nbrFactures! > 1)
                              ? Text(
                                  "   Factures",
                                )
                              : Text(
                                  "   Facture ",
                                )),
                    ]),
                    Row(
                        //mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                              alignment: AlignmentDirectional.bottomCenter,
                              width: MediaQuery.of(context).size.width * 0.6,
                              //width: (MediaQuery.of(context).size.width * .54),
                              child: Text(
                                "Total TTC :  ${statDossier.statFacture?.totalTTC?.toStringAsFixed(3)}",
                              )),
                        ]),
                  ])),
              Container(
                  padding: EdgeInsets.all(5),
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                 // height: MediaQuery.of(context).size.height * 0.40,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: MyColors.grayClair,

                    border: Border.all(
                        color: MyColors.colorPrimary,
                        width: 2.0,
                        style: BorderStyle
                            .solid), // no shadow color set, defaults to black
                    borderRadius: const BorderRadius.all(Radius.circular(5)),
                  ),
                  child: Column(children: [
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                      Container(
                          //width: (MediaQuery.of(context).size.width * .54),
                          child: Text(
                        "Règlements :  ",
                        style: TextStyle(color: Colors.blue),
                      )),
                    ]),

                       ListView.builder(
                          controller: scrollController,
                         //physics: const NeverScrollableScrollPhysics(), //<--here

                          shrinkWrap: true,
                          physics: const ClampingScrollPhysics(),
                          padding: EdgeInsets.zero,
                          //itemCount: allDossierAnalyse.length,
                          itemCount: statDossier.statReglements!.length,
                          itemBuilder: (context, index) {

                              return
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children:[
                                      Container(

                                          width: MediaQuery.of(context).size.width * 0.3,
                                          //width: (MediaQuery.of(context).size.width * .54),
                                          child: Text(
                                            "T.${statDossier.statReglements![index].modePaiement}${(!statDossier.statReglements![index].modePaiement!.endsWith("s"))?"s":""}",

                                          )),  Container(
                                          alignment: AlignmentDirectional.bottomEnd,
                                          width: MediaQuery.of(context).size.width * 0.2,
                                          //width: (MediaQuery.of(context).size.width * .54),
                                          child: Text(
                                            "${statDossier.statReglements![index].totalMontant!.toStringAsFixed(3)}",style: TextStyle(color: Colors.green),

                                          )),

                                    ]);

                          },
                        ),




                    SizedBox(
                      height: 5,
                    ),

                    Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                      Container(
                          width: MediaQuery.of(context).size.width * 0.3,
                          //width: (MediaQuery.of(context).size.width * .54),
                          child: Text(
                            "Total :  ",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )),
                      Container(
                          alignment: AlignmentDirectional.bottomEnd,
                          width: MediaQuery.of(context).size.width * 0.2,
                          //width: (MediaQuery.of(context).size.width * .54),
                          child: Text(
                            "${statDossier.totalReglement?.toStringAsFixed(3)}",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )),
                    ]),
                    SizedBox(
                      height: 20,
                    ),
                    if (statDossier.totalRemboursements != 0)
                      Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                        Container(
                            width: MediaQuery.of(context).size.width * 0.6,
                            //width: (MediaQuery.of(context).size.width * .54),
                            child: Text("  Total des remboursements : ",
                                style: TextStyle(fontSize: 16))),
                        //SizedBox(height: 20,),
                        Container(
                            alignment: AlignmentDirectional.bottomEnd,
                            width: MediaQuery.of(context).size.width * 0.25,
                            //width: (MediaQuery.of(context).size.width * .54),
                            child: Text(
                              "${statDossier.totalRemboursements?.toStringAsFixed(3)}",
                              style: TextStyle(color: Colors.red),
                            )),
                      ]),
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                      Container(

                          alignment: AlignmentDirectional.centerStart,
                          width: MediaQuery.of(context).size.width * 0.65,
                          //width: (MediaQuery.of(context).size.width * .54),
                          child: Text(
                            "  Dossiers/Factures de la période:",
                            style: TextStyle(fontSize: 15),
                          )),
                      //SizedBox(height: 20,),
                      Container(
                          alignment: AlignmentDirectional.bottomEnd,
                          width: MediaQuery.of(context).size.width * 0.25,
                          //width: (MediaQuery.of(context).size.width * .54),
                          child: Text(
                            "${statDossier.totalReglementPeriode?.toStringAsFixed(3)}",
                            style: TextStyle(fontSize: 16),
                          )),
                    ]),
                    // SizedBox(height: 5,),
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                      Container(
                          alignment: AlignmentDirectional.centerStart,
                          width: MediaQuery.of(context).size.width * 0.6,
                          //width: (MediaQuery.of(context).size.width * .54),
                          child: Text(
                            "  Dossiers/Factures antérieurs :  ",
                            style: TextStyle(fontSize: 16),
                          )),
                      Container(
                          alignment: AlignmentDirectional.bottomEnd,
                          width: MediaQuery.of(context).size.width * 0.25,
                          //width: (MediaQuery.of(context).size.width * .54),
                          child: Text(
                            "${statDossier.totalReglementAnterieurs?.toStringAsFixed(3)}",
                            style: TextStyle(fontSize: 16),
                          )),
                    ]),
                    GestureDetector(

                        child: Row(
                        mainAxisAlignment :MainAxisAlignment.end,
                          children: [
                            Text("Détails",style: TextStyle(color: Colors.blue),),
                            SizedBox(width: 10,),
                            Icon(Icons.launch_rounded,color:Colors.blue,)
                          ],
                        ),
                        onTap: () {
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
                                    BlocProvider(
                                      create: (context) => FiltreBloc(),
                                    ), BlocProvider(
                                      create: (context) =>
                                          ReglementBloc(DossierAnalyseRepository(
                                              DossierWebService())),
                                    ), BlocProvider(
                                      create: (context) =>
                                          StatBloc(DossierAnalyseRepository(
                                              DossierWebService())),
                                    ),

                                    BlocProvider(
                                        create: (context) =>
                                            DossieranalyseBloc(
                                                DossierAnalyseRepository(
                                                    DossierWebService()))),
                                  ],
                                  child: const HomePage(),
                                  // child: const DossierDetail(),
                                ),

                            ),
                          );
                        }
                        },

                      ),

                  ])),
              Container(
                  padding: EdgeInsets.all(5),
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  //height: MediaQuery.of(context).size.height * 0.05,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: MyColors.grayClair,
                    border: Border.all(
                        color: MyColors.colorPrimary,
                        width: 2.0,
                        style: BorderStyle
                            .solid), // no shadow color set, defaults to black
                    borderRadius: const BorderRadius.all(Radius.circular(5)),
                  ),
                  child: Column(children: [
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                      Container(
                          //width: (MediaQuery.of(context).size.width * .54),
                          child: Text(
                        "Crédits de la période :  ",
                        style: TextStyle(color: Colors.blue),
                      )),
                      Container(
                          alignment: AlignmentDirectional.bottomEnd,
                          //width: (MediaQuery.of(context).size.width * .54),
                          child: Text(
                              "${statDossier.statDossier?.totalCredit?.toStringAsFixed(3)}  ",
                              style: TextStyle(color: Colors.red))),
                    ]),
                  ])),

            ])),
          );
        } else if ((state).isLoadingStat == false)
        {
          return Center(
            child: Container(
                alignment:AlignmentDirectional.center ,
                height: MediaQuery.of(context).size.width,
                child:const Text("Errur de serveur")),
          );
        }else
        {
          return Center(child: const CircularProgressIndicator());
        }
      }),
    );
  }


  List<PieChartSectionData> showingSections() {
    return List.generate(4, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 25.0 : 16.0;
      final radius = isTouched ? 60.0 : 50.0;
      const shadows = [Shadow(color: Colors.black, blurRadius: 2)];
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: Colors.lightBlueAccent,
            value: statDossier.pieEntries?[3].valeur?.toDouble(),
            title: statDossier.pieEntries?[3].valeur?.toString(),
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.black,
              shadows: shadows,
            ),
          );
        case 1:
          return PieChartSectionData(
            color: Colors.amber,
            value:statDossier.pieEntries?[2].valeur?.toDouble(),
            title: statDossier.pieEntries?[2].valeur?.toString(),
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.black,
              shadows: shadows,
            ),
          );
        case 2:
          return PieChartSectionData(
            color: Colors.purpleAccent,
            value: statDossier.pieEntries?[0].valeur?.toDouble() ,
            title: statDossier.pieEntries?[0].valeur?.toString() ,
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.black,
              shadows: shadows,
            ),
          );
        case 3:
          return PieChartSectionData(
            color: Colors.greenAccent,
            value: statDossier.pieEntries?[1].valeur?.toDouble(),
            title: statDossier.pieEntries?[1].valeur?.toString(),
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.black,
              shadows: shadows,
            ),
          );
        default:
          throw Error();
      }
    });
  }
}

class SalesData {
  SalesData(this.year, this.sales);
  final String year;
  final double sales;
}
class Indicator extends StatelessWidget {
  const Indicator({
    super.key,
    required this.color,
    required this.text,
    required this.isSquare,
    this.size = 15,
    this.textColor,
  });
  final Color color;
  final String text;
  final bool isSquare;
  final double size;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: isSquare ? BoxShape.rectangle : BoxShape.circle,
            color: color,
          ),
        ),
        const SizedBox(
          width: 4,
        ),
        Text(
          text,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        )
      ],
    );
  }
}