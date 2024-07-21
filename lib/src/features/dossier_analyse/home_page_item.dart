import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constants/my_colors.dart';
import '../../../data/models/dossier_analyse_model.dart';
import '../../../data/repository/dossier_repository.dart';
import '../../../data/web_services/dossier_web_services.dart';
import '../../navigation/app_router.dart';
import '../dossier_detail/detail_bloc/dossier_detail_bloc.dart';
import '../dossier_detail/dossier_detail.dart';
import '../dossier_detail/email_bloc/email_bloc.dart';

class DossierItem extends StatelessWidget {
  final DossierDto dossier;
  final Color colrorOfItem;

  const DossierItem(this.dossier, this.colrorOfItem, {super.key});
  @override
  Widget build(BuildContext context) {
    var iconSex;
    log("7575757575");
    log(DateTime.parse(dossier.dossierAnalyse!.datePrelevement!.substring(0,22)).toString());
    DateTime datecurrent=DateTime.parse(dossier.dossierAnalyse!.datePrelevement!.substring(0,22));
    if ((this.dossier.dossierAnalyse!.patient?.titre?.toUpperCase().trim() == "MR")) {
      iconSex = "patient_male.png";
    } else if ((this.dossier.dossierAnalyse!.patient?.titre?.toUpperCase().trim() ==
            "MME") ||
        (this.dossier.dossierAnalyse!.patient?.titre?.toUpperCase().trim() == "MLLE")) {
      iconSex = "patient_female.png";
    } else if ((this.dossier.dossierAnalyse!.patient?.titre?.toUpperCase().trim() ==
            "ENF") ||
        (this.dossier.dossierAnalyse!.patient?.titre?.toUpperCase().trim() == "BB")) {
      iconSex = "patient_child.png";
    }
    return GestureDetector(
      onTap: (){
        log("1111${dossier.dossierAnalyse!.patient!.nom} ");
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) =>
              MultiBlocProvider(
                  providers: [
                  BlocProvider(
                  create: (context) => EmailBloc(),
        ),
      BlocProvider<DossierDetailBloc>(
        create: (BuildContext context)  =>
        DossierDetailBloc(DossierAnalyseRepository(DossierWebService()))..add( LoadDetailEvent(this.dossier)),
        // dossierAnalyse!.nenreg!!
      ),
        ],
        child:  DossierDetail(this.dossier ),
      ),

        ),
        );
        },
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(left: 8.0, right: 8.0),
        padding: const EdgeInsets.all(4),
      
          decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Container(
          decoration: BoxDecoration(
              color: colrorOfItem,
              borderRadius: const BorderRadius.all(Radius.circular(10))),
      
          child: Row(children: [
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
            Container(
              width: MediaQuery.of(context).size.width * 0.6,
              alignment: Alignment.topLeft,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text.rich(
                            //maxLines: 1,
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
                                    text: "${dossier.dossierAnalyse!.typePatient}",
                                    style: const TextStyle(
                                        color: MyColors.orangeDark,
                                        fontSize: 14)),
                            ]),
                          ),
                        ),
                        if (dossier.dossierAnalyse!.signer == true)
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Image.asset(
                              'assets/images/certificate.png',
                              height: 20.0,
                              width: 20.0,
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
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(1),
                    child: Row(children: [
                      Expanded(
                        child: Text(
                          "${dossier.dossierAnalyse!.nenreg}       ${datecurrent .year}-${datecurrent.month}-${datecurrent.day}    ${datecurrent.hour}:${datecurrent.minute}",
                          maxLines: 1,
                          style: const TextStyle(fontSize: 12),
                        ),
                      ),
                      if (dossier.dossierAnalyse!.urgent == true)
                        //dossierAnalyse.urgent == true
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.asset(
                            'assets/images/emergency.png',
                            height: 20.0,
                            width: 20.0,
                          ),
                        ),
                      if (dossier.dossierAnalyse!.solde! > dossier.ignoreSolde)
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.asset(
                            'assets/images/red_dollar.png',
                            height: 20.0,
                            width: 20.0,
                          ),
                        ),
                      if (dossier.dossierAnalyse!.solde! <= dossier.ignoreSolde)
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.asset(
                            'assets/images/green_dollar.png',
                            height: 20.0,
                            width: 20.0,
                          ),
                        ),
                    ]),
                  ),
                  Padding(
                      padding: const EdgeInsets.all(1),
                      child: Row(children: [
                        if (dossier.dossierAnalyse!.medecin!.nomPrenom?.trim() != "")
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Image.asset(
                              'assets/images/male_doc.png',
                              height: 20.0,
                              width: 20.0,
                            ),
                          ),
                        Expanded(
                          child: Text(
                            "${dossier.dossierAnalyse!.medecin!.nomPrenom} ",
                            maxLines: 1,
                            style: const TextStyle(fontSize: 12),
                          ),
                        ),
                      ])),
                  Container(
                      padding: const EdgeInsets.all(2),
                      child: Row(children: [
                         Expanded(
                           child: Text("${dossier.dossierAnalyse!.listeAnalysesEnCours} ",

                                style: const TextStyle(
                                    color: MyColors.orangeDark, fontSize: 12)),
                         ),

                        Expanded(
                          child: Text("${dossier.dossierAnalyse!.listeAnalysesTermines}",
                              textAlign: TextAlign.start,
                              style: const TextStyle(
                                color: MyColors.greenDark,
                                fontSize: 12,
                              )),
                        ),
                      ])),
                ],
              ),
            ),
            Container(
                width: MediaQuery.of(context).size.width * 0.09,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (dossier.acontroler == true)
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.asset(
                          'assets/images/warning.png',
                          height: 20.0,
                          width: 20.0,
                        ),
                      ),
                    SizedBox(
                      height: 10,
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
                    SizedBox(
                      height: 10,
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
                  ],
                ))
          ]),
        ),
      ),

    );
  }
}
