
import 'package:dio/dio.dart';

import '../../app/config/config.dart';

class DossierWebService{
  late Dio dio;
  DossierWebService(){
    BaseOptions options= BaseOptions(
      baseUrl: baseUrl,
      receiveDataWhenStatusError: true,
      connectTimeout: const Duration(seconds: 60),
      receiveTimeout: const Duration(seconds: 60),
    );
   // dio=Dio(options);
  }

Future<List<dynamic>> getDossier(String dateDeb, String dateFin, String statut, String asc) async {
 try{

dio=Dio();
/*
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          // Add the access token to the request header
          options.headers['Authorization'] = 'Bearer your_access_token';
          return handler.next(options);
        },
        onError: (DioError e, handler) async {
          if (e.response?.statusCode == 401) {
            print('44444444');
            // If a 401 response is received, refresh the access token
            //  String newAccessToken = await refreshToken();

            // Update the request header with the new access token
            //   e.requestOptions.headers['Authorization'] = 'Bearer $newAccessToken';

            // Repeat the request with the updated header
            return handler.resolve(await dio.fetch(e.requestOptions));
          }     else if (e.response?.statusCode == 400) {
            print('00000');
        }
          return handler.next(e);
        },
      ),
    );
    */
    DateTime date = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

    print (dateDeb);
   print(dateFin);
    //, dateFin, statut ,asc);
  Response response = await dio.get("http://10.0.2.2:8085/dossier-analyses/list-date",
      queryParameters: {'Datedebut': dateDeb, 'Datefin': dateFin,
        'statut': statut,'asc':asc },);
 //  queryParameters: {'Datedebut': '2022/01/01 02:22:22', 'Datefin': '2023/02/09 01:22:22',  'statut': 100,'asc':'DESC' },);
    print(response.statusCode);
   


  return response.data ;
  }catch(e){

    print(e.toString());
    print("catchhhh");
    return [];
  }

}
  
}