import 'dart:developer';
import 'dart:ffi';
import 'dart:io';

import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:prolab_mobile/data/models/dossier_analyse_model.dart';
import 'package:prolab_mobile/data/models/Action.dart';
import 'package:prolab_mobile/src/features/dossier_detail/detail_bloc/dossier_detail_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/constants/my_colors.dart';
import '../../../core/util/util_functions.dart';
import '../../../data/models/dossier_detail.dart';
import '../../../data/repository/dossier_repository.dart';
import '../../../data/web_services/dossier_web_services.dart';
import '../parametre/test_page.dart';
import 'antiboigramme_screen.dart';
import 'package:device_info_plus/device_info_plus.dart';

import 'email_bloc/email_bloc.dart';

@RoutePage()
class DossierDetail extends StatefulWidget {
  final DossierDto dossierAnalyse;
  const DossierDetail(
    this.dossierAnalyse, {
    super.key,
  });
  @override
  _DossierDetailState createState() => _DossierDetailState();
}

class _DossierDetailState extends State<DossierDetail> {
  bool _isLoading = true;
  final List<Color> _colors = [
    Colors.white,
    Colors.black,
    Colors.grey,
    Colors.amber,
    Colors.red
  ];

  int x = 0;

  _DossierDetailState();

  final PageController _pageController = PageController(initialPage: 0);

  @override
  void initState() {
    log("elseeee");

    super.initState();
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

  Future<String?> getDeviceId() async {
    String deviceIdentifier = '';
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      final AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      deviceIdentifier = androidInfo.id;
    } else if (Platform.isIOS) {
      final IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      deviceIdentifier = iosInfo.identifierForVendor!;
    }
    return deviceIdentifier;
    /*
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    return androidInfo.id; // Retourne l'ID unique de l'appareil
     */
  }

