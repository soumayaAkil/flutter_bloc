import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prolab_mobile/data/models/dossier_analyse_model.dart';

import '../../../core/constants/my_colors.dart';
import 'detail_bloc/dossier_detail_bloc.dart';
class Antiboigramme extends StatefulWidget {
  final DossierDto dossierAnalyse;
  const Antiboigramme(
      this.dossierAnalyse, {
        super.key,
      });
  @override
  _AntiboigrammeState createState() => _AntiboigrammeState(this.dossierAnalyse);
}

class _AntiboigrammeState extends State<Antiboigramme> {
  late final DossierDto dossier;
  late List<Antiboigramme> allAntiboigrammes;
  bool _isLoading = true;
  int x = 0;
  _AntiboigrammeState(this.dossier);

  final PageController _pageController = PageController(initialPage: 0);

  @override
  void initState() {
    log("fffffffffffffffff${dossier.dossierAnalyse!.patient!.nom} ");
    context
        .read<DossierDetailBloc>()
        .add(LoadATBEvent(this.dossier));


    super.initState();
    /*  context.read<DossierDetailBloc>()
      ..add(LoadDetailEvent(this.dossier));
*/
  }


  @override
  Widget build(BuildContext context) {
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
                'Antibiogramme',
                style: TextStyle(fontSize: 14, color: Colors.white),
              ),
            )
          ]),
        ),
        body:


               BlocBuilder<DossierDetailBloc, DossierDetailBlocState>(
                builder: (context, state) {
            allAntiboigrammes = (state).antibiogrammes;
            log("length");
            log(allAntiboigrammes.length.toString());
            return Expanded(
            child: ListView.builder(
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            padding: EdgeInsets.zero,
            //itemCount: allDossierAnalyse.length,
            itemCount: allAntiboigrammes.length,
            itemBuilder: (context, index) {
            if (index < allAntiboigrammes.length) {
            return ATBItem(
            allAntiboigrammes[index]);
            } else {
            return Center(
            child: const Text("no more data to load "));
            }
            },
            ),
            );
            },
            );
}

}

class ATBItem extends StatelessWidget {
  final Antiboigramme ATB;

  const ATBItem(this.ATB, {super.key});
  @override
  Widget build(BuildContext context) {