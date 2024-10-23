import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class MainRidesView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: Row(
              children: [
                Icon(Icons.location_on),
                Text('New York, USA'),
                Spacer(),
                IconButton(
                  icon: Icon(Icons.person),
                  onPressed: () {
                    // Navigate to profile
                  },
                )
              ],
            ),
            bottom: TabBar(
              tabs: [
                Tab(text: 'Upcoming'),
                Tab(text: 'Past'),
                Tab(text: 'Canceled')
              ],
            ),
          ),
          body: TabBarView(
            children: [
              _buildUpcomingRidesView(),
              _buildPastRidesView(),
              _buildCanceledRidesView()
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
          ),
        ));
  }

  Widget _buildUpcomingRidesView() {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildServiceCategories(),
          _buildFeaturedChauffeur(),
          _buildCorporatePackage(),
          Center(
            child: Column(
              children: [
                Text('You have no upcoming rides'),
                Text(
                    'As soon as you book a ride, all of your relevant details will be shown here'),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildServiceCategories() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildServiceCard('Airport Trips'),
        _buildServiceCard('Eco Friendly'),
        _buildServiceCard('Shared Rides'),
      ],
    );
  }

  Widget _buildServiceCard(String title) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(title),
      ),
    );
  }

  Widget _buildFeaturedChauffeur() {
    return Card(
      child: Column(
        children: [
          Text('Your Chauffeur (1/1)'),
          ListTile(
            leading: CircleAvatar(),
            title: Text('Edward'),
            subtitle: Row(
              children: [
                Text('4.8'),
                Icon(Icons.star),
                Text('Online'),
              ],
            ),
          ),
          Text('BMW 7 Series'),
          Text('Mon - Sat, 09:00 am - 05:00 pm'),
          Text(
              'Edward is a top-rated driver with a 4.8-star rating, offering premium service with his BMW 7 Series. Available from Monday to Saturday, 9 AM - 5 PM, at \$65/hour, he ensures a comfortable and reliable ride for every journey.'),
        ],
      ),
    );
  }

  Widget _buildCorporatePackage() {
    return Card(
      child: Column(
        children: [
          Text('Corporate Elite Package'),
          Text('Monthly Fee \$5000'),
        ],
      ),
    );
  }

  Widget _buildPastRidesView() {
    return Center(
      child: Column(
        children: [
          Text('You have no past rides'),
          Text(
              'As soon as you book a ride, all of your relevant details will be shown here'),
        ],
      ),
    );
  }

  Widget _buildCanceledRidesView() {
    return Center(
      child: Column(
        children: [
          Text('No canceled rides'),
          Text(
              'As soon as you book a ride, all of your relevant details will be shown here'),
        ],
      ),
    );
  }
}
