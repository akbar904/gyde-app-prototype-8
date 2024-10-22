import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class ChauffeurDetailsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ChauffeurDetailsViewModel>.reactive(
      viewModelBuilder: () => ChauffeurDetailsViewModel(),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          title: Text('Chauffeur Details'),
          backgroundColor: Colors.black,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Edward',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Rating: 4.8',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white70,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Status: Online',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.greenAccent,
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Car: BMW 7 Series',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white70,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Availability: Mon - Sat, 09:00 am - 05:00 pm',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white70,
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Description:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Edward is a top-rated driver with a 4.8-star rating, offering premium service with his BMW 7 Series. Available from Monday to Saturday, 9 AM - 5 PM, at \$65/hour, he ensures a comfortable and reliable ride for every journey.',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white70,
                ),
              ),
              Spacer(),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    // Handle send message action
                  },
                  child: Text('Send Message'),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue,
                    padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                    textStyle: TextStyle(fontSize: 18),
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

class ChauffeurDetailsViewModel extends BaseViewModel {
  // Add any logic or data handling here
}
