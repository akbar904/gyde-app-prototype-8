
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gyde_app/app/app.locator.dart';
import 'package:gyde_app/app/app.router.dart';
import 'package:stacked_services/stacked_services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  await setupLocator();

  runZonedGuarded(() {
    runApp(const AorteQApp());
  }, (exception, stackTrace) {
    // Handle exceptions here
    print('Caught error: $exception');
    print('Stack trace: $stackTrace');
    // You might want to log this to a service or show a user-friendly error message
  });
}

class AorteQApp extends StatelessWidget {
  const AorteQApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AorteQ',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        textTheme:
            Typography.material2018(platform: TargetPlatform.android).black,
      ),
      initialRoute: Routes.authenticationView,
      onGenerateRoute: StackedRouter().onGenerateRoute,
      navigatorKey: StackedService.navigatorKey,
    );
  }
}
