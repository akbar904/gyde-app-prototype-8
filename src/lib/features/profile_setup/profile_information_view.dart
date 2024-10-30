import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:com.com.walturn.gyde_app/features/profile_setup/profile_information_viewmodel.dart';
import 'package:com.com.walturn.gyde_app/ui/common/ui_helpers.dart';

class ProfileInformationView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProfileInformationViewModel>.reactive(
      viewModelBuilder: () => ProfileInformationViewModel(),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          title: Text('Profile Information'),
          backgroundColor: Colors.black,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Enter Your Information',
                style: Theme.of(context).textTheme.headline6?.copyWith(
                      color: Colors.white,
                    ),
              ),
              verticalSpaceMedium,
              TextField(
                decoration: InputDecoration(
                  labelText: 'First Name',
                  labelStyle: TextStyle(color: Colors.grey),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
                style: TextStyle(color: Colors.white),
                onChanged: model.setFirstName,
              ),
              verticalSpaceSmall,
              TextField(
                decoration: InputDecoration(
                  labelText: 'Last Name',
                  labelStyle: TextStyle(color: Colors.grey),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
                style: TextStyle(color: Colors.white),
                onChanged: model.setLastName,
              ),
              verticalSpaceSmall,
              TextField(
                decoration: InputDecoration(
                  labelText: model.isBusinessMode ? 'Company Name' : 'Optional',
                  labelStyle: TextStyle(color: Colors.grey),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
                style: TextStyle(color: Colors.white),
                onChanged: model.setCompanyName,
              ),
              verticalSpaceSmall,
              SwitchListTile(
                title: Text(
                  'Business Mode',
                  style: TextStyle(color: Colors.white),
                ),
                value: model.isBusinessMode,
                onChanged: model.setIsBusinessMode,
                activeColor: Colors.blue,
                inactiveThumbColor: Colors.grey,
                inactiveTrackColor: Colors.white30,
              ),
              Spacer(),
              ElevatedButton(
                onPressed: () async {
                  try {
                    await model.submitProfileInformation();
                    // Navigate to the next page or show success message
                  } catch (e) {
                    // Show error message
                  }
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue,
                  onPrimary: Colors.white,
                ),
                child: Center(
                  child: Text('Continue'),
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
