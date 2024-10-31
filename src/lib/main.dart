import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gyde_app/app/app.bottomsheets.dart';
import 'package:gyde_app/app/app.dialogs.dart';
import 'package:gyde_app/app/app.locator.dart';
import 'package:gyde_app/app/app.router.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:gyde_app/features/app/app_view.dart';

Future<void> main() async {
  await runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();

    // Initialize Firebase
    await Firebase.initializeApp();

    // Set preferred orientations
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    // Setup dependencies
    await setupLocator();
    setupDialogUi();
    setupBottomSheetUi();

    // Initialize analytics
    final analytics = FirebaseAnalytics.instance;
    analytics.logAppOpen();

    // Run app with error boundary
    runApp(const AppView());
  }, (error, stackTrace) async {
    // Log errors to analytics and crash reporting
    FirebaseAnalytics.instance.logEvent(
      name: 'app_error',
      parameters: {
        'error': error.toString(),
        'stackTrace': stackTrace.toString(),
      },
    );

    print('Caught error: $error');
    print('Stack trace: $stackTrace');
  });
}