  @override
  Widget build(BuildContext context) {
    var iconSex;
    bool verifgsmP = false;
    bool veriftelP = false;
    List<String?> listMedecin = [];
    List<String?> listPatient = [];

    return BlocConsumer<DossierDetailBloc, DossierDetailBlocState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (context.read<DossierDetailBloc>().state.isLoadingDetail)
            return Scaffold(
                appBar: AppBar(
                  backgroundColor: MyColors.colorPrimary,
                  centerTitle: true,
                  title: Column(children: [
                    Text(
                      'Détails du Dossier',
                      style: TextStyle(color: MyColors.grayClair),
                    ),

                  ]),
                ),
                body: Center(child: CircularProgressIndicator()));
          else {
            final dossier = state.dossierAnalyse;
            // if (state.dossierAnalyse==null )
            if (dossier.dossierAnalyse?.patient!.tel != null) {
              if (dossier.dossierAnalyse!.patient!.tel!.trim().isNotEmpty) {
                veriftelP = true;
                listPatient.add(dossier.dossierAnalyse!.patient!.tel);
              }
            }
            if (dossier.dossierAnalyse?.patient!.gsm != null) {
              if (dossier.dossierAnalyse!.patient!.gsm!.trim().isNotEmpty) {
                verifgsmP = true;
                listPatient.add(dossier.dossierAnalyse!.patient!.gsm);
              }
            }
            bool verifgsmM = false;
            bool veriftelM = false;
            if (dossier.dossierAnalyse?.medecin!.tel != null) {
              if (dossier.dossierAnalyse!.medecin!.tel!.trim().isNotEmpty) {
                veriftelM = true;
                listMedecin.add(dossier.dossierAnalyse!.medecin!.tel);
              }
            }
            if (dossier.dossierAnalyse?.medecin!.gsm != null) {
              if (dossier.dossierAnalyse!.medecin!.gsm!.trim().isNotEmpty) {
                verifgsmM = true;
                listMedecin.add(dossier.dossierAnalyse!.medecin!.gsm);
              }
            }

            List<String> actions = [];
            actions.add("Autre Email");
            actions.add("Publier resultat");
            List<String> ActionProlab = [
              "MAIL_MEDECIN",
              "MAIL_PATIENT",
              "MAIL",
              "SMS_MEDECIN",
              "SMS_PATIENT",
              "ONLINE"
            ];

            for (final action in ActionProlab) {
              String actionName = "";
              switch (action) {
                case "MAIL_MEDECIN":
                  if (dossier.dossierAnalyse?.medecin!.mail != null) {
                    if (dossier.dossierAnalyse!.medecin!.mail!.isNotEmpty) {
                      actionName = action;
                      actions.add("Email Médecin");
                    }
                  }
                  break;
                case "MAIL_PATIENT":
                  if (dossier.dossierAnalyse?.patient!.mail != null) {
                    if (dossier.dossierAnalyse!.patient!.mail!.isNotEmpty) {
                      actionName = action;
                      actions.add("Email Patient");
                    }
                  }
                  break;
                case "SMS_MEDECIN":
                  if (dossier.dossierAnalyse?.medecin!.gsm != null) {
                    if (dossier.dossierAnalyse!.medecin!.gsm!
                        .trim()
                        .isNotEmpty) {
                      actionName = action;
                      actions.add("SMS Médecin");
                    }
                  }
                  break;
                case "SMS_PATIENT":
                  if (dossier.dossierAnalyse?.patient!.gsm != null) {
                    if (dossier.dossierAnalyse!.patient!.gsm!
                        .trim()
                        .isNotEmpty) {
                      actionName = action;
                      actions.add("SMS Patient");
                    }
                  }
                  break;
                default:
                  actionName = action;
                  break;
              }
            }

            List<String> SenderType = ["Prolab_Mobile", "Prolab"];
            if ((dossier.dossierAnalyse?.patient?.titre?.toUpperCase().trim() ==
                "MR")) {
              iconSex = "patient_male.png";
            } else if ((dossier.dossierAnalyse?.patient?.titre
                        ?.toUpperCase()
                        .trim() ==
                    "MME") ||
                (dossier.dossierAnalyse?.patient?.titre?.toUpperCase().trim() ==
                    "MLLE")) {
              iconSex = "patient_female.png";
            } else if ((dossier.dossierAnalyse?.patient?.titre
                        ?.toUpperCase()
                        .trim() ==
                    "ENF") ||
                (dossier.dossierAnalyse?.patient?.titre?.toUpperCase().trim() ==
                    "BB")) {
              iconSex = "patient_child.png";
            }
            int ATB = 0;
            if (dossier.ATB != null) {
              ATB = dossier.ATB!;
            }
            List<String> listACT;
            var dropdownValue;

            var colorValide = MyColors.colorPrimary;
            bool showValide = MediaQuery.of(context).viewInsets.bottom != 0;
            log(dossier.dossierAnalyse.toString());
            log("zzzzzzzzz");

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
                        // _updatePage(false),
                        context.read<DossierDetailBloc>()
                          ..add(
                              LoadDetailPreviousEvent(dossier.dossierAnalyse!)),
                      },
                      icon: const Icon(Icons.arrow_back),
                      color: MyColors.white,
                    ),
                    IconButton(
                      onPressed: () => {
                        //_updatePage(true),
                        context.read<DossierDetailBloc>()
                          ..add(LoadDetailNextEvent(dossier.dossierAnalyse!)),
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
                        height: MediaQuery.of(context).size.height * 0.20,
                        child: Column(children: [
                          Row(children: [
                            Text("${dossier.dossierAnalyse?.nenreg}   ",
                                style: const TextStyle(
                                    color: MyColors.colorPrimary,
                                    fontSize: 12)),
                            Expanded(
                              child: Text(
                                "${DateTime.parse(dossier.dossierAnalyse!.datePrelevement!).year}-${DateTime.parse(dossier.dossierAnalyse!.datePrelevement!).month}-${DateTime.parse(dossier.dossierAnalyse!.datePrelevement!).day}",
                                maxLines: 1,
                                style: const TextStyle(fontSize: 12),
                              ),
                            ),
                            BlocBuilder<DossierDetailBloc,
                                DossierDetailBlocState>(buildWhen: (p, s) {
                              return p.valide != s.valide;
                            }, builder: (context, state) {
                              if (context
                                  .read<DossierDetailBloc>()
                                  .state
                                  .signer) {
                                return ClipRRect(
                                  borderRadius: BorderRadius.circular(8.0),
                                  child: Image.asset(
                                    'assets/images/certificate.png',
                                    height: 20.0,
                                    width: 20.0,
                                  ),
                                );
                              } else
                                return SizedBox();
                            }),
                            BlocBuilder<DossierDetailBloc,
                                DossierDetailBlocState>(buildWhen: (p, s) {
                              return p.valide != s.valide;
                            }, builder: (context, state) {
                              if (context
                                  .read<DossierDetailBloc>()
                                  .state
                                  .valide) {
                                return ClipRRect(
                                  borderRadius: BorderRadius.circular(8.0),
                                  child: Image.asset(
                                    'assets/images/check.png',
                                    height: 20.0,
                                    width: 20.0,
                                  ),
                                );
                              } else
                                return SizedBox();
                            }),
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
                                    width:
                                        MediaQuery.of(context).size.width * 0.2,
                                    alignment: Alignment.center,
                                    child: Text(
                                      "${dossier.dossierAnalyse!.getAge()} ",
                                      textAlign: TextAlign.center,
                                    )),
                                SizedBox(height: 15,),
                                Row(
                                  children: [
                                    GestureDetector(
                                      child: Container(
                                        alignment: Alignment.centerLeft,
                                        child:  Image.asset(
                                          'assets/images/trombone.png',
                                          fit: BoxFit.fill,),

                                      ),
                                      onTap: ()
                                      {
                                        Navigator.of(context).push(_createRoute(TestPage()));
                                      },
                                    ),
                                    GestureDetector(
                                      child: Container(
                                        alignment: Alignment.centerLeft,
                                        child:  Image.asset(
                                          'assets/images/trombone.png',
                                          fit: BoxFit.fill,),

                                      ),
                                      onTap: ()
                                      {
                                        Navigator.of(context).push(_createRoute(TestPage()));

                                      },
                                    ),
                                  ],
                                ),



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
                                          if (dossier.dossierAnalyse!.cnam ==
                                              true)
                                            TextSpan(
                                                text: "CNAM",
                                                style: const TextStyle(
                                                    color: MyColors.orangeDark,
                                                    fontSize: 14)),
                                          if (dossier.dossierAnalyse!.cnam ==
                                              false)
                                            TextSpan(
                                                text:
                                                    "${dossier.dossierAnalyse!.typePatient}",
                                                style: const TextStyle(
                                                    color: MyColors.orangeDark,
                                                    fontSize: 14)),
                                        ]),
                                      ),
                                      if (veriftelP || verifgsmP)

                                        //if (veriftelP || verifgsmP)
                                        InkWell(
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                          child: Image.asset(
                                            'assets/images/phonecall.png',
                                            height: 20.0,
                                            width: 20.0,
                                          ),
                                          onTap: () {
                                            if (veriftelP || verifgsmP) {
                                              log("calllllllllll patient");
                                              callAlert(context, listPatient);
                                            }
                                          },
                                        ),
                                    ],
                                  ),

