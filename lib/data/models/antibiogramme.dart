
 import 'dart:core';

class Antibiogramme {
  int? numAtb;
  String? code;
  String? libelle;
  String? Prelevement;
  String? Remarque;
  List<AntibiogrammeDetail>? details;


  Antibiogramme(this.numAtb, this.code, this.libelle, this.Prelevement,
      this.Remarque, this.details);

  Antibiogramme.fromJson(Map<String, dynamic> json) {
    numAtb = json['numAtb'];
    code = json['code'];
    libelle = json['libelle'];
    Prelevement = json['prelevement'];
    Remarque = json['remarque'];
    details = json['details'].cast<AntibiogrammeDetail>();
    if (json['details'] != null) {
      details = <AntibiogrammeDetail>[];
      json['details'].forEach((v) {
        details!.add(new AntibiogrammeDetail.fromJson(v));
      });
    }
  }


  Map<String, dynamic> toJson() {
  final Map<String, dynamic> data = new Map<String, dynamic>();
   data['numAtb']= this.numAtb;
   data['code']=this.code ;
   data['libelle']=this.libelle;
   data['prelevement']=this.Prelevement;
   data['remarque']=this.Remarque;
  if (this.details != null) {
    data['details'] = this.details!.map((v) => v.toJson()).toList();
  }

  return data;
  }


 }

class AntibiogrammeDetail {
  String? Libelle;
  String? DC;
  String? Diametre;
  String? ConcentrationCritique;
  String? CMI;
  String? Resultat;
  String? ResultatInterpret;

  AntibiogrammeDetail(
      this.Libelle,
      this.DC,
      this.Diametre,
      this.ConcentrationCritique,
      this.CMI,
      this.Resultat,
      this.ResultatInterpret);
  AntibiogrammeDetail.fromJson(Map<String, dynamic> json) {
    Libelle = json['libelle'];
    DC = json['dc'];
    Diametre = json['diametre'];
    ConcentrationCritique = json['concentrationCritique'];
    CMI = json['cmi'];
    Resultat = json['resultat'];
    ResultatInterpret = json['resultatInterpret'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['libelle']= this.Libelle;
    data['dc']=this.DC ;
    data['diametre']=this.Diametre;
    data['concentrationCritique']=this.ConcentrationCritique;
    data['cmi']=this.CMI;
    data['resultat']=this.Resultat;
    data['resultatInterpret']=this.ResultatInterpret;

    return data;
  }

}