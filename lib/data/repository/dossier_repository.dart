import 'package:prolab_mobile/data/models/dossier_pagination.dart';

import '../models/dossier_analyse_model.dart';
import '../models/dossier_detail.dart';
import '../models/searchCriteria.dart';
import '../web_services/dossier_web_services.dart';

class DossierAnalyseRepository {
  final DossierWebService dossierWebService;

  DossierAnalyseRepository(this.dossierWebService);

  Future<List<DossierDto>?> getDossier(
      String asc,
      int page,
      List<SearchCriteriaGroup> searchCriteriaGroup) async {
    final DossierAnalysesPage = await dossierWebService.getDossier(
         asc, page, searchCriteriaGroup);
    return DossierPagination.fromJson(DossierAnalysesPage).content;
  }
  Future<List<DossierAnalyseDetail>?> getDetailDossier(
      String nenreg,
     ) async {
    final DossiersDetail = await dossierWebService.getDetailDossier(
        nenreg
        );
    return DossiersDetail.map((dossier) => DossierAnalyseDetail.fromJson(dossier)).toList();
  }
  Future<List<DossierAnalyseDetail>?> getDetailDossierPrevious(
      DossierAnalyse dossier,
     ) async {
    final DossiersDetail = await dossierWebService.getDetailDossierPrevious(
        dossier
        );
    return DossiersDetail.map((dossier) => DossierAnalyseDetail.fromJson(dossier)).toList();
  }
  Future<List<DossierAnalyseDetail>?> getDetailDossierNext(
      DossierAnalyse dossier,
     ) async {
    final DossiersDetail = await dossierWebService.getDetailDossierNext(
        dossier
        );
    return DossiersDetail.map((dossier) => DossierAnalyseDetail.fromJson(dossier)).toList();
  }
  Future<List<DossierDto>?> getValideDossier(
      String asc,
      int page,
      String dateDeb,
      String dateFin,

      ) async {
    final DossierAnalysesPage = await dossierWebService.getValideDossier(
        asc, page, dateDeb,dateFin);
    return DossierPagination.fromJson(DossierAnalysesPage).content;
  }
  Future<List<DossierDto>?> getValideFiltreDossier(
      String asc,
      int page,
      String dateDeb,
      String dateFin,
      List<SearchCriteriaGroup> searchCriteriaGroup, String filtreBack
      ) async {
    final DossierAnalysesPage = await dossierWebService.getValideFiltreDossier(
        asc, page, dateDeb,dateFin,searchCriteriaGroup,filtreBack);
    return DossierPagination.fromJson(DossierAnalysesPage).content;
  }
}
