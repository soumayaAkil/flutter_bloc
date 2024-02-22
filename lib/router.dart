import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'presentation/pages/home.dart';
import 'presentation/pages/home_page.dart';
import 'app/constants/strings/strings.dart';
import 'business_logic/dossier_bloc/dossieranalyse_bloc.dart';
import 'business_logic/landing_bloc/landing_bloc.dart';
import 'data/repository/dossier_repository.dart';
import 'data/web_services/dossier_web_services.dart';
import 'presentation/pages/landing_page.dart';

class AppRouter {
  late DossierAnalyseRepository dossiersRepository;
  //late CubitCubit charactersCubit;

  final currentDate = "${DateTime.now().year-4}/${DateTime.now().month}/${DateTime.now().day}";
  final currentDateF = "${DateTime.now().year}/${DateTime.now().month}/${DateTime.now().day}";
  AppRouter() {
    dossiersRepository = DossierAnalyseRepository(DossierWebService());
    //charactersCubit = CubitCubit(dossiersRepository);
  }

  Route? generateRoute(RouteSettings settings) {
    
    switch (settings.name) {
      case dossierScreeens:
        return MaterialPageRoute(
          builder: (context) {
            return    MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (context) =>
            DossieranalyseBloc(dossiersRepository) ),

      BlocProvider(create: (context) => LandingBloc(),),
    
    ],
    child: MaterialApp(
      home: HomePage(),
    ),
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
