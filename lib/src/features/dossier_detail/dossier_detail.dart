import 'dart:developer';

import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prolab_mobile/data/models/dossier_analyse_model.dart';
import 'package:prolab_mobile/src/features/dossier_detail/detail_bloc/dossier_detail_bloc.dart';

import '../../../core/constants/my_colors.dart';
import '../../../core/util/util_functions.dart';
import '../../../data/models/dossier_detail.dart';

@RoutePage()
class DossierDetail extends StatefulWidget {
  final DossierDto dossierAnalyse;
  const DossierDetail(
    this.dossierAnalyse, {
    super.key,
  });
  @override
  _DossierDetailState createState() => _DossierDetailState(dossierAnalyse);
}

class _DossierDetailState extends State<DossierDetail> {
  final DossierDto dossier;

  bool _isLoading = true;
  final List<Color> _colors = [
    Colors.red,
    Colors.black,
    Colors.grey,
    Colors.amber,
    Colors.white
  ];

  _DossierDetailState(this.dossier);

  final PageController _pageController = PageController(initialPage: 0);
  @override
  void initState() {
    super.initState();
    context.read<DossierDetailBloc>()
      ..add(LoadDetailEvent(this.dossier.dossierAnalyse!.nenreg!!));
  }

  void _updatePage(bool moveRight) {
    int? currentPage = _pageController.page?.toInt();
    log("current page $currentPage");
    if (currentPage == null) {
      return;
    }

    int newPage = moveRight ? currentPage + 1 : currentPage - 1;
    log("new page $newPage");

    if (newPage < 0) {
      return;
    }

    /* if( newPage > list.length +1){
      return;
    }
    */

    _pageController.animateToPage(newPage,
        duration: const Duration(milliseconds: 400), curve: Curves.easeIn);
  }

  @override
  Widget build(BuildContext context) {
    var iconSex;
    bool verifgsmP = false;
    bool veriftelP = false;
    if (dossier.dossierAnalyse!.patient!.tel != null) {
      if (dossier.dossierAnalyse!.patient!.tel!.trim().isNotEmpty) {
        veriftelP = true;
      }
    }
    if (dossier.dossierAnalyse!.patient!.gsm != null) {
      if (dossier.dossierAnalyse!.patient!.gsm!.trim().isNotEmpty) {
        verifgsmP = true;
      }
    }
    log("${dossier.dossierAnalyse!.medecin!.tel}");
    log("${dossier.dossierAnalyse!.medecin!.gsm}");
    bool verifgsmM = false;
    bool veriftelM = false;
    if (dossier.dossierAnalyse!.medecin!.tel != null) {
      if (dossier.dossierAnalyse!.medecin!.tel!.trim().isNotEmpty) {
        veriftelM = true;
      }
    }
    if (dossier.dossierAnalyse!.medecin!.gsm != null) {
      if (dossier.dossierAnalyse!.medecin!.gsm!.trim().isNotEmpty) {
        verifgsmM = true;
      }
    }
    if ((this.dossier.dossierAnalyse!.patient?.titre?.toUpperCase().trim() ==
        "MR")) {
      iconSex = "patient_male.png";
    } else if ((this
                .dossier
                .dossierAnalyse!
                .patient
                ?.titre
                ?.toUpperCase()
                .trim() ==
            "MME") ||
        (this.dossier.dossierAnalyse!.patient?.titre?.toUpperCase().trim() ==
            "MLLE")) {
      iconSex = "patient_female.png";
    } else if ((this
                .dossier
                .dossierAnalyse!
                .patient
                ?.titre
                ?.toUpperCase()
                .trim() ==
            "ENF") ||
        (this.dossier.dossierAnalyse!.patient?.titre?.toUpperCase().trim() ==
            "BB")) {
      iconSex = "patient_child.png";
    }

    var dropdownValue;

    return Scaffold(
        appBar: AppBar(
          backgroundColor: MyColors.colorPrimary,
          centerTitle: true,
          title: Column(children: [
            Text(
              'Détails du Dossier',
              style: TextStyle(color: MyColors.grayClair),
            ),
            GestureDetector(
              child: Text(
                'Validation en ligne',
                style: TextStyle(fontSize: 14, color: Colors.white),
              ),
            )
          ]),
          actions: [
            IconButton(
              onPressed: () => {
                _updatePage(false),
                context.read<DossierDetailBloc>()
                  ..add(LoadDetailPreviousEvent(this.dossier.dossierAnalyse!)),
              },
              icon: const Icon(Icons.arrow_back),
              color: MyColors.white,
            ),
            IconButton(
              onPressed: () => {
                _updatePage(true),
                context.read<DossierDetailBloc>()
                  ..add(LoadDetailNextEvent(this.dossier.dossierAnalyse!)),
              },
              icon: const Icon(Icons.arrow_forward),
              color: MyColors.white,
            ),
          ],
        ),
        body: Column(
          children: [
            Container(
                margin: EdgeInsets.symmetric(horizontal: 4),
                height: MediaQuery.of(context).size.height * 0.2,
                child: Column(children: [
                  Row(children: [
                    Text("${dossier.dossierAnalyse!.nenreg}   ",
                        style: const TextStyle(
                            color: MyColors.colorPrimary, fontSize: 12)),
                    Expanded(
                      child: Text(
                        "${DateTime.parse(dossier.dossierAnalyse!.datePrelevement!).year}-${DateTime.parse(dossier.dossierAnalyse!.datePrelevement!).month}-${DateTime.parse(dossier.dossierAnalyse!.datePrelevement!).day}",
                        maxLines: 1,
                        style: const TextStyle(fontSize: 12),
                      ),
                    ),
                    if ((dossier.dossierAnalyse!.statut! & 4) > 0)
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.asset(
                          'assets/images/check.png',
                          height: 20.0,
                          width: 20.0,
                        ),
                      ),
                    if (dossier.dossierAnalyse!.nbrImpr! > 0)
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.asset(
                          'assets/images/printer.png',
                          height: 25.0,
                          width: 25.0,
                        ),
                      ),
                    if (dossier.dossierAnalyse!.livree == true)
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.asset(
                          'assets/images/send.png',
                          height: 20.0,
                          width: 20.0,
                        ),
                      ),
                  ]),
                  Row(
                    children: [
                      Column(children: [
                        Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Image.asset(
                              'assets/images/${iconSex}',
                              height: 50.0,
                              width: 80.0,
                            ),
                          ),
                        ),
                        Container(
                            width: MediaQuery.of(context).size.width * 0.2,
                            alignment: Alignment.center,
                            child: Text(
                              "${dossier.dossierAnalyse!.getAge()} ",
                              textAlign: TextAlign.center,
                            )),
                      ]),

                      ///F
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text.rich(
                                maxLines: 1,
                                TextSpan(children: [
                                  TextSpan(
                                      text:
                                          "${dossier.dossierAnalyse!.patient?.nom} ${dossier.dossierAnalyse!.patient?.prenom}  ",
                                      style: const TextStyle(
                                        fontSize: 14,
                                      )),
                                  if (dossier.dossierAnalyse!.cnam == true)
                                    TextSpan(
                                        text: "CNAM",
                                        style: const TextStyle(
                                            color: MyColors.orangeDark,
                                            fontSize: 14)),
                                  if (dossier.dossierAnalyse!.cnam == false)
                                    TextSpan(
                                        text:
                                            "${dossier.dossierAnalyse!.typePatient}",
                                        style: const TextStyle(
                                            color: MyColors.orangeDark,
                                            fontSize: 14)),
                                ]),
                              ),
                              if (veriftelP || verifgsmP)
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8.0),
                                  child: Image.asset(
                                    'assets/images/phonecall.png',
                                    height: 20.0,
                                    width: 20.0,
                                  ),
                                ),
                            ],
                          ),

