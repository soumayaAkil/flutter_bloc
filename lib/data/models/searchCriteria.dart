
class SearchCriteriaGroup {
  bool? orPredicate;
  List<SearchCriteria>? searchCriterias;

  SearchCriteriaGroup({required this.orPredicate, required this.searchCriterias});

  SearchCriteriaGroup.fromJson(Map<String, dynamic> json) {
    orPredicate = json['orPredicate'];
    searchCriterias = json['searchCriterias'].cast<SearchCriteria>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['orPredicate'] = this.orPredicate;
    data['searchCriterias'] = this.searchCriterias;
    return data;
  }
}
class SearchCriteria {
  String? key;
  String? operation;
  bool? orPredicate;
  String? value;

  SearchCriteria( {required this.key, required this.operation,required this.orPredicate,required this.value});

  SearchCriteria.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    operation = json['operation'];
    orPredicate = json['orPredicate'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['key'] = this.key;
    data['operation'] = this.operation;
    data['orPredicate'] = this.orPredicate;
    data['value'] = this.value;
    return data;
  }
}