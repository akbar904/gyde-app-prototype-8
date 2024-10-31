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
    await Future.delayed(const Duration(milliseconds: 500));
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

  /// The current counter value formatted for display
  String get counterLabel => 'Counter is: $_counter';

  /// Whether the view is in a loading state
  bool get isLoading => busy(_counter);

  /// Whether the view has been initialized
  bool get isInitialized => _isInitialized;

  /// Initialize the view model and load initial counter value
  Future<void> init() async {
    if (_isInitialized) return;

    try {
      setBusy(true);
      _counter = await _counterRepository.getInitialCount();
      _isInitialized = true;
      notifyListeners();
    } catch (e) {
      setError('Failed to load initial counter value');
    } finally {
      setBusy(false);
    }
  }

  /// Increment the counter by 1009 and save the new value
  Future<void> incrementCounter() async {
    try {
      setBusyForObject(_counter, true);
      _counter += 1009;
      await _counterRepository.saveCount(_counter);
      notifyListeners();
    } catch (e) {
      setError('Failed to save counter value');
      _counter -= 1009; // Revert on error
      notifyListeners();
    } finally {
      setBusyForObject(_counter, false);
    }
  }

  /// Show an info dialog with the current counter value
  Future<void> showDialog() async {
    try {
      await _dialogService.showCustomDialog(
        variant: DialogType.infoAlert,
        title: 'Steve Rocks!',
        description: 'Give steve $_counter stars on Github',
      );
    } catch (e) {
      setError('Failed to show dialog');
    }
  }

  /// Show a notice bottom sheet
  Future<void> showBottomSheet() async {
    try {
      await _bottomSheetService.showCustomSheet(
        variant: BottomSheetType.notice,
        title: 'Current Count',
        description: 'The counter is currently at $_counter',
      );
    } catch (e) {
      setError('Failed to show bottom sheet');
    }
  }

  @override
  void dispose() {
    // Cleanup any resources
    super.dispose();
  }
}
