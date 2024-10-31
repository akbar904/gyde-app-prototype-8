import 'package:gyde_app/app/app.bottomsheets.dart';
import 'package:gyde_app/app/app.dialogs.dart';
import 'package:gyde_app/app/app.locator.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

/// Interface for counter persistence and business logic
abstract class ICounterRepository {
  Future<int> getCounter();
  Future<void> saveCounter(int value);
}

/// Mock implementation of counter repository
class MockCounterRepository implements ICounterRepository {
  int _counter = 0;

  @override
  Future<int> getCounter() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _counter;
  }

  @override
  Future<void> saveCounter(int value) async {
    await Future.delayed(const Duration(milliseconds: 300));
    _counter = value;
  }
}

/// ViewModel for the HomeView that manages counter state and UI interactions
class HomeViewModel extends BaseViewModel {
  final _dialogService = locator<DialogService>();
  final _bottomSheetService = locator<BottomSheetService>();
  final ICounterRepository _counterRepository;

  HomeViewModel({ICounterRepository? counterRepository})
      : _counterRepository = counterRepository ?? MockCounterRepository();

  int _counter = 0;
  bool _isLoading = false;
  String _errorMessage = '';

  /// Current counter value formatted for display
  String get counterLabel => 'Counter is: $_counter';

  /// Whether view is in loading state
  bool get isLoading => _isLoading;

  /// Current error message if any
  String get errorMessage => _errorMessage;

  /// Initialize the view model by loading saved counter
  Future<void> init() async {
    _isLoading = true;
    notifyListeners();

    try {
      _counter = await _counterRepository.getCounter();
    } catch (e) {
      _errorMessage = 'Failed to load counter: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Increment counter and persist new value
  Future<void> incrementCounter() async {
    _isLoading = true;
    notifyListeners();

    try {
      _counter += 1009;
      await _counterRepository.saveCounter(_counter);
      _errorMessage = '';
    } catch (e) {
      _errorMessage = 'Failed to save counter: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Show info dialog with current counter value
  Future<void> showDialog() async {
    try {
      await _dialogService.showCustomDialog(
        variant: DialogType.infoAlert,
        title: 'Steve Rocks!',
        description: 'Give steve $_counter stars on Github',
      );
    } catch (e) {
      _errorMessage = 'Failed to show dialog: $e';
      notifyListeners();
    }
  }

  /// Show bottom sheet with notice
  Future<void> showBottomSheet() async {
    try {
      await _bottomSheetService.showCustomSheet(
        variant: BottomSheetType.notice,
        title: 'Notice',
        description: 'Current counter value is $_counter',
      );
    } catch (e) {
      _errorMessage = 'Failed to show bottom sheet: $e';
      notifyListeners();
    }
  }

  @override
  void dispose() {
    // Cleanup if needed
    super.dispose();
  }
}
