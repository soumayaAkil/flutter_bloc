import 'dart:core';
import 'patient_model.dart';
import 'medecin_model.dart';
class DossierDto {
  DossierAnalyse? dossierAnalyse;
  int? etat;
  bool? acontroler;

  DossierDto({this.dossierAnalyse, this.etat, this.acontroler});

  DossierDto.fromJson(Map<String, dynamic> json) {
    dossierAnalyse = json['dossierAnalyse'] != null
        ? new DossierAnalyse.fromJson(json['dossierAnalyse'])
        : null;
    etat = json['etat'];
    acontroler = json['acontroler'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.dossierAnalyse != null) {
      data['dossierAnalyse'] = this.dossierAnalyse!.toJson();
    }
    data['etat'] = this.etat;
    data['acontroler'] = this.acontroler;
    return data;
  }
}
class DossierAnalyse {
  String? nenreg;
  Patient? patient;
  Medecin? medecin;
  String? titre;
  String? ans;
  String? mois;
  String? jours;
  String? datePrelevement;
  String? dateAdd;
  bool? urgent;
  int? statut;
  int? resultFlag;
  bool? livree;
  bool? cnam;
  double? total;
  double? acompte;
  double? solde;
  String? typePatient;
  int? nbrImpr;
  int? etatPublication;
  bool? signer;
  String? listeAbreviation;
  String? listeAnalysesEnCours;
  String? listeAnalysesTermines;
  String? printState;

  DossierAnalyse(
      {this.nenreg,
      this.patient,
      this.medecin,
      this.titre,
      this.ans,
      this.mois,
      this.jours,
      this.datePrelevement,
      this.dateAdd,
      this.urgent,
      this.statut,
      this.resultFlag,
      this.livree,
      this.cnam,
      this.total,
      this.acompte,
      this.solde,
      this.typePatient,
      this.nbrImpr,
      this.etatPublication,
      this.signer,
      this.listeAbreviation,
      this.listeAnalysesEnCours,
      this.listeAnalysesTermines,
      this.printState});

  DossierAnalyse.fromJson(Map<String, dynamic> json) {
    nenreg = json['nenreg'];
    patient =
        json['patient'] != null ? new Patient.fromJson(json['patient']) : null;
    medecin =
        json['medecin'] != null ? new Medecin.fromJson(json['medecin']) : null;
    titre = json['titre'];
    ans = json['ans'];
    mois = json['mois'];
    jours = json['jours'];
    datePrelevement = json['datePrelevement'];
    dateAdd = json['dateAdd'];
    urgent = json['urgent'];
    statut = json['statut'];
    resultFlag = json['resultFlag'];
    livree = json['livree'];
    cnam = json['cnam'];
    total = json['total'];
    acompte = json['acompte'];
    solde = json['solde'];
    typePatient = json['typePatient'];
    nbrImpr = json['nbrImpr'];
    etatPublication = json['etatPublication'];
    signer = json['signer'];
    listeAbreviation = json['listeAbreviation'];
    listeAnalysesEnCours = json['listeAnalysesEnCours'];
    listeAnalysesTermines = json['listeAnalysesTermines'];
    printState = json['printState'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nenreg'] = this.nenreg;
    if (this.patient != null) {
      data['patient'] = this.patient!.toJson();
    }
    if (this.medecin != null) {
      data['medecin'] = this.medecin!.toJson();
    }
    data['titre'] = this.titre;
    data['ans'] = this.ans;
    data['mois'] = this.mois;
    data['jours'] = this.jours;
    data['datePrelevement'] = this.datePrelevement;
    data['dateAdd'] = this.dateAdd;
    data['urgent'] = this.urgent;
    data['statut'] = this.statut;
    data['resultFlag'] = this.resultFlag;
    data['livree'] = this.livree;
    data['cnam'] = this.cnam;
    data['total'] = this.total;
    data['acompte'] = this.acompte;
    data['solde'] = this.solde;
    data['typePatient'] = this.typePatient;
    data['nbrImpr'] = this.nbrImpr;
    data['etatPublication'] = this.etatPublication;
    data['signer'] = this.signer;
    data['listeAbreviation'] = this.listeAbreviation;
    data['listeAnalysesEnCours'] = this.listeAnalysesEnCours;
    data['listeAnalysesTermines'] = this.listeAnalysesTermines;
    data['printState'] = this.printState;
    return data;
  }
   String getAge() {
    String age = "";
    if (ans == null) ans = "";
    if (mois == null) mois = "";
    if (jours == null) jours = "";
    if (ans=="") ans = "0";
    if (mois=="") mois = "0";
    if (jours=="") jours = "0";
    if (int.parse(ans!) >= 2)
      age = (ans! + " ans")!;
    else if (int.parse(ans!) > 0) {
      age = "Un an";
      if (this.mois != null)
        if (int.parse(mois!) > 0)
          age = age + " et " + mois! + " mois";
    } else if (this.mois != null)
      if (int.parse(mois!) > 0) {
        age = mois! + " mois";
        if (int.parse(jours!) > 0)
          age = age + " et " + jours! + " jours";
      }
    return age;
  }
}



