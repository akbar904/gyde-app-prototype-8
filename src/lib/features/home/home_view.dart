import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:gap/gap.dart';

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
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: Column(
          children: [
            // Header section
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: viewModel.showLocationSelector,
                    child: Row(
                      children: [
                        Icon(Icons.location_on_outlined,
                            color: Theme.of(context).colorScheme.onBackground),
                        const Gap(8),
                        Text(
                          viewModel.currentLocation,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ],
                    ),
                  ),
                  CircleAvatar(
                    backgroundColor: Theme.of(context).colorScheme.surface,
                    child: IconButton(
                      icon: const Icon(Icons.person_outline),
                      onPressed: () {}, // TODO: Implement profile navigation
                    ),
                  ),
                ],
              ),
            ),

            // Service Categories
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Services',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const Gap(16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: viewModel.serviceCategories
                        .map((service) => _buildServiceCard(
                              context,
                              service,
                              _getIconForService(service),
                              () {}, // TODO: Implement service tap handling
                            ))
                        .toList(),
                  ),
                ],
              ),
            ),

            const Gap(24),

            // Featured Chauffeur
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Your Chauffeur (1/1)',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      TextButton(
                        onPressed: () {}, // TODO: Implement view all
                        child: const Text('View All'),
                      ),
                    ],
                  ),
                  const Gap(16),
                  GestureDetector(
                    onTap: viewModel.showChauffeurDetails,
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const CircleAvatar(
                                  radius: 30,
                                  backgroundImage: NetworkImage(
                                      'https://placeholder.com/chauffeur'),
                                ),
                                const Gap(16),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      viewModel.featuredChauffeur['name'],
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium,
                                    ),
                                    Row(
                                      children: [
                                        const Icon(Icons.star, size: 16),
                                        const Gap(4),
                                        Text(
                                            viewModel
                                                .featuredChauffeur['rating']
                                                .toString(),
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium),
                                      ],
                                    ),
                                  ],
                                ),
                                const Spacer(),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: Colors.green.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Text(
                                    viewModel.featuredChauffeur['status'],
                                    style: TextStyle(
                                      color: Colors.green[700],
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const Gap(16),
                            Text(
                              viewModel.featuredChauffeur['vehicle'],
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            const Gap(8),
                            Text(
                              '\$${viewModel.featuredChauffeur['pricePerHour']}/hour',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            const Gap(8),
                            Text(
                              viewModel.featuredChauffeur['availability'],
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const Gap(24),

            // Ride Management
            Expanded(
              child: DefaultTabController(
                length: 3,
                child: Column(
                  children: [
                    TabBar(
                      onTap: (index) {
                        viewModel.setRideFilter(
                            ['Upcoming', 'Past', 'Canceled'][index]);
                      },
                      tabs: const [
                        Tab(text: 'Upcoming'),
                        Tab(text: 'Past'),
                        Tab(text: 'Canceled'),
                      ],
                      labelStyle: Theme.of(context).textTheme.labelLarge,
                    ),
                    Expanded(
                      child: TabBarView(
                        children: [
                          _buildRidesList(context, viewModel, 'Upcoming'),
                          _buildRidesList(context, viewModel, 'Past'),
                          _buildRidesList(context, viewModel, 'Canceled'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {}, // TODO: Implement book ride
        label: const Text('Book a Ride'),
        icon: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildServiceCard(
      BuildContext context, String title, IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Icon(icon, size: 32),
              const Gap(8),
              Text(
                title,
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRidesList(
      BuildContext context, HomeViewModel viewModel, String filter) {
    if (viewModel.rides.isEmpty) {
      return _buildEmptyState(context, 'No $filter rides');
    }
    return ListView.builder(
      itemCount: viewModel.rides.length,
      itemBuilder: (context, index) {
        // TODO: Implement ride list item
        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildEmptyState(BuildContext context, String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.car_rental, size: 64),
          const Gap(16),
          Text(
            message,
            style: Theme.of(context).textTheme.bodyLarge,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  IconData _getIconForService(String service) {
    switch (service) {
      case 'Airport Trips':
        return Icons.airplane_ticket_outlined;
      case 'Eco Friendly':
        return Icons.eco_outlined;
      case 'Shared Rides':
        return Icons.people_outline;
      default:
        return Icons.car_rental;
    }
  }

  @override
  HomeViewModel viewModelBuilder(BuildContext context) => HomeViewModel();
}
