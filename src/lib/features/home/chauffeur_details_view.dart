import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:gap/gap.dart';
import '../home/home_viewmodel.dart';

class ChauffeurDetailsView extends StatelessWidget {
  const ChauffeurDetailsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      viewModelBuilder: () => HomeViewModel(),
      builder: (context, model, child) => Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Profile header
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundImage: AssetImage('assets/images/edward.jpg'),
                      ),
                      const Gap(16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Edward',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          Row(
                            children: [
                              const Icon(Icons.star, color: Colors.amber),
                              Text('4.8',
                                  style: Theme.of(context).textTheme.bodyLarge),
                            ],
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Text(
                              'Online',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  const Gap(24),

                  // Car details
                  Text(
                    'Car Information',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const Gap(8),
                  Text(
                    'BMW 7 Series',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),

                  const Gap(24),

                  // Availability
                  Text(
                    'Availability',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const Gap(8),
                  Text(
                    'Mon - Sat, 09:00 am - 05:00 pm',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),

                  const Gap(24),

                  // Description
                  Text(
                    'About Edward',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const Gap(8),
                  Text(
                    'Edward is a top-rated driver with a 4.8-star rating, offering premium service with his BMW 7 Series. Available from Monday to Saturday, 9 AM - 5 PM, at \$65/hour, he ensures a comfortable and reliable ride for every journey.',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),

                  const Gap(32),

                  // Message button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text('Send Message'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: 2,
          items: const [
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
          onTap: (index) {
            model.navigateToBottomTab(index);
          },
        ),
      ),
    );
  }
}
