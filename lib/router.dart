import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prolab_mobile/src/features/dossier_analyse/dossier_bloc/dossieranalyse_bloc.dart';
import 'package:prolab_mobile/src/features/dossier_detail/dossier_detail.dart';
import 'package:prolab_mobile/src/features/dossier_detail/flitre_bloc/filtre_bloc.dart';
import 'package:prolab_mobile/src/features/home/home_bloc/home_bloc.dart';
import 'package:prolab_mobile/src/features/tableau_de_bord/bloc/stat_bloc.dart';
import 'core/constants/strings/strings.dart';
import 'data/repository/dossier_repository.dart';
import 'data/web_services/dossier_web_services.dart';
import 'src/features/home/home_page.dart';
import 'src/features/reglement/bloc/reglement_bloc.dart';

class AppRouter {
  late DossierAnalyseRepository dossiersRepository;
  //late CubitCubit charactersCubit;

  final currentDate =
      "${DateTime.now().year - 4}/${DateTime.now().month}/${DateTime.now().day}";
  final currentDateF =
      "${DateTime.now().year}/${DateTime.now().month}/${DateTime.now().day}";
  AppRouter() {
    dossiersRepository = DossierAnalyseRepository(DossierWebService());
    //charactersCubit = CubitCubit(dossiersRepository);
  }

  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case dossierScreeens:
        return MaterialPageRoute(
          builder: (context) {
            return MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (context) => HomeBloc(),
                ),
                BlocProvider(
                create: (context) => FiltreBloc(),
                ),  BlocProvider(
                create: (context) => ReglementBloc(dossiersRepository),
                ), BlocProvider(
                create: (context) => StatBloc(dossiersRepository),
                ),

                BlocProvider(
                    create: (context) =>
                        DossieranalyseBloc(dossiersRepository)),
              ],
              child: const HomePage(),
             // child: const DossierDetail(),
            );
          },
        );

/*
        BlocProvider<LandingBloc>(
              create: (BuildContext context) => LandingBloc(),
              child: const HomePage(),
            );
            */

      /*
          MaterialPageRoute(
          builder: (_) => BlocProvider<DossieranalyseBloc>(
            create: (BuildContext context)  =>
              //  CubitCubit(dossiersRepository),
              //BlocProvider.of<DossieranalyseBloc>(context).add(LoadDossiersEvent()),
           DossieranalyseBloc(dossiersRepository)..add( LoadDossiersEvent(currentDate,currentDate,STATUT,ASC)),
            child: const DossierScreeens(),
          ),
        );
        */
      /*
    case '/':
       
        return MaterialPageRoute(
         builder: (_) => BlocProvider<LandingBloc>.value(
            value: landingPageBloc,
            child: const LandingPage(),
          ),
            
        );
*/

/*
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case charactersScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (BuildContext contxt) => charactersCubit,
            child: CharactersScreen(),
          ),
        );
      case characterDetailsScreen:
        final character = settings.arguments as Character;

        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (BuildContext context) =>
                CharactersCubit(charactersRepository),
            child: CharacterDetailsScreen(
              character: character,
            ),
          ),
        );
        */
    }
  }
}
