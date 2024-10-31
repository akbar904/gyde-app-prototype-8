import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'home_viewmodel.dart';

class HomeView extends StackedView<HomeViewModel> {
  const HomeView({super.key});

  @override
  Widget builder(
    BuildContext context,
    HomeViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            HeaderSection(),
            ServiceCategories(),
            FeaturedChauffeurSection(),
            RideManagementSection(),
          ],
        ),
      ),
    );
  }

  @override
  HomeViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      HomeViewModel();

  @override
  void onViewModelReady(HomeViewModel viewModel) {
    viewModel.loadHomeData();
    super.onViewModelReady(viewModel);
  }
}

class HeaderSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'New York, USA',
            style: Theme.of(context).textTheme.headline6,
          ),
          Icon(Icons.person),
        ],
      ),
    );
  }
}

class ServiceCategories extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          CategoryCard(title: "Airport Trips"),
          CategoryCard(title: "Eco Friendly"),
          CategoryCard(title: "Shared Rides"),
        ],
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  final String title;

  const CategoryCard({required this.title});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(title),
      ),
    );
  }
}

class FeaturedChauffeurSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Your Chauffeur (1/1)',
            style: Theme.of(context).textTheme.subtitle1,
          ),
          ChauffeurProfile(),
        ],
      ),
    );
  }
}

class ChauffeurProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Image.asset('assets/images/edward.jpg', width: 50, height: 50),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Edward'),
                Text('Rating: 4.8'),
                Text('Status: Online'),
                Text('Vehicle: BMW 7 Series'),
                Text('Price: \$65/hour'),
                Text('Availability: Mon - Sat, 09:00 am - 05:00 pm'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class RideManagementSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Manage Your Rides'),
            SegmentedControl(),
            Expanded(child: RideList()),
          ],
        ),
      ),
    );
  }
}

class SegmentedControl extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text('Upcoming'),
          Text('Past'),
          Text('Canceled'),
        ],
      ),
    );
  }
}

class RideList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        // Empty states or ride cards will be implemented here.
        Center(child: Text('No rides available')),
      ],
    );
  }
}
