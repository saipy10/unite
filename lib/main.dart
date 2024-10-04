import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:unite/pages/landing_page/landing_page.dart';
import 'package:unite/pages/login_signup_page.dart'; // Import your login/signup page

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
        apiKey: "AIzaSyAooRFwlhB0eWhZoRpnUyPpItzHCVqXMKU",
        appId: "1:652203000256:web:dc4ab7dca3699034a3c825",
        messagingSenderId: "652203000256",
        projectId: "unite-b2c55"),
  ); // Initialize Firebase
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Unite',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: LandingPage(),
    );
  }
}

class AuthWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          // If user is logged in, show the landing page
          if (snapshot.hasData) {
            return LandingPage(); // Replace with your landing page
          } else {
            return LoginSignupPage(); // Show login/signup page
          }
        }
        return Center(
            child: CircularProgressIndicator()); // Show loading indicator
      },
    );
  }
}
