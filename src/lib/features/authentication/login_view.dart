// lib/features/authentication/login_view.dart

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'login_viewmodel.dart';
import 'authentication_repository.dart';

class LoginView extends StatelessWidget {
  final AuthenticationRepository _repository;

  LoginView({Key? key, required AuthenticationRepository repository})
      : _repository = repository,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LoginViewModel>.reactive(
      viewModelBuilder: () =>
          LoginViewModel(authenticationRepository: _repository),
      builder: (context, model, child) {
        return Scaffold(
          body: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                      'assets/images/aorteq_logo.png'), // Placeholder for logo
                  const SizedBox(height: 32.0),
                  const Text(
                    'Login with your AorteQ account',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16.0),
                  TextField(
                    onChanged: model.updateEmail,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      errorText: model.errorMessage,
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 16.0),
                  TextField(
                    onChanged: model.updatePassword,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      errorText: model.errorMessage,
                      suffixIcon: IconButton(
                        icon: Icon(
                          model.showPassword
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: model.togglePasswordVisibility,
                      ),
                    ),
                    obscureText: !model.showPassword,
                  ),
                  const SizedBox(height: 16.0),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: model.forgotPassword,
                      child: const Text(
                        'Forgot Password?',
                        style:
                            TextStyle(color: Color(0xFF9B59B6)), // Light purple
                      ),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: model.login,
                    child: const Text('Login'),
                    style: ElevatedButton.styleFrom(
                        primary: const Color(0xFF6366F1)), // Primary purple
                  ),
                  const SizedBox(height: 32.0),
                  const Divider(),
                  const Text('Or'),
                  const SizedBox(height: 16.0),
                  ElevatedButton.icon(
                    onPressed: model.signInWithGoogle,
                    icon: Image.asset('assets/images/google_logo.png',
                        height: 24),
                    label: const Text('Sign in with Google'),
                    style: ElevatedButton.styleFrom(primary: Colors.white),
                  ),
                  const SizedBox(height: 16.0),
                  ElevatedButton.icon(
                    onPressed: model.signInWithApple,
                    icon:
                        Image.asset('assets/images/apple_logo.png', height: 24),
                    label: const Text('Sign in with Apple'),
                    style: ElevatedButton.styleFrom(primary: Colors.black),
                  ),
                  const SizedBox(height: 16.0),
                  const Text("Don't have an account? Create an Account"),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
