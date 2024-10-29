import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:flutter/material.dart';
import 'package:gyde_app/app/app.locator.dart';
import 'package:gyde_app/app/app.router.dart';
import 'package:gyde_app/models/booking.dart';

class OneWayBookingViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _dialogService = locator<DialogService>();

  String pickupLocation = '';
  String dropoffLocation = '';
  DateTime? pickupTime;
  String selectedVehicle = '';
  String selectedChauffeur = '';
  double price = 0.0;
  bool isPickupLocationValid = false;
  bool isDropoffLocationValid = false;

  void setPickupLocation(String location) {
    pickupLocation = location;
    isPickupLocationValid = location.isNotEmpty;
    notifyListeners();
  }

  void setDropoffLocation(String location) {
    dropoffLocation = location;
    isDropoffLocationValid = location.isNotEmpty;
    notifyListeners();
  }

  void setPickupTime(DateTime time) {
    pickupTime = time;
    notifyListeners();
  }

  void selectVehicle(String vehicle) {
    selectedVehicle = vehicle;
    calculatePrice();
    notifyListeners();
  }

  void selectChauffeur(String chauffeur) {
    selectedChauffeur = chauffeur;
    notifyListeners();
  }

  void calculatePrice() {
    // Price calculation logic based on distance, vehicle type etc
    price = 65.0; // Default price for now
    notifyListeners();
  }

  bool get canProceed {
    return isPickupLocationValid &&
        isDropoffLocationValid &&
        pickupTime != null &&
        selectedVehicle.isNotEmpty &&
        selectedChauffeur.isNotEmpty;
  }

  Future<void> confirmBooking() async {
    if (!canProceed) {
      await _dialogService.showDialog(
          title: 'Incomplete Booking',
          description: 'Please fill in all required fields');
      return;
    }

    setBusy(true);

    try {
      // Booking creation logic here
      final booking = Booking(
          pickupLocation: pickupLocation,
          dropoffLocation: dropoffLocation,
          pickupTime: pickupTime!,
          vehicle: selectedVehicle,
          chauffeur: selectedChauffeur,
          price: price);

      // Save booking
      await Future.delayed(Duration(seconds: 2)); // Simulate API call

      await _navigationService.navigateToHomeView();
    } catch (e) {
      await _dialogService.showDialog(
          title: 'Error',
          description: 'Failed to create booking. Please try again.');
    } finally {
      setBusy(false);
    }
  }

  void navigateBack() {
    _navigationService.back();
  }
}
