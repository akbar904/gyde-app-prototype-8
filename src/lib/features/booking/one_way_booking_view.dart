import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'one_way_booking_viewmodel.dart';

class OneWayBookingView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<OneWayBookingViewModel>.reactive(
      viewModelBuilder: () => OneWayBookingViewModel(),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          title: Text('One-Way Booking'),
          backgroundColor: Colors.black,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Enter Pickup Location',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Enter pickup location',
                  filled: true,
                  fillColor: Colors.grey[800],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: EdgeInsets.symmetric(horizontal: 16),
                ),
                style: TextStyle(color: Colors.white),
                onChanged: model.updateStartLocation,
              ),
              SizedBox(height: 20),
              Text(
                'Enter Destination',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Enter destination',
                  filled: true,
                  fillColor: Colors.grey[800],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: EdgeInsets.symmetric(horizontal: 16),
                ),
                style: TextStyle(color: Colors.white),
                onChanged: model.updateDestination,
              ),
              SizedBox(height: 20),
              Text(
                'Select Chauffeur',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Expanded(
                child: ListView.builder(
                  itemCount: model.chauffeurs.length,
                  itemBuilder: (context, index) {
                    final chauffeur = model.chauffeurs[index];
                    return ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(chauffeur.photoUrl),
                      ),
                      title: Text(
                        chauffeur.name,
                        style: TextStyle(color: Colors.white),
                      ),
                      subtitle: Text(
                        'Rating: ${chauffeur.rating}',
                        style: TextStyle(color: Colors.white70),
                      ),
                      trailing: Text(
                        chauffeur.vehicle,
                        style: TextStyle(color: Colors.white),
                      ),
                      onTap: () => model.selectChauffeur(chauffeur.name),
                    );
                  },
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  model.calculatePrice();
                  model.confirmBooking();
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue,
                  padding: EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Center(
                  child: Text(
                    'Confirm Booking',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        backgroundColor: Colors.black,
      ),
    );
  }
}