                          Container(
                            child: Row(
                              children: [
                                if (dossier.dossierAnalyse!.medecin!.nomPrenom
                                        ?.trim() !=
                                    "")
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8.0),
                                    child: Image.asset(
                                      'assets/images/male_doc.png',
                                      height: 20.0,
                                      width: 20.0,
                                    ),
                                  ),
                                Text(
                                    "${dossier.dossierAnalyse!.medecin?.nomPrenom}  ",
                                    style: const TextStyle(
                                        fontSize: 14,
                                        color: MyColors.colorPrimary)),
                                if (veriftelM || verifgsmM)
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8.0),
                                    child: Image.asset(
                                      'assets/images/phonecall.png',
                                      height: 20.0,
                                      width: 20.0,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.7,
                            alignment: Alignment.bottomRight,
                            child: DropdownButton<String>(
                              value: dropdownValue,
                              icon: Icon(Icons.more_horiz),
                              items: <String>[
                                'One',
                                'Two',
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 30.0),
                                    child: Text("$value"),
                                  ),
                                );
                              }).toList(),
                              onChanged: (String? value) {},
                            ),
                          ),
                          //row3
                        ],
                      ),
                    ],
                  ),
                ])),
            Expanded(
              child: PageView(
                controller: _pageController,
                children: [
                  for (final color in _colors)
                    DossierItem(
                      color,
                    )
                ],
              ),
            ),
          ],
        ),
        floatingActionButton:FloatingActionButton(
        backgroundColor: MyColors.colorPrimary, onPressed: () {  },
        )

    );
  }
}

class DossierItem extends StatelessWidget {
  final Color color;
  late List<DossierAnalyseDetail> detailDossierAnalyse;

