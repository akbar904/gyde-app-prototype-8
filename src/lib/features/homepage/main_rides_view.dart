import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class MainRidesView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MainRidesViewModel>.reactive(
      viewModelBuilder: () => MainRidesViewModel(),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          title: Text('New York, USA'),
          actions: [
            IconButton(
              icon: Icon(Icons.person),
              onPressed: () {
                // Navigate to Profile Page
              },
            )
          ],
        ),
        body: Column(
          children: [
            SegmentedControl(),
            Expanded(
              child: PageView(
                controller: model.pageController,
                children: [
                  RidesListView(
                      type: 'Upcoming',
                      emptyMessage: 'You have no upcoming rides'),
                  RidesListView(
                      type: 'Past', emptyMessage: 'You have no past rides'),
                  RidesListView(
                      type: 'Canceled', emptyMessage: 'No canceled rides'),
                ],
              ),
            ),
            FeaturedChauffeurSection(),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(Icons.directions_car), label: 'Rides'),
            BottomNavigationBarItem(
                icon: Icon(Icons.person), label: 'Chauffeur'),
          ],
          currentIndex: model.currentTabIndex,
          onTap: model.setTabIndex,
        ),
      ),
    );
  }
}

class MainRidesViewModel extends BaseViewModel {
  int _currentTabIndex = 0;
  PageController _pageController = PageController();

  int get currentTabIndex => _currentTabIndex;
  PageController get pageController => _pageController;

  void setTabIndex(int index) {
    _currentTabIndex = index;
    notifyListeners();
  }
}

class SegmentedControl extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SegmentButton(label: 'Upcoming'),
          SegmentButton(label: 'Past'),
          SegmentButton(label: 'Canceled'),
        ],
      ),
    );
  }
}

class SegmentButton extends StatelessWidget {
  final String label;
  SegmentButton({required this.label});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        // Update the ViewModel to change the segment
      },
      child: Text(label),
    );
  }
}

class RidesListView extends StatelessWidget {
  final String type;
  final String emptyMessage;

  RidesListView({required this.type, required this.emptyMessage});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(emptyMessage),
    );
  }
}

class FeaturedChauffeurSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Your Chauffeur (1/1)',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Row(
              children: [
                CircleAvatar(
                  child: Text('E'),
                ),
                SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Edward', style: TextStyle(fontSize: 16)),
                    Text('Rating: 4.8'),
                    Text('Status: Online'),
                  ],
                ),
              ],
            ),
            SizedBox(height: 8),
            Text('Car: BMW 7 Series'),
            Text('Availability: Mon - Sat, 09:00 am - 05:00 pm'),
            SizedBox(height: 8),
            Text(
              'Edward is a top-rated driver with a 4.8-star rating, offering premium service with his BMW 7 Series. Available from Monday to Saturday, 9 AM - 5 PM, at \$65/hour, he ensures a comfortable and reliable ride for every journey.',
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
