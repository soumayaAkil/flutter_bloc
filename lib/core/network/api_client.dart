import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import '../../data/models/dossier_analyse_model.dart';
import '../../data/models/searchCriteria.dart';

part 'api_client.g.dart';
@RestApi()
abstract class ApiClient {
//  factory ApiClient({Dio dio, String baseUrl}) = _ApiClient;

  @POST('/list-date')
  Future<List<DossierAnalyse>> fetchDossier(
      @Path('page') String page,
      @Path('size') String size,
      @Path('asc') String asc,
      @Path('sort') String sort,
      @Path('dir') String dir,
  @Body() List<SearchCriteriaGroup> searchCriteriaGroup );


/*
  @GET('/')
  Future<DossierAnalyse> fetchProduct();

  @DELETE('/{id}')
  Future<void> deleteProduct(@Path('id') String id);
  @POST('/')
  Future<ProductResponse> createProduct(@Body() ProductCreateRequest body);
  */
}
