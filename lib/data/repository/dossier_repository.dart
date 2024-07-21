import 'dart:developer';

import 'package:prolab_mobile/data/models/antibiogramme.dart';
import 'package:prolab_mobile/data/models/dossier_pagination.dart';
import 'package:prolab_mobile/data/models/reglement_model.dart';

import '../models/dossier.dart';
import '../models/dossier_analyse_model.dart';
import '../models/dossier_detail.dart';
import '../models/login.dart';
import '../models/searchCriteria.dart';
import '../models/stat_model.dart';
import '../models/token_model.dart';
import '../web_services/dossier_web_services.dart';

class DossierAnalyseRepository {
  final DossierWebService dossierWebService;

  DossierAnalyseRepository(this.dossierWebService);

  Future<DossierPagination?> getDossier(
  //Future<List<DossierDto>?> getDossier(
      String asc,
      int page,
      List<SearchCriteriaGroup> searchCriteriaGroup) async {
    final DossierAnalysesPage = await dossierWebService.getDossier(
         asc, page, searchCriteriaGroup);
    return DossierPagination.fromJson(DossierAnalysesPage);
  }
 // Future<List<DossierAnalyseDetail>?> getDetailDossier(
  Future<List<DetailCQI>?> getDetailDossier(
      String nenreg,
     ) async {
    final DossiersDetail = await dossierWebService.getDetailDossier(
        nenreg
        );
    return DossiersDetail.map((dossier) => DetailCQI.fromJson(dossier)).toList();
   // return DossiersDetail.map((dossier) => DossierAnalyseDetail.fromJson(dossier)).toList();
  }
  Future<Dossier?> getDetailDossierPrevious(
      DossierAnalyse dossier,
     ) async {
    final DossiersDetail = await dossierWebService.getDetailDossierPrevious(
        dossier
        );
    return  Dossier.fromJson(DossiersDetail);
  }
  Future<Dossier?> getDetailDossierNext(
      DossierAnalyse dossier,
     ) async {
    final DossiersDetail = await dossierWebService.getDetailDossierNext(
        dossier
        );
    return Dossier.fromJson(DossiersDetail);
  }
  Future<DossierPagination?> getValideDossier(
 // Future<List<DossierPagination>?> getValideDossier(
      String asc,
      int page,
      String dateDeb,
      String dateFin,

      ) async {
    final DossierAnalysesPage = await dossierWebService.getValideDossier(
        asc, page, dateDeb,dateFin);

    if(DossierAnalysesPage == null){
      return null;
    }

    return DossierPagination.fromJson(DossierAnalysesPage);
   // return DossierPagination.fromJson(DossierAnalysesPage).content;
  }
  Future<DossierPagination?> getValideFiltreDossier(
      String asc,
      int page,
      String dateDeb,
      String dateFin,
      List<SearchCriteriaGroup> searchCriteriaGroup, String filtreBack
      ) async {
    final DossierAnalysesPage = await dossierWebService.getValideFiltreDossier(
        asc, page, dateDeb,dateFin,searchCriteriaGroup,filtreBack);
   // return DossierPagination.fromJson(DossierAnalysesPage).content;
    return DossierPagination.fromJson(DossierAnalysesPage);
  }
  Future<DossierDto> switchValideDossier(
      String asc,
      int page,
      DossierDto dossierDto,
      ) async {
    final DossierAnalysesPage = await dossierWebService.switchValideDossier(
        asc, page,dossierDto);
    return  DossierDto.fromJson(DossierAnalysesPage);
  }
  //Future<DossierAnalyseDetail>
  Future<int> addFeedbackDetailDossier(
      String asc,
      int page,
      DossierAnalyseDetail detail,
      String? commentaire,
      bool? acontroler,
      ) async {
    final DossierDetail = await dossierWebService.addFeedbackDetailDossier(
        asc, page,detail,commentaire,acontroler );
    return  DossierDetail;
      //DossierAnalyseDetail.fromJson(DossierDetail);
  }

  Future<List<Antibiogramme>?> getListATB(
      String nenreg,
      ) async {
    final ATBs = await dossierWebService.getDetailATB(
        nenreg
    );
    return ATBs.map((atb) => Antibiogramme.fromJson(atb)).toList();
  }  Future<int> getListUpdateATB(
  Antibiogramme ATB,
      String comment,
      ) async {
    final intcheck = await dossierWebService.updatecommentATB(
        ATB,comment
    );
    return intcheck;
      //ATBs.map((atb) => Antibiogramme.fromJson(atb)).toList();
  }
  Future<List<Reglement>?> getListReglement(
      String dateDeb,
      String dateFin,
      ) async {
    final regs = await dossierWebService.getListReglement(
        dateDeb,dateFin
    );
    return regs.map((reg) => Reglement.fromJson(reg)).toList();
  }  Future<StatDao?> getStatDossiers(
      String dateDeb,
      String dateFin,
      ) async {
    final stat = await dossierWebService.getStatDossiers(
        dateDeb,dateFin
    );
    return  StatDao.fromJson(stat);
  }Future<int> setcreateJob(
      String sender_type,
      String numDossier,
      double solde,
      String action,
      int status,
      String sender_id,
      String destinataire,
      String user
      ) async {
    final stat = await dossierWebService.setcreateJob(
       sender_type,
       numDossier,
       solde,
       action,
       status,
       sender_id,
       destinataire,
       user
    );
    return  stat;
  }
  Future<Token?> getLogin(
      Login login,

      ) async {
    final res = await dossierWebService.getLoginApi(
        login
    );
    return  Token.fromJson(res);
  }
}
