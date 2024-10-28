import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class ModeSelectionView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ModeSelectionViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Select Your Mode',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Please let us know which account type suits you best.',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white70,
                  ),
                ),
                const SizedBox(height: 32),
                _buildModeCard(
                  context,
                  title: 'Business Mode',
                  icon: Icons.business,
                  onTap: () => model.selectBusinessMode(),
                ),
                const SizedBox(height: 16),
                _buildModeCard(
                  context,
                  title: 'Personal Mode',
                  icon: Icons.person,
                  onTap: () => model.selectPersonalMode(),
                ),
              ],
            ),
          ),
        ),
      ),
      viewModelBuilder: () => ModeSelectionViewModel(),
    );
  }

  Widget _buildModeCard(
    BuildContext context, {
    required String title,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: Colors.white24,
            width: 1,
          ),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: 32,
              color: Colors.white,
            ),
            const SizedBox(width: 16),
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
            const Spacer(),
            const Icon(
              Icons.arrow_forward_ios,
              color: Colors.white54,
            ),
          ],
        ),
      ),
    );
  }
}

class ModeSelectionViewModel extends BaseViewModel {
  void selectBusinessMode() {
    // Navigate to profile information view with business mode
  }

  void selectPersonalMode() {
    // Navigate to profile information view with personal mode
  }
}
