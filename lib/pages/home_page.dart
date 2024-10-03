import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Importing intl for date formatting

class HomePage extends StatelessWidget {
  const HomePage({super.key});

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
              child: isSmallScreen
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Welcome message
                        Text(
                          "Welcome, User",
                          style: TextStyle(
                              fontSize: 32, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 16), // Spacing

                        // Streak container with full width on small screens
                        _buildStreakContainer(streakDays, constraints.maxWidth),

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
                                "Welcome, User",
                                style: TextStyle(
                                    fontSize: 32, fontWeight: FontWeight.bold),
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
            "5", // Example streak count
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
          // Example badges
          Wrap(
            spacing: 12.0, // Adjusted space between badges
            runSpacing: 12.0, // Adjusted space between rows of badges
            children: List.generate(5, (index) => BadgeWidget(index: index)),
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
          _buildJumpBackInContent(), // Encapsulated content and continue button
          SizedBox(height: 16), // Placeholder for image
          _buildJumpBackInContent(), // Encapsulated content and continue button
          SizedBox(height: 16), // Placeholder for image
          _buildJumpBackInContent(), // Encapsulated content and continue button
        ],
      ),
    );
  }

  // Widget for content below Jump Back In section with container and styled button
  Widget _buildJumpBackInContent() {
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
            "CS & PROGRAMMING - LEVEL 1",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16), // Spacing above the button
          SizedBox(
            width: double.infinity, // Button takes full width
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8), // Border radius
                ),
              ),
              child: Text(
                "Continue path",
                style: TextStyle(fontSize: 20),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Badge widget for achievements
class BadgeWidget extends StatelessWidget {
  final int index;
  const BadgeWidget({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.blue, // Background color for badges
        borderRadius: BorderRadius.circular(8), // Rounded corners
      ),
      child: Text(
        'Badge ${index + 1}', // Badge text
        style: TextStyle(color: Colors.white), // Text color
      ),
    );
  }
}

// Extension method to check if a date is today
extension DateTimeExtension on DateTime {
  bool isToday() {
    final now = DateTime.now();
    return this.year == now.year &&
        this.month == now.month &&
        this.day == now.day;
  }
}
