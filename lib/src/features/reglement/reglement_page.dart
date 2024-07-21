import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prolab_mobile/data/models/dossier_analyse_model.dart';
import 'package:prolab_mobile/data/models/reglement_model.dart';

import '../../../core/constants/my_colors.dart';
import '../home/home_bloc/home_bloc.dart';
import 'bloc/reglement_bloc.dart';

class ReglementScreen extends StatefulWidget {
  const ReglementScreen({
        super.key,
      });
  @override
  _ReglementState createState() => _ReglementState();
}

class _ReglementState extends State<ReglementScreen> {
  late List<Reglement> allRegs;
  _ReglementState();


  @override
  void initState() {
    context
        .read<ReglementBloc>()
        .add(LoadRegEvent(context
        .read<HomeBloc>()
        .state
        .startDate,context
        .read<HomeBloc>()
        .state
        .endDate, ));

    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    var dropdownValue;

    return

      BlocBuilder<ReglementBloc, ReglementState>(
        builder: (context, state) {
          allRegs = (state).regs;
          if ((state).regs != null) {
          return Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              // padding: EdgeInsets.zero,
              itemCount: allRegs.length,
              itemBuilder: (context, index) {
                if (index < allRegs.length) {
                  return RegItem(
                      allRegs[index]);
                } else {
                  return Center(
                      child: const Text("no more data to load "));
                }
              },

            ),
          )
          ;}
          else if ((state).isLoadingReg == false)
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
        },
    );
  }

}

class RegItem extends StatelessWidget {
  final Reglement reg;


  const RegItem(this.reg, {super.key});
   String getTypePieceName(String? typePiece) {
  switch

  (

  typePiece?.toUpperCase()

  ){
  case "D":
  return "Dossier";
  case "F":
  return "Facture";
  default:return "";
  }
}
  @override
  Widget build(BuildContext context) {
    ScrollController scrollController = ScrollController();
    return   BlocListener<HomeBloc, HomeState>(
        listener: (context, value) {
          context
          .read<ReglementBloc>()
          .add(LoadRegEvent(context
          .read<HomeBloc>()
          .state
          .startDate,context
          .read<HomeBloc>()
          .state
          .endDate, ));


      final position = scrollController.position.minScrollExtent;
      scrollController.animateTo(
        //duration of scrolling up
        duration: Duration(milliseconds: 400),
        position,
        //animation style
        curve: Curves.linear,
      );

    } ,
    child:
      BlocBuilder<ReglementBloc, ReglementState>(
        builder: (context, state) {
            return Container(
                width: double.infinity,

                padding: const EdgeInsets.all(4),

                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Container(
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: MyColors.grayClair,
                    border: Border.all(
                        color: MyColors.colorPrimary,
                        width: 2.0,
                        style: BorderStyle
                            .solid), // no shadow color set, defaults to black
                    borderRadius: const BorderRadius.all(Radius.circular(5)),
                  ),
                  alignment: Alignment.topLeft,
                  width: double.infinity,
                  margin: const EdgeInsets.only(left: 8.0, right: 8.0),
                  child: Column(children: [

                    Container(
                      child:
                      Row(
                        // mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            alignment: AlignmentDirectional.bottomStart,
                            width: MediaQuery
                                .of(context)
                                .size
                                .width * 0.4,
                            child: Text("${reg.nomClient}",),

                          ), Container(
                            alignment: AlignmentDirectional.centerStart,
                            width: MediaQuery
                                .of(context)
                                .size
                                .width * 0.3,
                            child: Text(
                              "Mnt ${getTypePieceName(reg.typePiece)}",),

                          ), Container(
                            alignment: AlignmentDirectional.bottomEnd,
                            width: MediaQuery
                                .of(context)
                                .size
                                .width * 0.2,
                            child: Text("${reg.mntPiece?.toStringAsFixed(3)}",
                              style: TextStyle(fontWeight: FontWeight.bold),),

                          ),
                        ],
                      ),),
                    Container(
                      child:
                      Row(
                        // mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            alignment: AlignmentDirectional.bottomStart,
                            width: MediaQuery
                                .of(context)
                                .size
                                .width * 0.4,
                            child: Text("N° ${reg.numPiece}",),

                          ), Container(
                            alignment: AlignmentDirectional.centerStart,
                            width: MediaQuery
                                .of(context)
                                .size
                                .width * 0.3,
                            child: Text(
                              "${reg.modePaiement}", style: TextStyle(),),

                          ), Container(
                            alignment: AlignmentDirectional.bottomEnd,
                            width: MediaQuery
                                .of(context)
                                .size
                                .width * 0.2,
                            child: Text("${reg.mntReg?.toStringAsFixed(3)}",
                              style: TextStyle(
                                  color: (reg.mntReg! < 0) ? Colors.red : Colors
                                      .green, fontWeight: FontWeight.bold),),

                          ),
                        ],
                      ),

                    ),

                    Container(
                      alignment: Alignment.centerLeft,
                      child:
                      Row(
                        // mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            alignment: AlignmentDirectional.bottomStart,
                            width: MediaQuery
                                .of(context)
                                .size
                                .width * 0.4,
                            child: Text("${reg.dateReg?.substring(0, 16)}",
                              style: TextStyle(color: Colors.grey),),

                          ), if (reg.mntSoldePiece != 0)
                            Container(
                              child: Row(
                                children: [
                                  Container(
                                    alignment: AlignmentDirectional.centerStart,
                                    width: MediaQuery
                                        .of(context)
                                        .size
                                        .width * 0.3,
                                    child: Text("Reste", style: TextStyle(),),
                                  ),
                                  Container(
                                    alignment: AlignmentDirectional.bottomEnd,
                                    width: MediaQuery
                                        .of(context)
                                        .size
                                        .width * 0.2,
                                    child: Text(
                                      "${reg.mntSoldePiece?.toStringAsFixed(
                                          3)}", style: TextStyle(
                                        color: Colors.red,
                                        fontWeight: FontWeight.bold),),

                                  ),
                                ],
                              ),

                            ),
                        ],
                      ),

                    ),


                  ]),
                ));

        }
    ),
    );
   }
}


