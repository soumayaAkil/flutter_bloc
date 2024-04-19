

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:prolab_mobile/data/models/dossier_analyse_model.dart';

import '../features/dossier_detail/dossier_detail.dart';
import '../features/home/home_page.dart';


part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouterrr extends _$AppRouter{
  @override
  List<AutoRoute> get routes =>[
    AutoRoute(
      path:Navigator.defaultRouteName,
      page:HomeRoute.page,
    ),
    AutoRoute(page:DossierDetailRoute.page,),
  ];
}

