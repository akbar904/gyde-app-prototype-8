import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:com.com.walturn.gyde_app/features/booking/multi_stop_booking_viewmodel.dart';
import 'package:com.com.walturn.gyde_app/ui/common/app_colors.dart'; // Assuming this file contains color definitions
import 'package:com.com.walturn.gyde_app/ui/common/ui_helpers.dart'; // Assuming this file contains UI helper methods

class MultiStopBookingView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MultiStopBookingViewModel>.reactive(
      viewModelBuilder: () => MultiStopBookingViewModel(),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          title:
              Text('Multi-Stop Booking', style: TextStyle(color: Colors.white)),
          backgroundColor: AppColors.primaryColor,
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: model.stops.length,
                itemBuilder: (context, index) => ListTile(
                  title: Text('Stop ${index + 1}',
                      style: TextStyle(color: Colors.white)),
                  subtitle: Text(model.stops[index],
                      style: TextStyle(color: Colors.white70)),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: model.addStop,
                child: Text('Add Stop', style: TextStyle(color: Colors.white)),
                style: ElevatedButton.styleFrom(
                  primary: AppColors.primaryColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
