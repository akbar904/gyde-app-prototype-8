
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gyde_app/app/app.bottomsheets.dart';
import 'package:gyde_app/app/app.dialogs.dart';
import 'package:gyde_app/app/app.locator.dart';
import 'package:gyde_app/features/authentication/login_view.dart';

void main() async {
	await runZonedGuarded(() async {
		WidgetsFlutterBinding.ensureInitialized();

		await SystemChrome.setPreferredOrientations([
			DeviceOrientation.portraitUp,
		]);

		await setupLocator();
		setupDialogUi();
		setupBottomSheetUi();

		runApp(const AorteQApp());
	}, (exception, stackTrace) async {
		// Handle exceptions here
		print('Caught error: $exception');
		print('Stack trace: $stackTrace');
	});
}

class AorteQApp extends StatelessWidget {
	const AorteQApp({Key? key}) : super(key: key);

	@override
	Widget build(BuildContext context) {
		return MaterialApp(
			title: 'AorteQ - USMLE Step 1 Study Companion',
			theme: ThemeData(
				primarySwatch: Colors.purple,
			),
			home: const LoginView(),
			debugShowCheckedModeBanner: false,
		);
	}
}
