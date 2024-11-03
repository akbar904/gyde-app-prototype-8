
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'login_viewmodel.dart';

class LoginView extends StatelessWidget {
	@override
	Widget build(BuildContext context) {
		return ViewModelBuilder.reactive(
			viewModelBuilder: () => LoginViewModel(),
			onModelReady: (model) {
				// Perform any initialization if necessary
			},
			builder: (context, model, child) {
				return Scaffold(
					appBar: AppBar(
						title: Text('Login with your AorteQ account'),
					),
					body: Padding(
						padding: const EdgeInsets.all(16.0),
						child: Column(
							mainAxisAlignment: MainAxisAlignment.center,
							children: [
								TextField(
									decoration: InputDecoration(
										labelText: 'Email',
										errorText: model.emailError,
									),
									keyboardType: TextInputType.emailAddress,
									onChanged: model.updateEmail,
								),
								TextField(
									decoration: InputDecoration(
										labelText: 'Password',
										suffixIcon: IconButton(
											icon: Icon(Icons.visibility),
											onPressed: () {
												model.togglePasswordVisibility(); // Toggle password visibility
											},
										),
										errorText: model.passwordError,
									),
									obscureText: model.isPasswordVisible ? false : true,
									onChanged: model.updatePassword,
								),
								Align(
									alignment: Alignment.centerRight,
									child: Text(
										'Forgot Password?',
										style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Theme.of(context).colorScheme.primary),
									),
								),
								if (model.isBusy) 
									CircularProgressIndicator() // Loading indicator
								else 
									ElevatedButton(
										onPressed: model.login,
										child: Text('Login'),
										style: ElevatedButton.styleFrom(primary: Theme.of(context).colorScheme.primary),
									),
								Divider(),
								Text('Or'),
								ElevatedButton(
									onPressed: model.signInWithGoogle,
									child: Text('Sign in with Google'),
									style: ElevatedButton.styleFrom(primary: Theme.of(context).colorScheme.surface),
								),
								ElevatedButton(
									onPressed: model.signInWithApple,
									child: Text('Sign in with Apple'),
									style: ElevatedButton.styleFrom(primary: Theme.of(context).colorScheme.onPrimary),
								),
								TextButton(
									onPressed: () {
										// Navigate to create an account
									},
									child: Text("Don't have an account? Create an Account"),
								),
							],
						),
					),
				);
			},
		);
	}
}
