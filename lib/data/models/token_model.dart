class Token {
  String? token;
  String? tokenExpiration;

  Token({this.token, this.tokenExpiration});

  Token.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    tokenExpiration = json['tokenExpiration'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    data['tokenExpiration'] = this.tokenExpiration;
    return data;
  }
}