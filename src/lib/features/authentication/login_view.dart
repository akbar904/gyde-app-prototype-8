
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:my_app/features/authentication/auth_repository.dart';

class LoginView extends StatelessWidget {
	final AuthRepository authRepository;

	LoginView({required this.authRepository});

	@override
	Widget build(BuildContext context) {
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
								errorText: 'Please enter a valid email',
							),
							keyboardType: TextInputType.emailAddress,
						),
						TextField(
							decoration: InputDecoration(
								labelText: 'Password',
								suffixIcon: IconButton(
									icon: Icon(Icons.visibility),
									onPressed: () {
										// Toggle password visibility
									},
								),
							),
							obscureText: true,
						),
						Align(
							alignment: Alignment.centerRight,
							child: Text(
								'Forgot Password?',
								style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Theme.of(context).colorScheme.primary),
							),
						),
						ElevatedButton(
							onPressed: () {
								// Handle login
							},
							child: Text('Login'),
							style: ElevatedButton.styleFrom(primary: Theme.of(context).colorScheme.primary),
						),
						Divider(),
						Text('Or'),
						ElevatedButton(
							onPressed: () {
								// Handle Google sign-in
							},
							child: Text('Sign in with Google'),
							style: ElevatedButton.styleFrom(primary: Theme.of(context).colorScheme.surface),
						),
						ElevatedButton(
							onPressed: () {
								// Handle Apple sign-in
							},
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
	}
}
