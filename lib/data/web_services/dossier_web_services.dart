import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:intl/intl.dart';

import '../../core/config/config.dart';
import '../../core/constants/strings/strings.dart';
import '../models/antibiogramme.dart';
import '../models/dossier_analyse_model.dart';
import '../models/dossier_detail.dart';
import '../models/dossier_pagination.dart';
import '../models/login.dart';
import '../models/searchCriteria.dart';

class DossierWebService {
  late Dio dio;
  // final
  DossierWebService() {
    BaseOptions options = BaseOptions(
      baseUrl: baseUrl,
      receiveDataWhenStatusError: true,
      connectTimeout: const Duration(seconds: 60),
      receiveTimeout: const Duration(seconds: 60),
    );
    //dio=Dio(options);
  }
  Future<dynamic> getDossier(
      String asc,
      int page,
      List<SearchCriteriaGroup> searchCriteriaGroup) async {
    try {
      dio = Dio();
/*
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          options.headers['Authorization'] = 'Bearer your_access_token';
          return handler.next(options);
        },
        onError: (DioError e, handler) async {
          if (e.response?.statusCode == 401) {

            return handler.resolve(await dio.fetch(e.requestOptions));
          }     else if (e.response?.statusCode == 400) {
            print('00000');
        }
          return handler.next(e);
        },
      ),
    );
    */
      //, dateFin, statut ,asc);
      /*
  Response response = await dio.get("${baseUrl}list-date",
      queryParameters: {'Datedebut': dateDeb, 'Datefin': dateFin,
        'statut': statut,'asc':asc },
  );

  https://stackoverflow.com/questions/61542834/flutter-dio-post-an-object-with-array

   */
      print("apiiiiiiiii");
      print(asc);
      Response response = await dio.post(
        "${baseUrl}dossier-analyses/page-dto",
        queryParameters: {
          'page': page,
          'size': SIZEPAGINATION,
          'sort': "datePrelevement",
          'dir': asc

        },

        data: searchCriteriaGroup,
        options: Options(
          contentType: Headers.jsonContentType,
        ),
      );

      //  queryParameters: {'Datedebut': '2022/01/01 02:22:22', 'Datefin': '2023/02/09 01:22:22',  'statut': 100,'asc':'DESC' },);
      print("3333");
      print(response.statusCode);
     // print(searchCriteriaGroup[0].searchCriterias?[0].value);
      print("3333");

      return response.data;
    } catch (e) {
      print("catchhhh 1");
      print(e);
      return [];
    }
  }

  Future<List<dynamic>> getDetailDossier(
      String nenreg,
      ) async {
    try {
      dio = Dio();

      Response response = await dio.get(
        "${baseUrl}dossier-analyses/${nenreg}/analyses",
      );

      print(response.statusCode);
      print(nenreg);
      print(response.data);
      return response.data;
    } catch (e) {
      print("catchhhh get detail ");
      print(nenreg);
      print(e);
      return [];
    }
  }

