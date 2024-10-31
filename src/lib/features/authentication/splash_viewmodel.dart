import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:flutter/material.dart';

import '../../app/app.locator.dart';
import '../../app/app.router.dart';
import '../../services/authentication_service.dart';
import '../../services/connectivity_service.dart';
import '../../services/local_storage_service.dart';

/// Repository interface for initialization checks
abstract class ISplashRepository {
  Future<bool> checkInitialSetup();
  Future<bool> checkAuthentication();
}

/// Mock implementation of splash repository
class MockSplashRepository implements ISplashRepository {
  @override
  Future<bool> checkInitialSetup() async {
    await Future.delayed(const Duration(seconds: 1));
    return true;
  }

  @override
  Future<bool> checkAuthentication() async {
    await Future.delayed(const Duration(seconds: 1));
    return false;
  }
}

/// ViewModel for the splash screen that handles initialization and routing
class SplashViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _authService = locator<AuthenticationService>();
  final _connectivityService = locator<ConnectivityService>();
  final _storageService = locator<LocalStorageService>();
  final ISplashRepository _splashRepository;

  bool _hasError = false;
  String _errorMessage = '';
  bool get hasError => _hasError;
  String get errorMessage => _errorMessage;

  SplashViewModel({ISplashRepository? splashRepository})
      : _splashRepository = splashRepository ?? MockSplashRepository();

  /// Initializes the app by checking connectivity, authentication and routing accordingly
  Future<void> initialize() async {
    try {
      setBusy(true);

      // Check internet connectivity
      if (!await _connectivityService.checkConnectivity()) {
        _setError('No internet connection available');
        return;
      }

      // Check if first time setup is needed
      final needsSetup = await _splashRepository.checkInitialSetup();
      if (needsSetup) {
        await Future.delayed(
            const Duration(seconds: 2)); // Show splash minimum time
        await _navigationService.replaceWith(Routes.welcomeView);
        return;
      }

      // Check authentication status
      final isAuthenticated = await _splashRepository.checkAuthentication();
      if (isAuthenticated) {
        await _navigationService.replaceWith(Routes.homeView);
      } else {
        await _navigationService.replaceWith(Routes.welcomeView);
      }
    } catch (e) {
      _setError('Failed to initialize app: ${e.toString()}');
    } finally {
      setBusy(false);
    }
  }

  void _setError(String message) {
    _hasError = true;
    _errorMessage = message;
    notifyListeners();
  }

  @override
  void dispose() {
    // Cleanup if needed
    super.dispose();
  }
}
