import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:gyde_app/ui/common/app_colors.dart';
import 'package:gyde_app/ui/common/ui_helpers.dart';
import 'package:gap/gap.dart';
import 'multi_stop_booking_viewmodel.dart';

class MultiStopBookingView extends StackedView<MultiStopBookingViewModel> {
  const MultiStopBookingView({super.key});

  @override
  Widget builder(BuildContext context, MultiStopBookingViewModel viewModel,
      Widget? child,) {
    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Multi-Stop Booking',
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.w600,),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
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
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                  color: AppColors.darkSecondary,
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(20)),),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Add Stops',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,),
                  ),
                  const Gap(16),
                  ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: viewModel.stops.length + 1,
                      itemBuilder: (context, index) {
                        if (index == viewModel.stops.length) {
                          return TextButton(
                            onPressed: viewModel.addStop,
                            child: const Text(
                              '+ Add Another Stop',
                              style: TextStyle(color: Colors.blue),
                            ),
                          );
                        }
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.blue,
                            child: Text('${index + 1}'),
                          ),
                          title: Text(
                            viewModel.stops[index],
                            style: const TextStyle(color: Colors.white),
                          ),
                          trailing: IconButton(
                            icon: const Icon(Icons.remove_circle_outline,
                                color: Colors.red,),
                            onPressed: () => viewModel.removeStop(index),
                          ),
                        );
                      },),
                  const Gap(16),
                  if (viewModel.stops.length >= 2)
                    ElevatedButton(
                      onPressed: viewModel.proceedToBooking,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        minimumSize: const Size(double.infinity, 50),
                      ),
                      child: const Text('Continue to Booking'),
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
