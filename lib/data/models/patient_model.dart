class Patient {
  String? code;
  String? titre;
  String? nom;
  String? prenom;
  String? dateNaissance;
  String? sexe;
  String? cin;
  String? passeport;
  String? adresse;
  String? cp;
  String? gsm;
  String? tel;
  String? fax;
  String? mail;
  String? observation;

  Patient(
      {this.code,
      this.titre,
      this.nom,
      this.prenom,
      this.dateNaissance,
      this.sexe,
      this.cin,
      this.passeport,
      this.adresse,
      this.cp,
      this.gsm,
      this.tel,
      this.fax,
      this.mail,
      this.observation});

  Patient.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    titre = json['titre'];
    nom = json['nom'];
    prenom = json['prenom'];
    dateNaissance = json['dateNaissance'];
    sexe = json['sexe'];
    cin = json['cin'];
    passeport = json['passeport'];
    adresse = json['adresse'];
    cp = json['cp'];
    gsm = json['gsm'];
    tel = json['tel'];
    fax = json['fax'];
    mail = json['mail'];
    observation = json['observation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['titre'] = this.titre;
    data['nom'] = this.nom;
    data['prenom'] = this.prenom;
    data['dateNaissance'] = this.dateNaissance;
    data['sexe'] = this.sexe;
    data['cin'] = this.cin;
    data['passeport'] = this.passeport;
    data['adresse'] = this.adresse;
    data['cp'] = this.cp;
    data['gsm'] = this.gsm;
    data['tel'] = this.tel;
    data['fax'] = this.fax;
    data['mail'] = this.mail;
    data['observation'] = this.observation;
    return data;
  }

}