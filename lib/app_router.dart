


import 'package:auto_route/auto_route.dart';

import 'app_router.gr.dart';

@AutoRouterConfig()      
class AppRouter2 extends $AppRouter {
   
 @override      
 List<AutoRoute> get routes => [  
  AutoRoute(page:DossierScreeens.page,initial:true)



//AutoRoute(path: Navigator.defaultRouteName,page: DossierScreeensRoute.page, )    
  ];    
}   