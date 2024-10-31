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

/// ViewModel for the home view that handles counter functionality and UI interactions
class HomeViewModel extends BaseViewModel {
  final _dialogService = locator<DialogService>();
  final _bottomSheetService = locator<BottomSheetService>();
  final ICounterRepository _counterRepository;

  HomeViewModel({ICounterRepository? counterRepository})
      : _counterRepository = counterRepository ?? MockCounterRepository();

  int _counter = 0;
  bool _isLoading = false;
  String? _error;

  /// Current counter value formatted as display text
  String get counterLabel => 'Counter is: $_counter';

  /// Loading state for UI
  bool get isLoading => _isLoading;

  /// Error message if any
  String? get error => _error;

  /// Initialize the view model and load initial counter value
  Future<void> init() async {
    try {
      _isLoading = true;
      notifyListeners();

      _counter = await _counterRepository.getInitialCount();
      _error = null;
    } catch (e) {
      _error = 'Failed to load initial count: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Increment counter by 1009 and save new value
  Future<void> incrementCounter() async {
    try {
      _isLoading = true;
      notifyListeners();

      _counter += 1009;
      await _counterRepository.saveCount(_counter);
      _error = null;
    } catch (e) {
      _error = 'Failed to save counter: $e';
      // Revert increment on error
      _counter -= 1009;
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
        barrierDismissible: true,
      );
    } catch (e) {
      _error = 'Failed to show dialog: $e';
      notifyListeners();
    }
  }

  /// Show notice bottom sheet
  Future<void> showBottomSheet() async {
    try {
      await _bottomSheetService.showCustomSheet(
        variant: BottomSheetType.notice,
        title: 'Notice',
        description: 'Current count is $_counter',
        enableDrag: true,
      );
    } catch (e) {
      _error = 'Failed to show bottom sheet: $e';
      notifyListeners();
    }
  }

  @override
  void dispose() {
    // Cleanup if needed
    super.dispose();
  }
}
