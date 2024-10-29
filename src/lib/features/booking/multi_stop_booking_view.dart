import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:gyde_app/ui/common/app_colors.dart';
import 'package:gyde_app/ui/common/ui_helpers.dart';
import 'package:gap/gap.dart';
import 'multi_stop_booking_viewmodel.dart';

class MultiStopBookingView extends StackedView<MultiStopBookingViewModel> {
  @override
  Widget builder(BuildContext context, MultiStopBookingViewModel viewModel,
      Widget? child) {
    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Multi-Stop Booking',
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.w600),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: LatLng(40.7128, -74.0060),
                  zoom: 12,
                ),
                markers: viewModel.markers,
                polylines: viewModel.routePolylines,
                onMapCreated: viewModel.onMapCreated,
              ),
            ),
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                  color: AppColors.darkSecondary,
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(20))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Add Stops',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600),
                  ),
                  Gap(16),
                  ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: viewModel.stops.length + 1,
                      itemBuilder: (context, index) {
                        if (index == viewModel.stops.length) {
                          return TextButton(
                            onPressed: viewModel.addStop,
                            child: Text(
                              '+ Add Another Stop',
                              style: TextStyle(color: Colors.blue),
                            ),
                          );
                        }
                        return ListTile(
                          leading: CircleAvatar(
                            child: Text('${index + 1}'),
                            backgroundColor: Colors.blue,
                          ),
                          title: Text(
                            viewModel.stops[index],
                            style: TextStyle(color: Colors.white),
                          ),
                          trailing: IconButton(
                            icon: Icon(Icons.remove_circle_outline,
                                color: Colors.red),
                            onPressed: () => viewModel.removeStop(index),
                          ),
                        );
                      }),
                  Gap(16),
                  if (viewModel.stops.length >= 2)
                    ElevatedButton(
                      onPressed: viewModel.proceedToBooking,
                      child: Text('Continue to Booking'),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.blue,
                        minimumSize: Size(double.infinity, 50),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  MultiStopBookingViewModel viewModelBuilder(BuildContext context) =>
      MultiStopBookingViewModel();
}
