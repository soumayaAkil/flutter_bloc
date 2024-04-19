import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:intl/intl.dart';

import '../../core/config/config.dart';
import '../../core/constants/strings/strings.dart';
import '../models/dossier_analyse_model.dart';
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

 // Future<dynamic> getDossier(
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
      print(page);
      print("apiiiiiiiii");
      print(page);
      print(asc);
      Response response = await dio.post(
        "${baseUrl}page-dto",
        queryParameters: {
          'page': page,
          'size': SIZEPAGINATION,
          'sort': "datePrelevement",
          'dir': asc
        },
        /* data: {
    'searchCriteriaGroups': jsonEncode(searchCriteriaGroup),
  },
*/
        data: searchCriteriaGroup,
        options: Options(
          contentType: Headers.jsonContentType,
        ),
      );

      //  queryParameters: {'Datedebut': '2022/01/01 02:22:22', 'Datefin': '2023/02/09 01:22:22',  'statut': 100,'asc':'DESC' },);
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
        "${baseUrl}${nenreg}/analyses",
      );
      print(response.statusCode);
      print(nenreg);
      print(response.data);
      return response.data;
    } catch (e) {
      print("catchhhh get detail ");
      print(e);
      return [];
    }
  }

  Future<List<dynamic>> getDetailDossierPrevious(
      DossierAnalyse dossier,
      ) async {
    try {
      dio = Dio();
log("$dossier");
log("999999999999999999");

      // Analyser la chaîne de date d'entrée en un objet DateTime
      DateTime dateTime = DateTime.parse(dossier.dateAdd!);

      String formattedDateString = DateFormat("dd/MM/yyyy HH:mm:ss").format(dateTime);
      Response response = await dio.get(
        "${baseUrl}previous",
          queryParameters: {
            'dossier': formattedDateString,
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
  Future<List<dynamic>> getDetailDossierNext(
      DossierAnalyse dossier,
      ) async {
    try {
      dio = Dio();
log("$dossier");
log("999999999999999999");

      // Analyser la chaîne de date d'entrée en un objet DateTime
      DateTime dateTime = DateTime.parse(dossier.dateAdd!);

      String formattedDateString = DateFormat("dd/MM/yyyy HH:mm:ss").format(dateTime);
      Response response = await dio.get(
        "${baseUrl}next",
          queryParameters: {
            'dossier': formattedDateString,
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
  Future<dynamic> getValideDossier(
      String asc,
      int page,
      String dateDeb,
      String dateFin) async {
    try {
      dio = Dio();

      Response response = await dio.post(
        "${baseUrl}page-val-dto",
        queryParameters: {
          'page': page,
          'size': SIZEPAGINATION,
          'sort': "datePrelevement",
          'dir': asc,
          'dateDeb':dateDeb+" 00:00:00",
          'dateFin': dateFin+" 23:59:59",
        },
        options: Options(
          contentType: Headers.jsonContentType,
        ),
      );
      print(response.statusCode);

      print(response.data);
      return response.data;
    } catch (e) {
      print("catchhhh get valide dossier ");
      print(e);
      return [];
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
        "${baseUrl}page-val-dto",
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
      print(response.statusCode);

      print(response.data);
      return response.data;
    } catch (e) {
      print("catchhhh get valide  filtre dossier ");
      print(e);
      return [];
    }
  }


}
