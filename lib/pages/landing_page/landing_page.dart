import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Import Firestore package
import 'package:unite/pages/home_page.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  int streakCount = 0; // Variable to hold streak count

  @override
  void initState() {
    super.initState();
    fetchStreakCount(); // Fetch streak count when the widget is initialized
  }

  // Method to fetch streak count from Firestore
  Future<void> fetchStreakCount() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        DocumentSnapshot userData = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get(); // Fetch user data
        setState(() {
          streakCount = userData['streakCount'] ?? 0; // Update streak count
        });
      } catch (e) {
        // Handle any errors here (e.g., log them)
        print('Error fetching streak count: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Number of tabs
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize:
              Size.fromHeight(53), // Set a custom height for the AppBar
          child: Material(
            elevation: 4, // Set elevation for the AppBar
            child: LayoutBuilder(
              builder: (context, constraints) {
                return Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        // Show "Unite" only if screen width is greater than 765px
                        if (constraints.maxWidth > 765) ...[
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 36,
                              top: 8.0,
                              bottom: 8.0,
                            ),
                            child: Text(
                              "Unite",
                              style: TextStyle(
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                        // TabBar
                        Container(
                          padding: const EdgeInsets.only(left: 16),
                          width: 280,
                          child: TabBar(
                            indicator: BoxDecoration(
                              color: Colors.transparent,
                              border: Border(
                                bottom: BorderSide(
                                  color: Colors.black,
                                  width: 4.0,
                                ),
                              ),
                            ),
                            labelColor: Colors.black,
                            unselectedLabelColor: Colors.black54,
                            tabs: [
                              Tab(
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(Icons.home),
                                    SizedBox(width: 4),
                                    Text(
                                      'Home',
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ],
                                ),
                              ),
                              Tab(
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(Icons.videogame_asset),
                                    SizedBox(width: 4),
                                    Text(
                                      'Compete',
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Spacer(),
                        // Search bar
                        if (constraints.maxWidth > 765)
                          Padding(
                            padding: const EdgeInsets.only(right: 180),
                            child: Container(
                              width: constraints.maxWidth * 0.3,
                              child: TextField(
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.grey[300],
                                  prefixIcon: Icon(Icons.search),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide.none,
                                  ),
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 8, horizontal: 10),
                                ),
                              ),
                            ),
                          ),
                        // Streak Count with Thunder Icon
                        Row(
                          children: [
                            Icon(Icons.flash_on,
                                color: Colors.yellow, size: 24),
                            SizedBox(width: 4),
                            Text(
                              '$streakCount', // Display the fetched streak count
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(width: 36),
                            // Circular Avatar for profile icon
                            PopupMenuButton<String>(
                              icon: CircleAvatar(
                                radius: 16,
                                backgroundColor: Colors.grey[300],
                                child: Icon(Icons.person, color: Colors.black),
                              ),
                              offset: Offset(0, 40),
                              onSelected: (value) async {
                                if (value == 'logout') {
                                  await FirebaseAuth.instance.signOut();
                                }
                              },
                              itemBuilder: (BuildContext context) {
                                return [
                                  PopupMenuItem<String>(
                                    value: 'my_account',
                                    child: Center(child: Text('My Account')),
                                  ),
                                  PopupMenuItem<String>(
                                    value: 'progress',
                                    child: Center(child: Text('Progress')),
                                  ),
                                  PopupMenuDivider(),
                                  PopupMenuItem<String>(
                                    value: 'logout',
                                    child: Center(child: Text('Logout')),
                                  ),
                                ];
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
          ),
        ),
        body: TabBarView(
          children: [
            HomePage(), // Replace with actual page content
            Center(
                child: Text(
                    "Compete Content")), // Replace with actual page content
          ],
        ),
      ),
    );
  }
}