                                  Container(
                                    padding: EdgeInsets.only(top: 4),
                                    child: Row(
                                      children: [
                                        if (dossier.dossierAnalyse!.medecin!
                                                .nomPrenom
                                                ?.trim() !=
                                            "")
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
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
                                          //if (veriftelM || verifgsmM)
                                          InkWell(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                            child: Image.asset(
                                              'assets/images/phonecall.png',
                                              height: 20.0,
                                              width: 20.0,
                                            ),
                                            onTap: () {
                                              if (veriftelM || verifgsmM) {
                                                callAlert(context, listMedecin);
                                              }
                                            },
                                          ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.7,
                                    alignment: Alignment.bottomRight,
                                    child: DropdownButton<String>(
                                      value: dropdownValue,
                                      icon: Icon(Icons.more_horiz),
                                      items: actions
                                          .map<DropdownMenuItem<String>>(
                                              (String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 30.0),
                                            child: Row(
                                              children: [
                                               (value == "Autre Email") ? Icon(Icons.mail_rounded) :
                                              getIcon( value), // Replace with the desired icon for each item
                                                SizedBox(
                                                    width:
                                                        20), // Add some space between the icon and text
                                                Text(value),
                                              ],
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                      onChanged: (String? value) async {
                                        String? deviceId = await getDeviceId();
                                        log(value.toString());
                                        if (value == "Autre Email") {
                                          EmailAlert(context,
                                              dossier.dossierAnalyse!.nenreg,  dossier.dossierAnalyse!.solde!);
                                        } else if (value ==
                                            "Publier resultat") {
                                          context.read<DossierDetailBloc>()
                                            ..add(AddActionEvent(

                                                SenderType[0],
                                                dossier.dossierAnalyse!.nenreg!,
                                                dossier.dossierAnalyse!.solde!,
                                                "ONLINE",
                                                0,
                                                deviceId!,
                                                "",
                                                "sysAdmin"));
                                          AlertJob(
                                              context,
                                              context
                                                  .read<DossierDetailBloc>()
                                                  .state
                                                  .succesJob);
                                        } else if (value == "SMS Patient") {
                                          context.read<DossierDetailBloc>()
                                            ..add(AddActionEvent(

                                                SenderType[0],
                                                dossier.dossierAnalyse!.nenreg!,
                                                dossier.dossierAnalyse!.solde!,
                                                "SMS_PATIENT",
                                                0,
                                                deviceId!,
                                                dossier.dossierAnalyse!.patient!
                                                    .gsm!!,
                                                "sysAdmin"));
                                          AlertJob(
                                              context,
                                              context
                                                  .read<DossierDetailBloc>()
                                                  .state
                                                  .succesJob);
                                        } else if (value == "SMS Médecin") {
                                          context.read<DossierDetailBloc>()
                                            ..add(AddActionEvent(

                                                SenderType[0],
                                                dossier.dossierAnalyse!.nenreg!,
                                                dossier.dossierAnalyse!.solde!,
                                                "SMS_MEDECIN",
                                                0,
                                                deviceId!,
                                                dossier.dossierAnalyse!.medecin!
                                                    .gsm!!,
                                                "sysAdmin"));
                                          AlertJob(
                                              context,
                                              context
                                                  .read<DossierDetailBloc>()
                                                  .state
                                                  .succesJob);
                                        } else if (value == "Email Patient") {
                                          context.read<DossierDetailBloc>()
                                            ..add(AddActionEvent(

                                                SenderType[0],
                                                dossier.dossierAnalyse!.nenreg!,
                                                dossier.dossierAnalyse!.solde!,
                                                "MAIL_PATIENT",
                                                0,
                                                deviceId!,
                                                dossier.dossierAnalyse!.patient!
                                                    .mail!!,
                                                "sysAdmin"));
                                          AlertJob(
                                              context,
                                              context
                                                  .read<DossierDetailBloc>()
                                                  .state
                                                  .succesJob);
                                        } else if (value == "Email Médecin") {
                                          context.read<DossierDetailBloc>()
                                            ..add(AddActionEvent(

                                                SenderType[0],
                                                dossier.dossierAnalyse!.nenreg!,
                                                dossier.dossierAnalyse!.solde!,
                                                "MAIL_MEDECIN",
                                                0,
                                                deviceId!,
                                                dossier.dossierAnalyse!.medecin!
                                                    .mail!!,
                                                "sysAdmin"));

                                          AlertJob(
                                              context,
                                              context
                                                  .read<DossierDetailBloc>()
                                                  .state
                                                  .succesJob);
                                        }
                                      },
                                    ),
                                  ),
                                  if(ATB>0)
                                    Positioned(
                                      bottom: 16.0,
                                      right: 0.0,
                                      child: FloatingActionButton(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(50.0),
                                        ),
                                        onPressed: () {
                                         Navigator.push(
                                            context,
                                            MaterialPageRoute(builder: (context) => Antiboigramme_screen(dossier)),
                                          );
                                        },
                                        child: Image.asset(
                                          'assets/images/bacteria.png',
                                          height: 900.0,
                                          width: 500.0,
                                        ),
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
                /*
          floatingActionButton: AnimatedSwitcher(
            duration: Duration(milliseconds: 300),
            child: 2==2
                ? FloatingActionButton.extended(
              key: ValueKey('extended'),
              onPressed: () {
                // Ajoutez votre logique ici
                print('Floating Action Button Pressed');
              },
              label: Text('Ajouter'),
              icon: Icon(Icons.add),
              backgroundColor: Colors.purple,
            )
                : FloatingActionButton(
              key: ValueKey('normal'),
              onPressed: () {
                // Ajoutez votre logique ici
                print('Floating Action Button Pressed');
              },
              child: Icon(Icons.add),
              backgroundColor: Colors.purple,
            ),),
*/

                floatingActionButton: Visibility(
                    visible: !showValide,
                    child:
                        BlocBuilder<DossierDetailBloc, DossierDetailBlocState>(
                            buildWhen: (p, s) {
                      return p.valide != s.valide;
                    }, builder: (context, state) {
                      return FloatingActionButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40)),
                        backgroundColor:
                            context.read<DossierDetailBloc>().state.valide
                                //(dossier.dossierAnalyse!.statut! & 4) > 0
                                ? colorValide = Color(0xFF00FF00)
                                : colorValide = MyColors.greyMed,
                        onPressed: () async {
                          var res = showAlertDialog(
                              context,
                              context.read<DossierDetailBloc>().state.valide
                                  ? 1
                                  : 0);
                        },
                        child:
                            Icon(Icons.check, color: MyColors.white, size: 40),
                      );
                    })));
          }
        });
  }

  void callAlert(BuildContext contextt, List<String?> list) {
    // show the dialog
    showDialog(
        context: contextt,
        builder: (BuildContext context2) {
          return BlocProvider.value(
              value: BlocProvider.of<DossierDetailBloc>(contextt),
              child: BlocBuilder<DossierDetailBloc, DossierDetailBlocState>(
                  builder: (context, state) {
                return AlertDialog(
                  title: Text(
                    "Appeler",
                    style: TextStyle(color: Colors.black, fontSize: 18),
                  ),
                  content: Container(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        InkWell(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.asset(
                            'assets/images/phonecall.png',
                            height: 20.0,
                            width: 20.0,
                          ),
                          onTap: () {},
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        for (final i in list)
                          GestureDetector(
                            child: Text(
                              "${i}   ",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 18),
                            ),
                            onTap: () async {
                              // Requesting permission
                              if (await _requestPhonePermission()) {
                                _launchPhoneNumber(i!);
                              } else {
                                // Handle permission denied
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: Text('Permission refusée'),
                                    content: Text(
                                        'Veuillez accepter la permission de passer un appel téléphonique.'),
                                    actions: [
                                      TextButton(
                                        onPressed: () => Navigator.pop(context),
                                        child: Text('OK'),
                                      ),
                                    ],
                                  ),
                                );
                              }

                              /*  if (await canLaunch("tel:25192799")) {
                                  await launch("25192799");
                                } else {
                                  throw 'Could not launch ';
                                }
                                  } else {
                                    // Permission denied
                                    // Handle the case where the user denies permission
                                  }
                        */
                            },
                          ),
                      ],
                    ),
                  ),
                );
              }));
        });
  }

  void EmailAlert(BuildContext contextt, String? nenreg , double solde) async {
    TextEditingController mycontroller = new TextEditingController();
    late String valueRecherche = "";
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    List<String> SenderType = ["Prolab_Mobile", "Prolab"];

    // show the dialog
    showDialog(
        context: contextt,
        builder: (BuildContext context2) {
          /*
          return BlocProvider.value(
              value: BlocProvider.of<DossierDetailBloc>(contextt),
              child: BlocBuilder<DossierDetailBloc, DossierDetailBlocState>(
                  builder: (context, state) {
                    */

          return AlertDialog(
              title: Text(
                "Autre Email",
                style: TextStyle(color: Colors.black, fontSize: 18),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  BlocProvider.value(
                    value: BlocProvider.of<EmailBloc>(contextt),
                    child: BlocBuilder<EmailBloc, EmailState>(
                        builder: (context, state) {
                      return TextFormField(
                          //initialValue:(comment!=null)? comment:"",
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            filled: true,
                            labelText: 'Adresse E-mail',
                            //   fillColor: const Color(0xfff1f1f1),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide.none,
                            ),
                            hintText: "Adresse E-mail",
                          ),
                          onChanged: (value) {
                            valueRecherche = value;

                            context.read<EmailBloc>().add(EmailChanged(value));
                          });
                    }),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  // textColor: Colors.purple,
                  onPressed: () => {
                    mycontroller.clear(),
                    Navigator.of(context2).pop(),
                  },
                  child: const Text('Annuler'),
                ),
                TextButton(
                  onPressed: () async {
                    log(valueRecherche);

                    if (context.read<EmailBloc>().state is EmailValid) {
                      String? deviceId = await getDeviceId();

                      context.read<DossierDetailBloc>()
                        ..add(AddActionEvent(
                             SenderType[0],
                            nenreg!,
                            solde,
                            "MAIL",
                            0,
                            deviceId!,
                            valueRecherche,
                            "sysAdmin"));
                      Navigator.pop(context2);
                      AlertJob(context,
                          context.read<DossierDetailBloc>().state.succesJob);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Adresse mail invalide!'),
                          backgroundColor: Colors.red,
                          duration: Duration(seconds:1),
                        ),
                      );
                    }
                  },
                  child: Text('Valider'),
                )
              ]);
          // }));
        });
  }

  _launchPhoneNumber(String phoneNumber) {
    try {
      if (Platform.isAndroid) {
        // For Android, use the ACTION_DIAL Intent
        launch('tel:$phoneNumber');
      } else if (Platform.isIOS) {
        // For iOS, use the 'tel' URL scheme
        launch('tel:$phoneNumber');
      }
    } catch (e) {
      throw 'Could not launch $phoneNumber';
    }
  }

  Future<bool> _requestPhonePermission() async {
    if (Platform.isAndroid) {
      var status = await Permission.phone.status;
      if (status.isDenied || status.isPermanentlyDenied) {
        // You can use openAppSettings method to redirect user to app settings
        await openAppSettings();
        // Return false as permission is not yet granted
        return false;
      } else {
        return true;
      }
      /*  var status = await Permission.phone.status;
      if (status.isDenied || status.isPermanentlyDenied) {
        // You can use request method if permission is not granted
        var result = await Permission.phone.request();
        if (result == PermissionStatus.granted) {
          return true;
        } else {
          return false;
        }
      }else {
        return true;
      }
      */
    } else {
      // No permission needed for iOS
      return true;
    }
  }

  Route _createRoute(dynamic Page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => Page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(-1.0, 0.0); // Change to left-to-right animation
        const end = Offset.zero;
        const curve = Curves.ease;

        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        var offsetAnimation = animation.drive(tween);

        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
    );
  }

 Widget getIcon(String value) {
    if (value ==
   "Publier resultat")
      {
        return Icon(Icons.pending_actions);
      }
    else if (value == "SMS Patient")
      {return Icon(Icons.sms_outlined); }
    else if (value == "SMS Médecin") {
      return Icon(Icons.sms_outlined);
    }else if (value == "Email Patient"){
      return Icon(Icons.outgoing_mail);
    } else if (value == "Email Médecin") {
      return Icon(Icons.outgoing_mail);
    }


      return Icon(Icons.pending_actions) ;
 }
}

