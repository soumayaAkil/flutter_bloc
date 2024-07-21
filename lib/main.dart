
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:prolab_mobile/src/features/notification/notification_service.dart';
import 'Screen_page.dart';
import 'core/config/themes/dark_theme.dart';
import 'core/config/themes/light_theme.dart';
import 'src/features/home/home.dart';
import 'router.dart';
void main()async {
  WidgetsFlutterBinding.ensureInitialized();

  NotificationService notificationService = NotificationService();
  await notificationService.initNotification();


  runApp( MyApp());
      //const MyApp());
  //ProlabApp(appRouter: AppRouter(),)
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      debugShowCheckedModeBanner: false,
      home:
      Screen_page(),
    );
  }
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
