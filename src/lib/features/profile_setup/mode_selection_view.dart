import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:com.com.walturn.gyde_app/features/profile_setup/mode_selection_viewmodel.dart';

class ModeSelectionView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ModeSelectionViewModel>.reactive(
      viewModelBuilder: () => ModeSelectionViewModel(),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          title: Text('Select Your Mode'),
          backgroundColor: Colors.black,
        ),
        backgroundColor: Colors.grey[900],
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Please let us know which account type suits you best.',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 20),
              Expanded(
                child: ListView(
                  children: [
                    _buildModeCard(
                      context: context,
                      title: 'Business Mode',
                      description: 'Ideal for corporate users.',
                      icon: Icons.business,
                      isSelected: model.selectedMode == 'Business',
                      onTap: () => model.selectMode('Business'),
                    ),
                    SizedBox(height: 16),
                    _buildModeCard(
                      context: context,
                      title: 'Personal Mode',
                      description: 'Ideal for personal use.',
                      icon: Icons.person,
                      isSelected: model.selectedMode == 'Personal',
                      onTap: () => model.selectMode('Personal'),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: model.proceedToProfileInformation,
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue,
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  ),
                  child: Text(
                    'Continue',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildModeCard({
    required BuildContext context,
    required String title,
    required String description,
    required IconData icon,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: isSelected ? Colors.blueGrey : Colors.grey[850],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Icon(
                icon,
                size: 40,
                color: Colors.white,
              ),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      description,
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              if (isSelected)
                Icon(
                  Icons.check_circle,
                  color: Colors.green,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
