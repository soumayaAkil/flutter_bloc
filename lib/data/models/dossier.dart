import 'dossier_analyse_model.dart';
import 'dossier_detail.dart';

class Dossier {
  DossierDto? dossierDTO;
  List<DetailCQI>? dossierDetail;
 // List<DossierAnalyseDetail>? dossierDetail;

  Dossier({this.dossierDTO, this.dossierDetail});

  Dossier.fromJson(Map<String, dynamic> json) {
    dossierDTO =
    json['dossier'] != null ? new DossierDto.fromJson(json['dossier']) : null;
    if (json['dossierDetail'] != null) {
      dossierDetail = <DetailCQI>[];
      json['dossierDetail'].forEach((v) {
        dossierDetail!.add(new DetailCQI.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.dossierDTO != null) {
      data['dossier'] = this.dossierDTO!.toJson();
    }
    if (this.dossierDetail != null) {
      data['dossierDetail'] =
          this.dossierDetail!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
