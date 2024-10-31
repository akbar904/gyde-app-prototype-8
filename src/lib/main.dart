import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:aorteq_app/app/app.locator.dart';
import 'package:aorteq_app/app/app.router.dart';

void main() async {
  await runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();

    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    await setupLocator();

    runApp(const AorteqApp());
  }, (exception, stackTrace) async {
    // Handle exceptions here
    print('Caught error: $exception');
    print('Stack trace: $stackTrace');
    // You might want to log this to a service or show a user-friendly error message
  });
}

class AorteqApp extends StatelessWidget {
  const AorteqApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aorteq',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: const Color(0xFF6366F1),
        textTheme: ThemeData.light().textTheme,
      ),
      darkTheme: ThemeData.dark(),
      initialRoute: Routes.welcomeView,
      onGenerateRoute: StackedRouter().onGenerateRoute,
      navigatorKey: StackedService.navigatorKey,
    );
  }
}
