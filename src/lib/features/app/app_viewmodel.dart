import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'dart:async';

// Define a repository interface for the app's data
abstract class AppRepository {
  Future<void> fetchData();
  Future<void> saveData(String data);
}

// A mock implementation of the AppRepository for testing
class MockAppRepository implements AppRepository {
  @override
  Future<void> fetchData() async {
    await Future.delayed(Duration(seconds: 1)); // Simulate network delay
  }

  @override
  Future<void> saveData(String data) async {
    await Future.delayed(Duration(seconds: 1)); // Simulate network delay
    // Here you would normally handle data saving logic
  }
}

class AppViewModel extends BaseViewModel {
  final AppRepository _repository;

  // Properties
  String _data = '';
  String get data => _data;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  // Constructor with dependency injection
  AppViewModel(this._repository);

  /// Initializes the ViewModel and fetches initial data.
  Future<void> init() async {
    setBusy(true);
    try {
      await _repository.fetchData();
      // Assume data is fetched successfully and assigned
      _data = 'Fetched Data'; // Placeholder for actual data
    } catch (e) {
      _errorMessage = 'Failed to fetch data: $e';
    } finally {
      setBusy(false);
    }
  }

  /// Saves the current data.
  Future<void> saveCurrentData() async {
    if (_data.isEmpty) {
      _errorMessage = 'Data cannot be empty';
      notifyListeners();
      return;
    }

    setBusy(true);
    try {
      await _repository.saveData(_data);
      _errorMessage = null; // Clear any previous error
    } catch (e) {
      _errorMessage = 'Failed to save data: $e';
    } finally {
      setBusy(false);
    }
  }

  /// Clears any error message.
  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  /// Additional method to update data
  void updateData(String newData) {
    _data = newData;
    notifyListeners();
  }
}
