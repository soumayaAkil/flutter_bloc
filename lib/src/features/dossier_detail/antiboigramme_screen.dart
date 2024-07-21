import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prolab_mobile/data/models/dossier_analyse_model.dart';

import '../../../core/constants/my_colors.dart';
import '../../../core/util/util_functions.dart';
import '../../../data/models/antibiogramme.dart';
import 'detail_bloc/dossier_detail_bloc.dart';
class Antiboigramme_screen extends StatefulWidget {
  final DossierDto dossierAnalyse;
  const Antiboigramme_screen(
      this.dossierAnalyse, {
        super.key,
      });
  @override
  _AntiboigrammeState createState() => _AntiboigrammeState(this.dossierAnalyse);
}

class _AntiboigrammeState extends State<Antiboigramme_screen> {
  late final DossierDto dossier;
  late List<Antibiogramme> allAntiboigrammes;
  bool _isLoading = true;
  int x = 0;
  _AntiboigrammeState(this.dossier);

  final PageController _pageController = PageController(initialPage: 0);

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
              if (index < allAntiboigrammes.length) {
              return ATBItem(
              allAntiboigrammes[index]);
              } else {
              return Center(
              child: const Text("no more data to load "));
              }
              },

              )
                  ;
            },),
            );
}

}

class ATBItem extends StatelessWidget {
  final Antibiogramme ATB;


  const ATBItem(this.ATB, {super.key});

  @override
  Widget build(BuildContext context) {
    late String valueComment = "";
    TextEditingController mycontroller = new TextEditingController();
    return Container(
      //width: double.infinity,
     // margin: const EdgeInsets.only(left: 8.0, right: 8.0),
      padding: const EdgeInsets.all(4),

      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Container(
        /*
        decoration: BoxDecoration(
            color: MyColors.greyMed,
            borderRadius: const BorderRadius.all(Radius.circular(10))),
        */

        child: Column(children: [
          Container(


 height: 50,
 /*
            alignment: Alignment.topLeft,*/
            child: Text("${ATB.libelle}: ${ATB.Prelevement}",style: TextStyle(fontWeight: FontWeight.bold)),
          ),
                Container(

                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    //padding: EdgeInsets.zero,
                    //itemCount: allDossierAnalyse.length,
                    itemCount: ATB.details!.length,
                    itemBuilder: (context, index) {

                      if (index < ATB.details!.length) {
                        return ATBItemDetail(
                            ATB.details![index]);
                      }
                    },
                  ),
                ),
          GestureDetector(
            onTap: () {
              showCommentaireAlertDialog(context);
            },
            child:
          Row(
            children: [
              Container(

                  alignment: Alignment.topLeft,
                  child:Text("Remarques : ",style: TextStyle(fontWeight: FontWeight.bold),),

              ),
           Container(

              alignment: Alignment.topLeft,
              child:Text("${context
                  .read<DossierDetailBloc>().state.commentaire}",style: TextStyle(fontWeight: FontWeight.bold),),

          ),
            ],
          ),

          ),


      ]),
      ),
    );
  }
  showCommentaireAlertDialog(BuildContext contextt) {
    // show the dialog
    int result = 0;
    late String valueComment = "";
    showDialog(
        context: contextt,
        builder: (BuildContext context2) {
          TextEditingController mycontroller = new TextEditingController();
          return BlocProvider.value(
              value: BlocProvider.of<DossierDetailBloc>(contextt),
              child: BlocBuilder<DossierDetailBloc, DossierDetailBlocState>(
                  builder: (context, state) {
                    return AlertDialog(
                        title: Text(
                          "Voulez-vous ajouter un commantaire ? ",
                          style: TextStyle(color: Colors.black, fontSize: 18),
                        ),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            TextFormField(
                          initialValue: ( context.read<DossierDetailBloc>().state.commentaire!=null)? context.read<DossierDetailBloc>().state.commentaire:"",
                                onChanged: (value) {
                                  valueComment = value;
                                },
                               // controller: mycontroller,
                                // decoration: InputDecoration(hintText: "Enter your input here"),
                                decoration: InputDecoration(
                                  filled: true,
                                  labelText: 'Commentaire',
                                  //   fillColor: const Color(0xfff1f1f1),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide.none,
                                  ),
                                  hintText: "Commentaire",
                                ),
                               /* onSubmitted: (value) {
                                  valueRecherche = value;
                                }),

                                */
                            ),
                          ],
                        ),
                        actions: [
                          TextButton(
                            // textColor: Colors.purple,
                            onPressed: () =>
                            {mycontroller.clear(), Navigator.pop(context2)},
                            child: const Text('Annuler'),
                          ),
                          TextButton(
                            onPressed: () async {

                             /* context.read<DossierDetailBloc>()
                                ..add(FeedBackEvent(valueRecherche,
                                    context.read<DossierDetailBloc>().state.check));
                              */
                              context
                                  .read<DossierDetailBloc>()
                                  .add(UpdateATBEvent(valueComment));

                              Navigator.pop(context2);
                            },
                            child: Text('Valider'),
                          )
                        ]);
                  }));
        });
    // return 0 pas d'action , return 1 api valider , return 2 annuler validation
    return result;
  }
}

  class ATBItemDetail extends StatelessWidget {
    final AntibiogrammeDetail ATBDetail;

    const ATBItemDetail(this.ATBDetail, {super.key});

    @override
    Widget build(BuildContext context) {
      return Container(
        width: double.infinity,
        margin: const EdgeInsets.only(left: 8.0),
        padding: const EdgeInsets.all(4),

        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            Container(
            margin: const EdgeInsets.symmetric(vertical: 3),

              child: Row(children: [
                Container(
                  width: MediaQuery
                      .of(context)
                      .size
                      .width * 0.70,
                  alignment: Alignment.topLeft,
                  child: Text("${ATBDetail.Libelle}"),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Text((ATBDetail.Resultat != null) ?
                  "${convertResult(ATBDetail.Resultat)}"
                      : " ", style: TextStyle(color: MyColors.colorPrimary)),
                ),

              ]),
            ),
            Container(
              height: 2,
              color: MyColors.greyMed,
            ),
          ],
        ),

      );
    }

    String convertResult(String? res) {
      if (res != null) {
        switch (res.toUpperCase()) {
          case "S":
            return "SENSIBLE";
          case "R":
            return "Résistant";
          case "In":
            return "Intermédiaire";
          case "RB":
            return "Resistant Bas";
          case "SB":
            return "SENSIBLE Bas";
          default:
            return res;
        }
      } else {
        return "";
      }
    }
  }