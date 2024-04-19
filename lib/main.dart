import 'package:flutter/material.dart';
import 'core/config/themes/dark_theme.dart';
import 'core/config/themes/light_theme.dart';
import 'src/features/home/home.dart';
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
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      // routerConfig: appRouter.config(),
      onGenerateRoute: appRouter.generateRoute,
    );
  }
}
