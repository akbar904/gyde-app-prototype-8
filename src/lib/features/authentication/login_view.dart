import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'login_viewmodel.dart';

class LoginView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LoginViewModel>.reactive(
      viewModelBuilder: () => LoginViewModel(),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          title: Text('AorteQ'),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Login with your AorteQ account',
                  style: Theme.of(context).textTheme.headline6,
                ),
                SizedBox(height: 16.0),
                TextField(
                  controller: model.emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    errorText: model.emailError,
                  ),
                  onChanged: (value) => model.setEmail(value),
                ),
                SizedBox(height: 8.0),
                TextField(
                  controller: model.passwordController,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    errorText: model.passwordError,
                    suffixIcon: IconButton(
                      icon: Icon(model.isPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off),
                      onPressed: model.togglePasswordVisibility,
                    ),
                  ),
                  obscureText: !model.isPasswordVisible,
                  onChanged: (value) => model.setPassword(value),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: model.forgotPassword,
                    child: Text(
                      'Forgot Password?',
                      style: TextStyle(color: Colors.purple[200]),
                    ),
                  ),
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: model.isBusy ? null : () => model.login(),
                  child: model.isBusy
                      ? CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white),
                        )
                      : Text('Login'),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.purple,
                  ),
                ),
                SizedBox(height: 8.0),
                Row(
                  children: [
                    Expanded(child: Divider()),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text('Or'),
                    ),
                    Expanded(child: Divider()),
                  ],
                ),
                SizedBox(height: 8.0),
                OutlinedButton.icon(
                  onPressed: model.loginWithGoogle,
                  icon: Icon(Icons.account_circle),
                  label: Text('Sign in with Google'),
                ),
                SizedBox(height: 8.0),
                OutlinedButton.icon(
                  onPressed: model.loginWithApple,
                  icon: Icon(Icons.account_circle),
                  label: Text('Sign in with Apple'),
                  style: OutlinedButton.styleFrom(
                    primary: Colors.black,
                    backgroundColor: Colors.black,
                    side: BorderSide(color: Colors.black),
                  ),
                ),
                SizedBox(height: 16.0),
                TextButton(
                  onPressed: model.navigateToSignUp,
                  child: Text("Don't have account? Create an Account"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
