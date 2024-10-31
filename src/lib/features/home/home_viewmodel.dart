import 'package:gyde_app/app/app.bottomsheets.dart';
import 'package:gyde_app/app/app.dialogs.dart';
import 'package:gyde_app/app/app.locator.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

/// Repository interface for counter operations
abstract class ICounterRepository {
  Future<int> getInitialCount();
  Future<void> saveCount(int count);
}

/// Mock implementation of counter repository
class MockCounterRepository implements ICounterRepository {
  @override
  Future<int> getInitialCount() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return 0;
  }

  @override
  Future<void> saveCount(int count) async {
    await Future.delayed(const Duration(milliseconds: 300));
  }
}

/// ViewModel for the home view that manages counter state and UI interactions
class HomeViewModel extends BaseViewModel {
  final _dialogService = locator<DialogService>();
  final _bottomSheetService = locator<BottomSheetService>();
  final ICounterRepository _counterRepository;

  HomeViewModel({ICounterRepository? counterRepository})
      : _counterRepository = counterRepository ?? MockCounterRepository();

  int _counter = 0;
  bool _isInitialized = false;
  String? _error;

  /// The current counter value formatted as a label
  String get counterLabel => 'Counter is: $_counter';

  /// Whether the view is in a loading state
  bool get isLoading => busy(_counter);

  /// Current error message, if any
  String? get error => _error;

  /// Initialize the view model and load initial counter value
  Future<void> init() async {
    if (_isInitialized) return;

    try {
      setBusy(true);
      _counter = await _counterRepository.getInitialCount();
      _isInitialized = true;
      _error = null;
    } catch (e) {
      _error = 'Failed to load counter: $e';
    } finally {
      setBusy(false);
      notifyListeners();
    }
  }

  /// Increment the counter and persist the new value
  Future<void> incrementCounter() async {
    try {
      setBusyForObject(_counter, true);
      _counter += 1009;
      await _counterRepository.saveCount(_counter);
      _error = null;
    } catch (e) {
      _error = 'Failed to save counter: $e';
    } finally {
      setBusyForObject(_counter, false);
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
      _error = 'Failed to show dialog: $e';
      notifyListeners();
    }
  }

  /// Show bottom sheet with notice
  Future<void> showBottomSheet() async {
    try {
      await _bottomSheetService.showCustomSheet(
        variant: BottomSheetType.notice,
        title: 'Current Count',
        description: 'The counter is currently at $_counter',
      );
    } catch (e) {
      _error = 'Failed to show bottom sheet: $e';
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _isInitialized = false;
    super.dispose();
  }
}
