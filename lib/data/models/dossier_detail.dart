import 'dart:ffi';

class DossierAnalyseDetail {
  String? num;
  String? numDossier;
  //Analyse? analyse;
  String? abreviation;
  String? numGroupe;
  bool? toControl;
  String? libelle;
  String? codeTube;
  String? etatPersonnalisee;
  bool? doubleSaisie;
  String? nbrAnterioriteImp;
  int? precisionVirguleUnite1;
  int? precisionVirguleUnite2;
  String? section;
  String? resultat;
  bool? gratuit;
  String? typeResultat;
  bool? controle;
  String? unite1;
  String? unite2;
  String? vumin1;
  String? vumax1;
  String? valeurUsuelle;
  int? ordre;
  String? commentaire;
  bool estGroupe=false;
  bool horsNorme=false;
  bool? formuleCalcul;
  String? discipline;
  String? flagResult;
  bool? vt;
  int? etat;
  int? dispOrder;
  String? groupOrder;
  List<dynamic> anteriorite=[];

  DossierAnalyseDetail({
      this.num,
      this.numDossier,
      this.abreviation,
      this.numGroupe,
      this.toControl,
      this.libelle,
      this.codeTube,
      this.etatPersonnalisee,
      this.doubleSaisie,
      this.nbrAnterioriteImp,
      this.precisionVirguleUnite1,
      this.precisionVirguleUnite2,
      this.section,
      this.resultat,
      this.gratuit,
      this.typeResultat,
      this.controle,
      this.unite1,
      this.unite2,
      this.vumin1,
      this.vumax1,
      this.valeurUsuelle,
      this.ordre,
      this.commentaire,
      required this.estGroupe,
      required this.horsNorme,
      this.formuleCalcul,
      this.discipline,
      this.flagResult,
      this.vt,
      this.etat,
      this.dispOrder,
      this.groupOrder,required this.anteriorite}); // String? anteriotite;
//"ORDER BY d1.DatePrelevement Desc for xml path('')) as Anteriorite


  DossierAnalyseDetail.fromJson(Map<String, dynamic> json) {

    num = json['num'];
    numDossier = json['numDossier'];
    abreviation = json['abreviation'];
    numGroupe = json['numGroupe'];
    toControl = json['toControl'];
    libelle = json['libelle'];
    gratuit = json['gratuit'];
    typeResultat = json['typeResultat'];
    controle = json['controle'];
    horsNorme = json['horsNorme'];
    etat = json['etat'];
    dispOrder = json['dispOrder'];
    formuleCalcul = json['formuleCalcul'];
    doubleSaisie = json['doubleSaisie'];
    vumax1 = json['vumax1'];
    vumin1 = json['vumin1'];
    flagResult = json['flagResult'];
    vt = json['vt'];
    groupOrder = json['groupOrder'];
    estGroupe = json['estGroupe'];
    resultat = json['resultat'];
    discipline = json['discipline'];
    codeTube = json['codeTube'];
    ordre = json['ordre'];
    section = json['section'];
    unite1 = json['unite1'];
    unite2 = json['unite2'];
    valeurUsuelle = json['valeurUsuelle'];
    commentaire = json['commentaire'];
    precisionVirguleUnite1 = json['precisionVirguleUnite1'];
    precisionVirguleUnite2 = json['precisionVirguleUnite2'];
    nbrAnterioriteImp = json['nbrAnterioriteImp'];
    anteriorite = json['anteriorite'];
    etatPersonnalisee = json['etatPersonnalisee'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['num'] = this.num;
    data['numDossier'] = this.numDossier;
    data['abreviation'] = this.abreviation;
    data['numGroupe'] = this.numGroupe;
    data['toControl'] = this.toControl;
    data['libelle'] = this.libelle;
    data['gratuit'] = this.gratuit;
    data['typeResultat'] = this.typeResultat;
    data['controle'] = this.controle;
    data['horsNorme'] = this.horsNorme;
    data['etat'] = this.etat;
    data['dispOrder'] = this.dispOrder;
    data['formuleCalcul'] = this.formuleCalcul;
    data['doubleSaisie'] = this.doubleSaisie;
    data['vumax1'] = this.vumax1;
    data['vumin1'] = this.vumin1;
    data['flagResult'] = this.flagResult;
    data['vt'] = this.vt;
    data['groupOrder'] = this.groupOrder;
    data['estGroupe'] = this.estGroupe;
    data['resultat'] = this.resultat;
    data['discipline'] = this.discipline;
    data['codeTube'] = this.codeTube;
    data['ordre'] = this.ordre;
    data['section'] = this.section;
    data['unite1'] = this.unite1;
    data['unite2'] = this.unite2;
    data['valeurUsuelle'] = this.valeurUsuelle;
    data['commentaire'] = this.commentaire;
    data['precisionVirguleUnite1'] = this.precisionVirguleUnite1;
    data['precisionVirguleUnite2'] = this.precisionVirguleUnite2;
    data['nbrAnterioriteImp'] = this.nbrAnterioriteImp;
    data['anteriorite'] = this.anteriorite;
    data['etatPersonnalisee'] = this.etatPersonnalisee;
    return data;
  }
}
///
  /*
class Analyse {
  int? num;
  String abreviation="";
  String? libelle;
  Discipline? discipline;
  String? codeTube;

  Analyse(
      {this.num,
        required this.abreviation,
        this.libelle,
        this.discipline,
        this.codeTube});

  Analyse.fromJson(Map<String, dynamic> json) {
    num = json['num'];
    abreviation = json['abreviation'];
    libelle = json['libelle'];
    discipline = json['discipline'] != null
        ? new Discipline.fromJson(json['discipline'])
        : null;
    codeTube = json['codeTube'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['num'] = this.num;
    data['abreviation'] = this.abreviation;
    data['libelle'] = this.libelle;
    if (this.discipline != null) {
      data['discipline'] = this.discipline!.toJson();
    }
    data['codeTube'] = this.codeTube;
    return data;
  }
}

class Discipline {
  String? code;
  String? libelle;
  int? ordre;

  Discipline({this.code, this.libelle, this.ordre});

  Discipline.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    libelle = json['libelle'];
    ordre = json['ordre'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['libelle'] = this.libelle;
    data['ordre'] = this.ordre;
    return data;
  }
}
*/