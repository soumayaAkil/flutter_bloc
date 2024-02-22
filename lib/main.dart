import 'package:flutter/material.dart';
import 'app_router.dart';
import 'app/config/themes/dark_theme.dart';
import 'app/config/themes/light_theme.dart';
import 'presentation/pages/home.dart';
import 'router.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(ProlabApp(appRouter: AppRouter(),));
}

class ProlabApp extends StatelessWidget {
  final AppRouter appRouter;
  const ProlabApp({Key? key, required this.appRouter}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return
        // MaterialApp.router(
        MaterialApp(
      title: 'Flutter Demo',
      theme: light_Theme,
      darkTheme: dark_Theme,
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      // routerConfig: appRouter.config(),
      onGenerateRoute: appRouter.generateRoute,
    );
  }
}
