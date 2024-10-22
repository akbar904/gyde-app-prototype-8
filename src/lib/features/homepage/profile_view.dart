import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class ProfileView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProfileViewModel>.reactive(
      viewModelBuilder: () => ProfileViewModel(),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          title: Text('Profile'),
          actions: [
            IconButton(
              icon: Icon(Icons.settings),
              onPressed: () {
                // Navigate to settings
              },
            ),
          ],
        ),
        body: Column(
          children: [
            _buildUserInfoSection(),
            _buildProfileOptions(),
            _buildAnalyticsSection(),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.directions_car),
              label: 'Rides',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Chauffeur',
            ),
          ],
          currentIndex: model.currentIndex,
          onTap: model.setIndex,
        ),
      ),
    );
  }

  Widget _buildUserInfoSection() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('John Doe',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          Text('+65 8123 4567'),
          Text('j.doe@gmail.com'),
        ],
      ),
    );
  }

  Widget _buildProfileOptions() {
    return Expanded(
      child: ListView(
        children: [
          _buildProfileOptionTile('My Subscriptions', Icons.subscriptions),
          _buildProfileOptionTile('Promos', Icons.local_offer),
          _buildProfileOptionTile('Payment Method', Icons.payment),
          _buildProfileOptionTile('Change Language', Icons.language),
          _buildProfileOptionTile('Saved Addresses', Icons.location_on),
          _buildProfileOptionTile('Notifications', Icons.notifications),
        ],
      ),
    );
  }

  Widget _buildProfileOptionTile(String title, IconData icon) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      trailing: Icon(Icons.arrow_forward_ios),
      onTap: () {
        // Handle navigation to respective sections
      },
    );
  }

  Widget _buildAnalyticsSection() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Text('Analytics',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Text('\$6400',
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                  Text('Total Spent'),
                ],
              ),
              Column(
                children: [
                  Text('94 Rides',
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                  Text('Monthly Statistics'),
                ],
              ),
              Column(
                children: [
                  Text('32%',
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                  Text('Growth'),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ProfileViewModel extends BaseViewModel {
  int _currentIndex = 0;
  int get currentIndex => _currentIndex;

  void setIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }
}
