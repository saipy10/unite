import 'package:flutter/material.dart';

class LoginSignupPage extends StatefulWidget {
  const LoginSignupPage({Key? key}) : super(key: key);

  @override
  _LoginSignupPageState createState() => _LoginSignupPageState();
}

class _LoginSignupPageState extends State<LoginSignupPage> {
  bool isLogin = false; // Toggles between login and signup
  bool isPasswordVisible = false; // Toggles password visibility

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 400),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Heading
                Text(
                  isLogin ? 'Log In' : 'Create Account',
                  style: const TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 30.0),

                if (!isLogin) ...[
                  // Sign Up with Google and Facebook Buttons (only for Signup)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {
                            // Google Sign-in Logic
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 15.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                              side: const BorderSide(color: Colors.grey),
                            ),
                          ),
                          icon: Image.asset(
                            'assets/images/Google__G__logo.svg.png',
                            height: 24.0,
                          ),
                          label: const Text(
                            'Google',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10.0),
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {
                            // Facebook Sign-in Logic
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 15.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                              side: const BorderSide(color: Colors.grey),
                            ),
                          ),
                          icon: Image.asset(
                            'assets/images/2023_Facebook_icon.svg.png',
                            height: 24.0,
                          ),
                          label: const Text(
                            'Facebook',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20.0),

                  // OR Divider
                  Row(
                    children: const [
                      Expanded(child: Divider()),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text("OR"),
                      ),
                      Expanded(child: Divider()),
                    ],
                  ),
                  const SizedBox(height: 20.0),
                ],

                // Full Name TextField (only for Signup)
                if (!isLogin)
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: "First Name",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ),
                if (!isLogin) const SizedBox(height: 10.0),
                if (!isLogin)
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: "Last Name",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ),
                if (!isLogin) const SizedBox(height: 10.0),
                if (!isLogin)
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: "Username",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ),
                if (!isLogin) const SizedBox(height: 10.0),
                if (!isLogin)
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: "Personal Email",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ),
                if (!isLogin) const SizedBox(height: 10.0),
                if (!isLogin)
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: "Parent Email",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ),
                if (!isLogin) const SizedBox(height: 10.0),
                if (!isLogin)
                  TextFormField(
                    obscureText:
                        !isPasswordVisible, // Toggle password visibility
                    decoration: InputDecoration(
                      labelText: "Password",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          isPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            isPasswordVisible = !isPasswordVisible;
                          });
                        },
                      ),
                    ),
                  ),

                // const SizedBox(height: 10.0),
                const SizedBox(height: 20.0),

                // Create Account / Login Button
                ElevatedButton(
                  onPressed: () {
                    // Add login or signup logic here
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.tealAccent.shade400,
                    padding: const EdgeInsets.symmetric(vertical: 15.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      isLogin ? 'Log In' : 'Create Account',
                      style:
                          const TextStyle(color: Colors.white, fontSize: 16.0),
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),

                // Toggle between Login and Signup
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      isLogin
                          ? "Don't have an account?"
                          : "Already have an account?",
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          isLogin = !isLogin;
                        });
                      },
                      child: Text(
                        isLogin ? 'Sign up' : 'Log in',
                        style: TextStyle(color: Colors.tealAccent.shade400),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
