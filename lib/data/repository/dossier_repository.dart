import '../models/dossier_analyse_model.dart';
import '../web_services/dossier_web_services.dart';

class DossierAnalyseRepository{
  final DossierWebService dossierWebService;

  DossierAnalyseRepository(this.dossierWebService);

Future<List<DossierAnalyse>> getDossier(String dateDeb, String dateFin, String statut, String asc ) async {
  final DossierAnalyses = await dossierWebService.getDossier(dateDeb,dateFin,statut,asc);
   print("${DossierAnalyses.length}ffffff");
  return DossierAnalyses.map((dossier) => DossierAnalyse.fromJson(dossier)).toList();
}
}