  DossierItem(this.color, {super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DossierDetailBloc, DossierDetailBlocState>(
        builder: (context, state) {
      print(state);

      detailDossierAnalyse = (state).details;

      return Expanded(
        child: ListView.builder(
          //  controller: scrollController,
          shrinkWrap: true,
          physics: const ClampingScrollPhysics(),
          padding: EdgeInsets.zero,
          //itemCount: allDossierAnalyse.length,
          itemCount: detailDossierAnalyse.length,
          itemBuilder: (context, index) {
            if (index < detailDossierAnalyse.length) {
              return DetailItem(detailDossierAnalyse[index], color);
            } else {
              return Center(child: const CircularProgressIndicator());
            }
          },
        ),
      );
    });
  }
}

class DetailItem extends StatelessWidget {
  final DossierAnalyseDetail detailAnalyse;
  final Color color;
  DetailItem(this.detailAnalyse, this.color);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        color: color,
        child: Column(children: [
          (detailAnalyse.estGroupe)
              ? (detailAnalyse.numGroupe == null ||
                      detailAnalyse.numGroupe!.trim().isEmpty)
                  ? Container(
                      width: MediaQuery.of(context).size.width,
                      color: MyColors.colorPrimary,
                      padding: EdgeInsets.only(left: 2),
                      child: Text(
                        "${detailAnalyse.libelle}",
                        style: TextStyle(
                            color: MyColors.white, fontWeight: FontWeight.bold),
                      ),
                    )
                  : Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        margin: EdgeInsets.only(left: 10),
                        color: MyColors.lightblue,
                        padding: EdgeInsets.all(4),
                        child: Text(
                          "${detailAnalyse.libelle}",
                          style: TextStyle(
                            color: MyColors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    )
              : Container(

                  // setBackgroundColor(argb(100, 250, 150, 150));
                  margin: (detailAnalyse.numGroupe != null &&
                          detailAnalyse.numGroupe!.isNotEmpty)
                      ? EdgeInsets.only(
                          left: 10,
                          top: 4,
                          bottom: 4,
                        )
                      : EdgeInsets.only(
                          left: 5,
                          top: 4,
                          bottom: 4,
                        ),
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.all(1),
                  decoration: BoxDecoration(
                    color: (detailAnalyse.horsNorme)
                        ? Color.fromARGB(100, 250, 150, 150)
                        : MyColors.white,
                    //Color.fromARGB(100, 255, 255, 255),
                    boxShadow: [
                      BoxShadow(
                        // color: Colors.grey.shade600,
                        color: Colors.black.withOpacity(0.2),
                        //  blurStyle: BlurStyle.solid,
                        blurRadius: 10.0,
                        spreadRadius: 1,

                        offset: Offset(0, 3.0),
                      ),
                    ],
                    border: Border.all(
                        color: Colors.grey,
                        width: 2.0,
                        style: BorderStyle
                            .solid), // no shadow color set, defaults to black
                    borderRadius: const BorderRadius.all(Radius.circular(5)),
                  ),
                  child: Column(children: [
                    Padding(
                      padding: const EdgeInsets.all(1.0),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(1),
                            child: Row(children: [
                              (detailAnalyse.toControl == true)
                                  ? ClipRRect(
                                      borderRadius: BorderRadius.circular(8.0),
                                      child: Image.asset(
                                        'assets/images/warning.png',
                                        height: 15.0,
                                        width: 10.0,
                                      ),
                                    )
                                  : SizedBox(
                                      width: 10,
                                    ),
                              SizedBox(
                                width: 40,
                                child: Text(
                                  (detailAnalyse.abreviation!.length < 4)
                                      ? "${detailAnalyse.abreviation}"
                                      : "${detailAnalyse.abreviation?.substring(0, 4)}",
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: MyColors.colorPrimary,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.3,
                                padding: EdgeInsets.only(left: 2),
                                child: Text(
                                  "${detailAnalyse.libelle?.trim()}",
                                  style: const TextStyle(fontSize: 10),
                                ),
                              ),
                              if (detailAnalyse.resultat?.trim() != null)
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.2,
                                  padding: EdgeInsets.only(left: 2),
                                  child: Text(
                                    "${UtilFunctions.rtfToPlain(detailAnalyse.resultat!.trim())}",
                                    style: const TextStyle(fontSize: 12),
                                  ),
                                ),
                              if (detailAnalyse.unite1?.trim() != null)
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.1,
                                  padding: EdgeInsets.only(left: 2),
                                  child: Text(
                                    "${detailAnalyse.unite1?.trim()}",
                                    style: const TextStyle(fontSize: 12),
                                  ),
                                ),
                              if (detailAnalyse.valeurUsuelle?.trim() != null)
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.2,
                                  padding: EdgeInsets.only(left: 2),
                                  child: Text(
                                    "${UtilFunctions.rtfToPlain(detailAnalyse.valeurUsuelle!.trim())}",
                                    style: const TextStyle(fontSize: 12),
                                  ),
                                ),
                            ]),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(1),
                      child: Row(children: [
                        if (detailAnalyse.anteriorite != null &&
                            detailAnalyse.anteriorite.length > 0)
                          Expanded(
                            child: Text(
                              "${detailAnalyse.anteriorite[0]}\n",
                              // " ${detailAnalyse.anteriorite[1]} \n ${detailAnalyse.anteriorite[2]}",
                              style: const TextStyle(
                                  fontSize: 12, color: MyColors.colorPrimary),
                              textAlign: TextAlign.center,
                            ),
                          ),
                      ]),
                    ),
                    if (detailAnalyse.commentaire?.trim() != null)
                      Container(
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.only(left: 2),
                        child: Text(
                          "${UtilFunctions.rtfToPlain(detailAnalyse.commentaire!.trim())}",
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                  ])),
        ]),
      ),
    );
  }
}
