class Reglement {
  String? numReg;
  String? dateReg;
  double? mntReg;
  String? modePaiement;
  String? codeClient;
  String? nomClient;
  String? typePiece;
  String? numPiece;
  double? mntPiece;
  double? mntSoldePiece;

  Reglement(
      {this.numReg,
        this.dateReg,
        this.mntReg,
        this.modePaiement,
        this.codeClient,
        this.nomClient,
        this.typePiece,
        this.numPiece,
        this.mntPiece,
        this.mntSoldePiece});

  Reglement.fromJson(Map<String, dynamic> json) {
    numReg = json['numReg'];
    dateReg = json['dateReg'];
    mntReg = json['mntReg'];
    modePaiement = json['modePaiement'];
    codeClient = json['codeClient'];
    nomClient = json['nomClient'];
    typePiece = json['typePiece'];
    numPiece = json['numPiece'];
    mntPiece = json['mntPiece'];
    mntSoldePiece = json['mntSoldePiece'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['numReg'] = this.numReg;
    data['dateReg'] = this.dateReg;
    data['mntReg'] = this.mntReg;
    data['modePaiement'] = this.modePaiement;
    data['codeClient'] = this.codeClient;
    data['nomClient'] = this.nomClient;
    data['typePiece'] = this.typePiece;
    data['numPiece'] = this.numPiece;
    data['mntPiece'] = this.mntPiece;
    data['mntSoldePiece'] = this.mntSoldePiece;
    return data;
  }
}