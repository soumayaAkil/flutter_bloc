
import 'dart:core';

class Login {

  String? nom;
  String? password;



  Login(this.nom, this.password);

  Login.fromJson(Map<String, dynamic> json) {
    nom = json['nom'];
    password = json['password'];

  }


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nom']= this.nom;
    data['password']=this.password ;


    return data;
  }


}