showAlertDialog(BuildContext contextt, int action) {
  // show the dialog

  showDialog(
      context: contextt,
      builder: (BuildContext context2) {
        return BlocProvider.value(
            value: BlocProvider.of<DossierDetailBloc>(contextt),
            child: BlocBuilder<DossierDetailBloc, DossierDetailBlocState>(
                builder: (context, state) {
              return AlertDialog(
                  title: action == 0
                      ? Text(
                          "Voulez-vous vraiment valider ce dossier ? ",
                          style: TextStyle(color: Colors.black, fontSize: 18),
                        )
                      : Text(
                          "Voulez-vous vraiment annuler la validation de ce dossier ? ",
                          style: TextStyle(color: Colors.black, fontSize: 18),
                        ),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[],
                  ),
                  actions: [
                    TextButton(
                      // textColor: Colors.purple,
                      onPressed: () => {Navigator.pop(context2)},
                      child: const Text('Non'),
                    ),
                    TextButton(
                      onPressed: () async {
                        // api valider
                        context.read<DossierDetailBloc>()
                          ..add(SwitchValideEvent());
                        // result=action+1;
                        Navigator.pop(context2);
                      },
                      child: Text('Oui'),
                    )
                  ]);
            }));
      });
  // return 0 pas d'action , return 1 api valider , return 2 annuler validation
  //return result;
}

