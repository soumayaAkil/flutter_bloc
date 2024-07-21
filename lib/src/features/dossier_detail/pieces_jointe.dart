import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prolab_mobile/data/models/dossier_analyse_model.dart';

import '../../../core/constants/my_colors.dart';
import '../../../core/util/util_functions.dart';
import '../../../data/models/antibiogramme.dart';
import 'detail_bloc/dossier_detail_bloc.dart';
class PiecesJointe extends StatefulWidget {
  final int dossierAnalyse;
  const PiecesJointe(
      this.dossierAnalyse, {
        super.key,
      });

  @override
  _PiecesJointeState createState() => _PiecesJointeState();
}

class _PiecesJointeState extends State<PiecesJointe> {
  late  DossierDto dossier;
  late List<Antibiogramme> allAntiboigrammes;
  bool _isLoading = true;
  int x = 0;

  @override
  void initState() {
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
      body:BlocBuilder<DossierDetailBloc, DossierDetailBlocState>(
        builder: (context, state) {
          allAntiboigrammes = (state).antibiogrammes;
          return ListView.builder(
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            // padding: EdgeInsets.zero,
            itemCount: allAntiboigrammes.length,
            itemBuilder: (context, index) {

            },

          )
          ;
        },),
    );
  }

}