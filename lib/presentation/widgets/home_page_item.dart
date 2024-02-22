import 'package:flutter/material.dart';

import '../../app/constants/my_colors.dart';
import '../../data/models/dossier_analyse_model.dart';

class DossierItem extends StatelessWidget {
  final DossierAnalyse dossierAnalyse;
  final Color colrorOfItem;
  const DossierItem(this.dossierAnalyse, this.colrorOfItem, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(left: 8.0, right: 8.0),
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Container(
        height: 100,
        decoration: BoxDecoration(
            color: colrorOfItem,
            borderRadius: const BorderRadius.all(Radius.circular(10))),

        /*Padding(
                   padding: const EdgeInsets.all(8.0),
                   child: Row(children: <Widget>[
                     Icon(Icons.person, color: Colors.white70),
                     Text(
                         "${dossierAnalyse!.patient!.sexe} ",
                       style: TextStyle(color: Colors.white70),
                     )
                   ])),
               */

        child: Row(children: [
          Column(children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.asset(
                  'assets/images/patient_male.png',
                  height: 60.0,
                  width: 80.0,
                ),
              ),
            ),
            Text("${dossierAnalyse.getAge()} "),
          ]),
          Container(
            width: 250,
            alignment: Alignment.topLeft,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text.rich(
                          maxLines: 1,
                          TextSpan(children: [
                            TextSpan(
                                text:
                                    "${dossierAnalyse.patient?.nom} ${dossierAnalyse.patient?.prenom}  ",
                                style: const TextStyle(
                                  fontSize: 14,
                                )),
                            TextSpan(
                                text: "${dossierAnalyse.typePatient}",
                                style: const TextStyle(
                                    color: MyColors.orangeDark, fontSize: 14)),
                          ]),
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
                        "${dossierAnalyse.nenreg}       ${DateTime.parse(dossierAnalyse.datePrelevement!).year}-${DateTime.parse(dossierAnalyse.datePrelevement!).month}-${DateTime.parse(dossierAnalyse.datePrelevement!).day}    ${DateTime.parse(dossierAnalyse.datePrelevement!).hour}:${DateTime.parse(dossierAnalyse.datePrelevement!).minute}",
                        maxLines: 1,
                        style: const TextStyle(fontSize: 12),
                      ),
                    ),
                  ]),
                ),
                Padding(
                    padding: const EdgeInsets.all(1),
                    child: Row(children: [
                      Expanded(
                        child: Text(
                          "${dossierAnalyse.medecin!.nomPrenom} ",
                          maxLines: 1,
                          style: const TextStyle(fontSize: 12),
                        ),
                      ),
                    ])),
                Padding(
                    padding: const EdgeInsets.all(2),
                    child: Row(children: [
                      Text.rich(
                        TextSpan(children: [
                          TextSpan(
                              text: "${dossierAnalyse.listeAnalysesEnCours} ",
                              style: const TextStyle(
                                  color: MyColors.orangeDark, fontSize: 12)),
                          TextSpan(
                              text: "${dossierAnalyse.listeAnalysesTermines}",
                              style: const TextStyle(
                                  color: MyColors.greenDark, fontSize: 12)),
                        ]),
                      ),
                    ])),
              ],
            ),
          ),
          Container(
            height: 100,
            child: const Text(
              "icon ",
              style: TextStyle(color: Colors.black),
            ),
          )
        ]),
      ),
    );
  }
}