AlertJob(BuildContext contextt, int x) {
  // show the dialog

  showDialog(
      context: contextt,
      builder: (BuildContext context2) {
        return BlocProvider.value(
            value: BlocProvider.of<DossierDetailBloc>(contextt),
            child: BlocBuilder<DossierDetailBloc, DossierDetailBlocState>(
                builder: (context, state) {
              return AlertDialog(
                  title: Text(
                    "Information",
                    style: TextStyle(color: Colors.black, fontSize: 18),
                  ),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      if (x == 1)
                        Text(
                          "L’opération est en cours de traitement dans le serveur",
                          style: TextStyle(color: Colors.black, fontSize: 18),
                        ),
                      if (x == 0)
                        Text(
                          "Erreur d’envoi",
                          style: TextStyle(color: Colors.black, fontSize: 18),
                        ),
                      if (x == -1)
                        Text(
                          "Vérifier solde avant de publier",
                          style: TextStyle(color: Colors.black, fontSize: 18),
                        ),
                    ],
                  ),
                  actions: [
                    TextButton(
                      // textColor: Colors.purple,
                      onPressed: () => {Navigator.pop(context2)},
                      child: const Text('OK'),
                    ),
                  ]);
            }));
      });
  // return 0 pas d'action , return 1 api valider , return 2 annuler validation
  //return result;
}

