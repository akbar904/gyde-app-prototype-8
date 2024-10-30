import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'hourly_booking_viewmodel.dart';

class HourlyBookingView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HourlyBookingViewModel>.reactive(
      viewModelBuilder: () => HourlyBookingViewModel(),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          title: Text('Hourly Booking'),
          backgroundColor: Colors.black,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Select Duration',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
              SizedBox(height: 10),
              _buildDurationSelector(model),
              SizedBox(height: 20),
              _buildPricingDetails(model),
              Spacer(),
              _buildTermsAndConditions(model),
              SizedBox(height: 20),
              _buildBookButton(model),
            ],
          ),
        ),
        backgroundColor: Colors.black,
      ),
    );
  }

  Widget _buildDurationSelector(HourlyBookingViewModel model) {
    return DropdownButton<int>(
      value: model.duration,
      dropdownColor: Colors.grey[900],
      items: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10] // Example duration options
          .map((duration) => DropdownMenuItem(
                value: duration,
                child: Text(
                  '$duration hours',
                  style: TextStyle(color: Colors.white),
                ),
              ))
          .toList(),
      onChanged: (value) {
        if (value != null) {
          model.setDuration(value);
        }
      },
      underline: Container(
        height: 2,
        color: Colors.white,
      ),
    );
  }

  Widget _buildPricingDetails(HourlyBookingViewModel model) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Pricing Details:',
          style: TextStyle(fontSize: 16, color: Colors.white),
        ),
        SizedBox(height: 5),
        Text(
          '\$${model.totalPrice.toStringAsFixed(2)}',
          style: TextStyle(fontSize: 24, color: Colors.white),
        ),
      ],
    );
  }

  Widget _buildTermsAndConditions(HourlyBookingViewModel model) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          model.terms,
          style: TextStyle(color: Colors.grey),
        ),
        SizedBox(height: 10),
        ElevatedButton(
          onPressed: model.acceptTerms,
          style: ElevatedButton.styleFrom(
            primary: Colors.blueAccent,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          ),
          child: Text(
            'Accept Terms',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }

  Widget _buildBookButton(HourlyBookingViewModel model) {
    return ElevatedButton(
      onPressed: () {
        // Implement booking logic, e.g., navigating to a confirmation page
      },
      style: ElevatedButton.styleFrom(
        primary: Colors.blueAccent,
        padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
      ),
      child: Text(
        'Book Now',
        style: TextStyle(fontSize: 16, color: Colors.white),
      ),
    );
  }
}
