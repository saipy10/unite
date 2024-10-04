import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginSignupPage extends StatefulWidget {
  @override
  _LoginSignupPageState createState() => _LoginSignupPageState();
}

class _LoginSignupPageState extends State<LoginSignupPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isSignup = true; // Toggle between login and signup

  void _submit() async {
    try {
      if (isSignup) {
        await _auth.createUserWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text,
        );
      } else {
        await _auth.signInWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text,
        );
      }
    } catch (e) {
      print(e); // Handle errors (e.g., show a Snackbar)
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isSignup ? 'Sign Up' : 'Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submit,
              child: Text(isSignup ? 'Sign Up' : 'Login'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  isSignup = !isSignup; // Toggle between login and signup
                });
              },
              child: Text(isSignup
                  ? 'Already have an account? Login'
                  : 'Don\'t have an account? Sign Up'),
            ),
          ],
        ),
      ),
    );
  }
}
