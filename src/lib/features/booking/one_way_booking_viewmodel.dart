import 'package:stacked/stacked.dart';
import 'package:flutter/material.dart';

class OneWayBookingViewModel extends BaseViewModel {
  // Define the properties and methods that will manage the booking logic

  // Holds the selected start location for the booking
  String _startLocation = '';
  String get startLocation => _startLocation;

  // Holds the selected destination location
  String _destination = '';
  String get destination => _destination;

  // Holds the selected chauffeur's information
  String _selectedChauffeur = '';
  String get selectedChauffeur => _selectedChauffeur;

  // Holds the selected vehicle details
  String _vehicleDetails = '';
  String get vehicleDetails => _vehicleDetails;

  // Holds the calculated price for the booking
  double _price = 0.0;
  double get price => _price;

  // Method to update the start location
  void updateStartLocation(String location) {
    _startLocation = location;
    notifyListeners();
  }

  // Method to update the destination
  void updateDestination(String location) {
    _destination = location;
    notifyListeners();
  }

  // Method to select a chauffeur
  void selectChauffeur(String chauffeur) {
    _selectedChauffeur = chauffeur;
    notifyListeners();
  }

  // Method to set vehicle details
  void setVehicleDetails(String details) {
    _vehicleDetails = details;
    notifyListeners();
  }

  // Method to calculate and set the price
  void calculatePrice() {
    // Placeholder logic for price calculation
    _price = 100.0; // This is a placeholder value
    notifyListeners();
  }

  // Additional methods and properties can be added to support other booking functionalities
}
