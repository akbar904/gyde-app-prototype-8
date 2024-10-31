import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:aorteq_app/features/authentication/user_info_viewmodel.dart';

class UserInfoView extends StackedView<UserInfoViewModel> {
  const UserInfoView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    UserInfoViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tell us about yourself'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              decoration: const InputDecoration(
                labelText: 'Name',
                hintText: 'Enter your full name',
              ),
              textInputAction: TextInputAction.next,
              onChanged: viewModel.setName,
            ),
            const SizedBox(height: 16),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Email',
                hintText: 'Enter your email address',
              ),
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.done,
              onChanged: viewModel.setEmail,
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: viewModel.isBusy
                  ? null
                  : () => viewModel.saveUserInfo(
                        viewModel.name,
                        viewModel.email,
                      ),
              child: viewModel.isBusy
                  ? const CircularProgressIndicator()
                  : const Text('Next'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  UserInfoViewModel viewModelBuilder(BuildContext context) =>
      UserInfoViewModel();
}
