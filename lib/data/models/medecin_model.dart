class Medecin {
  String? code;
  String? nomPrenom;
  String? gsm;
  String? tel;
  String? mail;

  Medecin({this.code, this.nomPrenom, this.gsm, this.tel, this.mail});

  Medecin.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    nomPrenom = json['nomPrenom'];
    gsm = json['gsm'];
    tel = json['tel'];
    mail = json['mail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['nomPrenom'] = this.nomPrenom;
    data['gsm'] = this.gsm;
    data['tel'] = this.tel;
    data['mail'] = this.mail;
    return data;
  }
}