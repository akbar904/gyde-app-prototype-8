
final locator = StackedLocator.instance;

Future<void> setupLocator({
	String? environment,
	EnvironmentFilter? environmentFilter,
}) async {
	// Register environments
	locator.registerEnvironment(
		environment: environment,
		environmentFilter: environmentFilter,
	);

	// Register dependencies
	locator.registerLazySingleton(() => BottomSheetService());
	locator.registerLazySingleton(() => DialogService());
	locator.registerLazySingleton(() => NavigationService());
}