  Future<dynamic> getDetailDossierPrevious(
      DossierAnalyse dossier,
      ) async {
    try {
      dio = Dio();
log("$dossier");
log("999999999999999999");

      // Analyser la chaîne de date d'entrée en un objet DateTime
      DateTime datecurrent=DateTime.parse(dossier.dateAdd!.substring(0,22));
      String formattedDateString = DateFormat("dd/MM/yyyy HH:mm:ss").format(datecurrent);
      log(formattedDateString);
      log("hhhhhhhhhhhhhh");
      Response response = await dio.get(
        "${baseUrl}dossier-analyses/previous",
          queryParameters: {
            'date': formattedDateString,
          },
            options: Options(
              contentType: Headers.jsonContentType,
            ),

      );
      print(response.statusCode);
      print(response.data);
      return response.data;
    } catch (e) {
      print("catchhhh get detail previous");
      print(e);
      return [];
    }
  }
  Future<dynamic> getDetailDossierNext(
      DossierAnalyse dossier,
      ) async {
    try {
      dio = Dio();
      // Analyser la chaîne de date d'entrée en un objet DateTime
      DateTime datecurrent=DateTime.parse(dossier.dateAdd!.substring(0,22));
      String formattedDateString = DateFormat("dd/MM/yyyy HH:mm:ss").format(datecurrent);
      log(formattedDateString);
      log("hhhhhhhhhhhhhh");
      Response response = await dio.get(
        "${baseUrl}dossier-analyses/next",
          queryParameters: {
            'date': formattedDateString,
          },
            options: Options(
              contentType: Headers.jsonContentType,
            ),

      );

      print(response.statusCode);
      print(response.data);
      return response.data;
    } catch (e) {
      print("catchhhh get detail next");
      print(e);
      return [];
    }
  }
  Future<Map<String,dynamic>?> getValideDossier(

      String asc,
      int page,
      String dateDeb,
      String dateFin) async {
    try {
      dio = Dio();
log("[valide_dossier] fffff: $dateDeb $page $dateFin $asc $SIZEPAGINATION");
      Response response = await dio.post(
        "${baseUrl}dossier-analyses/page-val-dto",
        queryParameters: {
          'page': page,
          'size': SIZEPAGINATION,
          'sort': "datePrelevement",
          'dir': asc,
          'dateDeb':dateDeb+" 00:00:00",
          'dateFin': dateFin+" 23:59:59",
        },

        //  options: Options(validateStatus: (status) {
          //  return status! < 500; // Accept responses with status codes less than 500
      //    })
      );
      print("[valide_dossier] reponse returned");


    print(response.data);
      print('[valide_dossier] ${response.statusCode}' );

      print('[valide_dossier] ${response.data}');

      return response.data;
    } catch (e) {
      print("[valide_dossier] catchhhh get valide x dossier ==> $e");

      return null;
    }
  }
  Future<dynamic> getValideFiltreDossier(
      String asc,
      int page,
      String dateDeb,
      String dateFin,
      List<SearchCriteriaGroup> searchCriteriaGroup, String filtreBack) async {
    try {
      dio = Dio();

      Response response = await dio.post(
        "${baseUrl}dossier-analyses/page-val-dto",
        queryParameters: {
          'page': page,
          'size': SIZEPAGINATION,
          'sort': "datePrelevement",
          'dir': asc,
          'dateDeb':dateDeb+" 00:00:00",
          'dateFin': dateFin+" 23:59:59",
          'filtreBack': filtreBack,
        },
        data: searchCriteriaGroup,
        options: Options(
          contentType: Headers.jsonContentType,
        ),
      );
      print('[valide_dossier] ${response.statusCode}' );

      print('[valide_dossier] ${response.data}');
      return response.data;
    } catch (e) {
      print("[valide_dossier] catchhhh get valide  filtre dossier ");
      print(e);
      return [];
    }
  }
Future<dynamic> switchValideDossier(
      String asc,
      int page,
     DossierDto dossierDto) async {
    try {
      dio = Dio();

      Response response = await dio.post(
        "${baseUrl}dossier-analyses/valide-dossier-dto",
        queryParameters: {
          'page': page,
          'size': SIZEPAGINATION,
          'sort': "datePrelevement",
          'dir': asc,
         /* 'dateDeb':dateDeb+" 00:00:00",
          'dateFin': dateFin+" 23:59:59",
          'filtreBack': filtreBack,
          */

        },
        data: dossierDto,
        options: Options(
          contentType: Headers.jsonContentType,
        ),
      );
      print(response.statusCode);

      return response.data;
    } catch (e) {
      print("catchhhh switch valide  dossier ");
      print(e);
      return 0;
    }
  }
  Future<int>addFeedbackDetailDossier(
      String asc,
      int page,
      DossierAnalyseDetail detail,
      String? commentaire,
      bool? acontroler) async {
    try {
      dio = Dio();

      Response response = await dio.post(
        "${baseUrl}dossier-analyse-details/add-feedback",
        queryParameters: {
          'page': page,
          'size': SIZEPAGINATION,
          'sort': "datePrelevement",
          'dir': asc,
          'commentaire':commentaire,
          'acontroler':acontroler,
          /* 'dateDeb':dateDeb+" 00:00:00",
          'dateFin': dateFin+" 23:59:59",
          'filtreBack': filtreBack,
          */

        },
        data: detail,
        options: Options(
          contentType: Headers.jsonContentType,
        ),
      );
      print("add feedback api status ");
      print(response.statusCode);

      print(response.data);
      return response.data;
    } catch (e) {
      print("catchhhh switch valide  dossier ");
      print(e);
      return 0;
    }
  }
  Future<List<dynamic>> getDetailATB(
      String nenreg,
      ) async {
    try {
      dio = Dio();

      Response response = await dio.get(
        "${baseUrl}atbs/${nenreg}/antibiogrammes",
      );
log("log fff");
      return response.data;
    } catch (e) {
      print("catchhhh get ATB ");
      print(nenreg);
      print(e);
      return [];
    }
  }
  Future<int> updatecommentATB(
      Antibiogramme ATB,
      String comment,
      ) async {
    try {
      dio = Dio();

      Response response = await dio.get(
        "${baseUrl}atbs/antibiogramme",

      queryParameters: {
    'commentaire':comment,


    },
    data: ATB,
        options: Options(
          contentType: Headers.jsonContentType,
        ),
      );
      return response.data;
    } catch (e) {
      print("catchhhh get ATB commment ");
      print(e);
      return 0;
    }
  }
  Future<List<dynamic>>  getListReglement(
      String dateDeb,
      String dateFin,
      ) async {
    try {
      dio = Dio();

      Response response = await dio.get(
        "${baseUrl}reglements/getAll",
        queryParameters: {
          'dateDeb':dateDeb+" 00:00:00",
          'dateFin': dateFin+" 23:59:59",
          },
        options: Options(
          contentType: Headers.jsonContentType,
        ),
      );
      print("${response.statusCode} regg");

      print(response.data);
      return response.data;
    } catch (e) {
      print("catchhhh get reglemnts ");
      print(e);
      return [];
    }
  }  Future<dynamic>  getStatDossiers(
      String dateDeb,
      String dateFin,
      ) async {
    try {
      dio = Dio();

      Response response = await dio.get(
        "${baseUrl}dossier-analyses/stat",
        queryParameters: {
          'Datedebut':dateDeb+" 00:00:00",
          'Datefin': dateFin+" 23:59:59",
          },
        options: Options(
          contentType: Headers.jsonContentType,
        ),
      );
      print(response.data);
      return response.data;
    } catch (e) {
      print("catchhhh get statistique ");
      print(e);
      return [];
    }
  }Future<int>  setcreateJob(
  String sender_type,
  String numDossier,
  double solde,
  String action,
  int status,
  String sender_id,
  String destinataire,
  String user,
      ) async {
    try {
      dio = Dio();
 /*     DateTime datecurrent=DateTime.parse(date.substring(0,22));
      String formattedDateString = DateFormat("dd/MM/yyyy HH:mm:ss").format(datecurrent);
*/
      Response response = await dio.get(
        "${baseUrl}prolab-service-jobs/add", queryParameters: {
      'sender_type': sender_type,
      'numDossier' :numDossier,
      'solde' :solde,
      'action': action,
      'status': status,
      'sender_id': sender_id,
      'destinataire': destinataire,
      'user': user
          },
        options: Options(
          contentType: Headers.jsonContentType,
        ),
      );
      return response.data;
    } catch (e) {
      print("catchhhh get action ");
      print(e);
      return 0;
    }
  }
  Future<dynamic>  getLoginApi(
      Login login,
      ) async {
    try {
      log("[apiiii]");
      log("[apiiii]"+login.password.toString());
      dio = Dio();
      Response response = await dio.post(
        "${baseUrl}users/login",
        data: login,
        options: Options(
          contentType: Headers.jsonContentType,
        ),
      );
      log("[logiiiin]"+login.nom.toString());
      return response.data;
    } catch (e) {
      print("catchhhh get login ");
      print(e);
      return [];
    }
  }
/*

        Date date;
        String sender_type;
        String numDossier;
        String action;
        int status;
        String sender_id;
        String destinataire;
        String user;

 */
  //logAction(Context mContext, String numDossier, String action, String description)
}
