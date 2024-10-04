import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Importing intl for date formatting
import 'package:firebase_auth/firebase_auth.dart'; // Firebase Authentication
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:unite/pages/cards_page.dart'; // Firestore for user data

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? userName;
  int streakCount = 0;
  List<String> achievements = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchUserData(); // Fetch user data when widget is initialized
  }

  // Function to fetch the user's name, streak count, and achievements from Firestore
  Future<void> fetchUserData() async {
    try {
      User? user = FirebaseAuth.instance.currentUser; // Get current user
      if (user != null) {
        // Fetch user document from Firestore (assuming you have a 'users' collection)
        DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();

        setState(() {
          userName =
              userDoc['username']; // Fetch 'username' field from Firestore
          streakCount = userDoc['streakCount'] ??
              0; // Fetch 'streakCount' field from Firestore
          achievements = List<String>.from(userDoc['achievements'] ??
              []); // Fetch 'achievements' field from Firestore
          isLoading = false;
        });
      } else {
        setState(() {
          userName = 'User'; // Default name if user is not logged in
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        userName = 'User'; // Fallback name in case of an error
        streakCount = 0; // Fallback streak count
        achievements = []; // Fallback achievements
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Get today's date
    DateTime today = DateTime.now();
    // Create a list of the next 6 days including today
    List<DateTime> streakDays =
        List.generate(7, (index) => today.add(Duration(days: index)));

    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          // Check screen width
          bool isSmallScreen = constraints.maxWidth < 765;

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: isLoading
                  ? Center(
                      child:
                          CircularProgressIndicator()) // Show loading indicator
                  : isSmallScreen
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Welcome message
                            Text(
                              "Welcome, $userName", // Display fetched username
                              style: TextStyle(
                                  fontSize: 32, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 16), // Spacing

                            // Streak container with full width on small screens
                            _buildStreakContainer(
                                streakDays, constraints.maxWidth),

                            SizedBox(height: 16), // Spacing

                            // Achievements container with full width on small screens
                            _buildAchievementsContainer(constraints.maxWidth),

                            SizedBox(height: 16), // Spacing

                            // Jump Back In section with full width on small screens
                            _buildJumpBackInSection(constraints.maxWidth),
                          ],
                        )
                      : Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Left side container for streak and achievements
                            Container(
                              width: 420,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Welcome message
                                  Text(
                                    "Welcome, $userName", // Display fetched username
                                    style: TextStyle(
                                        fontSize: 32,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(height: 16), // Spacing

                                  // Streak container
                                  _buildStreakContainer(streakDays, 365),

                                  SizedBox(height: 16), // Spacing

                                  // Achievements container
                                  _buildAchievementsContainer(365),
                                ],
                              ),
                            ),

                            // Right side for Jump Back In section
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _buildJumpBackInSection(double.infinity),
                                ],
                              ),
                            ),
                          ],
                        ),
            ),
          );
        },
      ),
    );
  }

  // Widget to build Streak container
  Widget _buildStreakContainer(
      List<DateTime> streakDays, double containerWidth) {
    return Container(
      padding: const EdgeInsets.all(16),
      width: containerWidth, // Dynamic width for streak container
      decoration: BoxDecoration(
        color: Colors.grey[300], // Background color
        borderRadius: BorderRadius.circular(8), // Rounded corners
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Streak",
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8), // Spacing
          Text(
            "$streakCount", // Display fetched streak count
            style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16), // Spacing
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: streakDays.map((day) {
              bool isToday = day.isToday(); // Check if it's today
              return Container(
                width: 45, // Adjusted width to fit more items
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 6),
                decoration: BoxDecoration(
                  color: isToday ? Colors.blueAccent : Colors.transparent,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Column(
                  children: [
                    Text(
                      DateFormat.E().format(day).toUpperCase(),
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: isToday ? Colors.white : Colors.black,
                      ),
                    ),
                    SizedBox(height: 4), // Spacing
                    Text(
                      day.day.toString(),
                      style: TextStyle(
                        fontSize: 14,
                        color: isToday ? Colors.white : Colors.black,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  // Widget to build Achievements container
  Widget _buildAchievementsContainer(double containerWidth) {
    return Container(
      padding: const EdgeInsets.all(16),
      width: containerWidth, // Dynamic width for achievements container
      decoration: BoxDecoration(
        color: Colors.grey[300], // Background color
        borderRadius: BorderRadius.circular(8), // Rounded corners
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Achievements",
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8), // Spacing
          // Display fetched achievements
          Wrap(
            spacing: 12.0, // Adjusted space between badges
            runSpacing: 12.0, // Adjusted space between rows of badges
            children: achievements.map((achievement) {
              return BadgeWidget(title: achievement);
            }).toList(),
          ),
        ],
      ),
    );
  }

// Widget to build Jump Back In section
  Widget _buildJumpBackInSection(double containerWidth) {
    return Container(
      width: containerWidth, // Dynamic width for Jump Back In container
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 16), // Additional spacing
          Text(
            "Jump back in",
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16), // Placeholder for image
          _buildJumpBackInContent("Train", () {
            // Define your action for "Thinking in Code" here
            print("Train pressed");
          }),
          SizedBox(height: 16),
          // Update here to include specific names and onPressed functions
          _buildJumpBackInContent("Thinking in Code", () {
            // Define your action for "Thinking in Code" here
            print("Thinking in Code pressed");
          }),
          SizedBox(height: 16), // Placeholder for image
          _buildJumpBackInContent("Fundamentals", () {
            // Define your action for "Fundamentals" here
            print("Fundamentals pressed");
          }),
          SizedBox(height: 16), // Placeholder for image
          _buildJumpBackInContent("Python", () {
            // Define your action for "Python" here
            print("Python pressed");
          }),
        ],
      ),
    );
  }

// Widget for content below Jump Back In section with name and onPressed
  Widget _buildJumpBackInContent(String name, VoidCallback onPressed) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 150, // space for adding image
          ),
          Text(
            name, // Use the passed name here
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16), // Spacing
          InkWell(
            onTap: onPressed, // Trigger onPressed when tapped
            child: Container(
              height: 48, // Adjusted height
              width: double.infinity, // Full width
              decoration: BoxDecoration(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Text(
                  "Continue",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Extension method to check if the day is today
extension DateTimeExtension on DateTime {
  bool isToday() {
    final now = DateTime.now();
    return day == now.day && month == now.month && year == now.year;
  }
}

// Badge widget for achievements
class BadgeWidget extends StatelessWidget {
  final String title;
  const BadgeWidget({required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 100,
      decoration: BoxDecoration(
        color: Colors.blueAccent,
        borderRadius: BorderRadius.circular(50),
      ),
      child: Center(
        child: Text(
          title, // Display achievement title
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
