class StatDao {
  StatDossier? statDossier;
  StatFacture? statFacture;
  List<StatReglements>? statReglements;
  double? totalReglement;
  double? totalReglementPeriode;
  double? totalReglementAnterieurs;
  double? totalRemboursements;
  List<PieEntries>? pieEntries;

  StatDao(
      {this.statDossier,
        this.statFacture,
        this.statReglements,
        this.totalReglement,
        this.totalReglementPeriode,
        this.totalReglementAnterieurs,
        this.totalRemboursements,
        this.pieEntries});

  StatDao.fromJson(Map<String, dynamic> json) {
    statDossier = json['statDossier'] != null
        ? new StatDossier.fromJson(json['statDossier'])
        : null;
    statFacture = json['statFacture'] != null
        ? new StatFacture.fromJson(json['statFacture'])
        : null;
    if (json['statReglements'] != null) {
      statReglements = <StatReglements>[];
      json['statReglements'].forEach((v) {
        statReglements!.add(new StatReglements.fromJson(v));
      });
    }
    totalReglement = json['totalReglement'];
    totalReglementPeriode = json['totalReglementPeriode'];
    totalReglementAnterieurs = json['totalReglementAnterieurs'];
    totalRemboursements = json['totalRemboursements'];
    if (json['pieEntries'] != null) {
      pieEntries = <PieEntries>[];
      json['pieEntries'].forEach((v) {
        pieEntries!.add(new PieEntries.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.statDossier != null) {
      data['statDossier'] = this.statDossier!.toJson();
    }
    if (this.statFacture != null) {
      data['statFacture'] = this.statFacture!.toJson();
    }
    if (this.statReglements != null) {
      data['statReglements'] =
          this.statReglements!.map((v) => v.toJson()).toList();
    }
    data['totalReglement'] = this.totalReglement;
    data['totalReglementPeriode'] = this.totalReglementPeriode;
    data['totalReglementAnterieurs'] = this.totalReglementAnterieurs;
    data['totalRemboursements'] = this.totalRemboursements;
    if (this.pieEntries != null) {
      data['pieEntries'] = this.pieEntries!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class StatDossier {
  double? totalCredit;
  int nbrDossiers=0;
  double? totalSociete;
  double? totalPatient;

  StatDossier(
      {this.totalCredit,
        required this.nbrDossiers ,
        this.totalSociete,
        this.totalPatient});

  StatDossier.fromJson(Map<String, dynamic> json) {
    totalCredit = json['totalCredit'];
    nbrDossiers = json['nbrDossiers'];
    totalSociete = json['totalSociete'];
    totalPatient = json['totalPatient'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totalCredit'] = this.totalCredit;
    data['nbrDossiers'] = this.nbrDossiers;
    data['totalSociete'] = this.totalSociete;
    data['totalPatient'] = this.totalPatient;
    return data;
  }
}

class StatFacture {
  int? nbrFactures;
  double? totalTTC;

  StatFacture({this.nbrFactures, this.totalTTC});

  StatFacture.fromJson(Map<String, dynamic> json) {
    nbrFactures = json['nbrFactures'];
    totalTTC = json['totalTTC'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nbrFactures'] = this.nbrFactures;
    data['totalTTC'] = this.totalTTC;
    return data;
  }
}

class StatReglements {
  String? modePaiement;
  double? totalMontant;

  StatReglements({this.modePaiement, this.totalMontant});

  StatReglements.fromJson(Map<String, dynamic> json) {
    modePaiement = json['modePaiement'];
    totalMontant = json['totalMontant'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['modePaiement'] = this.modePaiement;
    data['totalMontant'] = this.totalMontant;
    return data;
  }
}
class PieEntries {
  String? label;
  int? valeur;

  PieEntries({this.label, this.valeur});

  PieEntries.fromJson(Map<String, dynamic> json) {
    label = json['label'];
    valeur = json['valeur'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['label'] = this.label;
    data['valeur'] = this.valeur;
    return data;
  }
}