class DossierItem extends StatelessWidget {
  final Color color;
  late List<DetailCQI> detailDossierAnalyse;
  //late List<DossierAnalyseDetail> detailDossierAnalyse;

  DossierItem(this.color, {super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DossierDetailBloc, DossierDetailBlocState>(
        builder: (context, state) {
      print(state);

      detailDossierAnalyse = (state).details;

      return ListView.builder(
          //  controller: scrollController,
          shrinkWrap: true,
          //physics: const ClampingScrollPhysics(),
          padding: EdgeInsets.zero,
          //itemCount: allDossierAnalyse.length,
          itemCount: detailDossierAnalyse.length,
          itemBuilder: (context, index) {
            if (index < detailDossierAnalyse.length) {
              return DetailItem(detailDossierAnalyse[index].dossierDto,detailDossierAnalyse[index].cqi , color, index);
            } else {
              return Center(child: const CircularProgressIndicator());
            }
          },

      );
    });
  }
}

class DetailItem extends StatelessWidget {
  final int? CQI;
  final DossierAnalyseDetail? detailAnalyse;
  //final DossierAnalyseDetail detailAnalyse;
  final Color color;
  final int index;
  DetailItem(this.detailAnalyse, this.CQI ,this.color, this.index);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        color: color,
        child: Column(children: [
          (detailAnalyse!.estGroupe)
              ? (detailAnalyse!.numGroupe == null ||
                      detailAnalyse!.numGroupe!.trim().isEmpty)
                  ? Container(
                      decoration: BoxDecoration(
                        color: MyColors.colorPrimary,

                        border: Border.all(
                            color: MyColors.colorPrimary,
                            width: 2.0,
                            style: BorderStyle
                                .solid), // no shadow color set, defaults to black
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5)),
                      ),
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.all(2),
                      padding: EdgeInsets.only(
                        left: 2,
                      ),
                      child: Text(
                        "${detailAnalyse!.libelle}",
                        style: TextStyle(

                            color: MyColors.white, fontWeight: FontWeight.bold),
                      ),
                    )
                  : Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        decoration: BoxDecoration(
                          color: MyColors.lightblue,

                          border: Border.all(
                              color: MyColors.lightblue,
                              width: 2.0,
                              style: BorderStyle
                                  .solid), // no shadow color set, defaults to black
                          borderRadius:
                              const BorderRadius.all(Radius.circular(5)),
                        ),
                        margin: EdgeInsets.only(left: 10),
                        padding: EdgeInsets.all(4),
                        child: Text(
                          "${detailAnalyse!.libelle}",
                          style: TextStyle(
                            color: MyColors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    )
              : GestureDetector(
                  onTap: () {
                    context.read<DossierDetailBloc>()
                      ..add(selectDetailEvent(detailAnalyse!));
                    showCommentaireAlertDialog(
                        context,
                        UtilFunctions.rtfToPlain(
                            detailAnalyse!.commentaire!.trim()));
                  },
                  child: Container(

                      // setBackgroundColor(argb(100, 250, 150, 150));
                      margin: (detailAnalyse!.numGroupe != null &&
                              detailAnalyse!.numGroupe!.isNotEmpty)
                          ? EdgeInsets.only(
                              left: 10, top: 4, bottom: 4, right: 2)
                          : EdgeInsets.only(
                              left: 5, top: 4, bottom: 4, right: 2),
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.all(1),
                      decoration: BoxDecoration(
                        color: (detailAnalyse!.horsNorme)
                            ? Color.fromARGB(100, 250, 150, 150)
                            : MyColors.white,
                        //Color.fromARGB(100, 255, 255, 255),

                        border: Border.all(
                            color: MyColors.colorPrimary,
                            width: 2.0,
                            style: BorderStyle
                                .solid), // no shadow color set, defaults to black
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5)),
                      ),
                      child: Column(children: [
                        Padding(
                          padding: const EdgeInsets.all(1.0),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(1),
                                child: Row(children: [
                                  (detailAnalyse!.toControl == true)
                                      ? ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                          child: Image.asset(
                                            'assets/images/warning.png',
                                            height: 20.0,
                                            width: 15.0,
                                          ),
                                        )
                                      : SizedBox(
                                          width: 10,
                                        ),
                                  SizedBox(
                                    width: 3,
                                  ),
                                  SizedBox(
                                    width: 40,
                                    child: Text(
                                      (detailAnalyse!.abreviation!.length < 4)
                                          ? "${detailAnalyse!.abreviation}"
                                          : "${detailAnalyse!.abreviation?.substring(0, 4)}",
                                      style: const TextStyle(
                                        fontSize: 12,
                                        color: MyColors.colorPrimary,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.3,
                                    padding: EdgeInsets.only(left: 2),
                                    child: Text(
                                      "${detailAnalyse!.libelle?.trim()}",
                                      style: const TextStyle(fontSize: 14),
                                    ),
                                  ),
                                  if (detailAnalyse!.resultat?.trim() != null)
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.2,
                                      padding: EdgeInsets.only(left: 2),
                                      child: Text(
                                        "${UtilFunctions.rtfToPlain(detailAnalyse!.resultat!.trim())}",
                                        style: const TextStyle(fontSize: 12),
                                      ),
                                    ),
                                  if (detailAnalyse!.unite1?.trim() != null)
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.1,
                                      padding: EdgeInsets.only(left: 2),
                                      child: Text(
                                        "${detailAnalyse!.unite1?.trim()}",
                                        style: const TextStyle(fontSize: 12),
                                      ),
                                    ),
                                  if (detailAnalyse!.valeurUsuelle?.trim() !=
                                      null)
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.2,
                                      padding: EdgeInsets.only(left: 2),
                                      child: Text(
                                        "${UtilFunctions.rtfToPlain(detailAnalyse!.valeurUsuelle!.trim())}",
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
                            if (detailAnalyse!.anteriorite != null &&
                                detailAnalyse!.anteriorite != "")
                              Expanded(
                                child: Text(
                                  "${detailAnalyse!.anteriorite}\n",
                                  style: const TextStyle(
                                      fontSize: 12,
                                      color: MyColors.colorPrimary),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                          ]),
                        ),
                        /*  BlocBuilder<DossierDetailBloc, DossierDetailBlocState>(
            builder: (context, state) {
              if (detailAnalyse.commentaire?.trim() != null)
             return
               */
                        if(CQI !=0)
                         getTitle(CQI,context),
                        if (detailAnalyse!.commentaire?.trim() != null)
                          Container(
                            width: MediaQuery.of(context).size.width,
                            padding: EdgeInsets.only(left: 2),
                            child: Text(
                              "${UtilFunctions.rtfToPlain(detailAnalyse!.commentaire!.trim())}",
                              //"${UtilFunctions.rtfToPlain(context.read<DossierDetailBloc>().state.commentaire!.trim())}",
                              style: TextStyle(fontSize: 12),
                            ),
                          ),



                        // }),
                      ])),
                ),
        ]),
      ),
    );
  }

  showCommentaireAlertDialog(BuildContext contextt, String comment) {
    // show the dialog
    int result = 0;
    late String valueRecherche = comment;
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
                            initialValue: (comment != null) ? comment : "",

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
                            onChanged: (value) {
                              valueRecherche = value;
                            }),
                        CheckboxMenuButton(
                          value: context.read<DossierDetailBloc>().state.check,
                          onChanged: (value) {
                            context.read<DossierDetailBloc>()
                              ..add(checkboxEvent(!context
                                  .read<DossierDetailBloc>()
                                  .state
                                  .check));
                          },
                          child: Text('Résultat à controler',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 18)),
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
                          log('staaaate');
                          log(valueRecherche);
                          log('staaaate');
                          context.read<DossierDetailBloc>()
                            ..add(FeedBackEvent(valueRecherche,
                                context.read<DossierDetailBloc>().state.check));
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

  getTitle(int? cqi, BuildContext context) {
    if(cqi==1)
      {
        return Container(
            width: MediaQuery.of(context).size.width,
            color:Color(0xFFFFFFC0),
            padding: EdgeInsets.only(left: 2),
            child:  Text(
              " CQI : Conforme" ,
             style: TextStyle(color:Colors.black ),)
        );

      }else if (cqi ==2 ) {
      return  Container(
          width: MediaQuery.of(context).size.width,
          color:Color(0xFFC0E0FF),
          padding: EdgeInsets.only(left: 2),
          child:   Text(
            ' CQI : Avertissement',
            style: TextStyle(color:Colors.black ),
          )
      );

    } else if (cqi == 3) {
      return
        Container(
            width: MediaQuery.of(context).size.width,
            color:Color(0xFFC0C0FF),
            padding: EdgeInsets.only(left: 2),
            child:   Text(
              ' CQI : Alerte',
              style: TextStyle(color:Colors.black ),
            )
        );
    }else
      return
        Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.only(left: 2),
            child:   Text(
              '',

            )
        );
  }
}
