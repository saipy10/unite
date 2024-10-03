import 'package:flutter/material.dart';
import 'package:unite/pages/home_page.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
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
                      mainAxisAlignment: MainAxisAlignment
                          .start, // Align everything to the start
                      children: [
                        // Show "Unite" only if screen width is greater than 765px
                        if (constraints.maxWidth > 765) ...[
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 36,
                              top: 8.0,
                              bottom: 8.0,
                            ), // Adjusted padding
                            child: Text(
                              "Unite", // The text to display
                              style: TextStyle(
                                fontSize: 26, // Increased font size
                                fontWeight:
                                    FontWeight.bold, // Make the text bold
                              ),
                            ),
                          ),
                        ],
                        // Dynamically show the TabBar based on width
                        Container(
                          padding: const EdgeInsets.only(
                              left:
                                  16), // Add padding to move TabBar closer to "Unite"
                          width: 280, // Set a fixed width for the TabBar
                          child: TabBar(
                            indicator: BoxDecoration(
                              color: Colors
                                  .transparent, // Background color of the indicator
                              border: Border(
                                bottom: BorderSide(
                                  color: Colors
                                      .black, // Color of the tab highlighter line
                                  width:
                                      4.0, // Width of the tab highlighter line
                                ),
                              ),
                            ),
                            labelColor:
                                Colors.black, // Text color for selected tab
                            unselectedLabelColor: Colors
                                .black54, // Text color for unselected tabs
                            tabs: [
                              Tab(
                                child: Row(
                                  mainAxisSize: MainAxisSize
                                      .min, // Minimize the width of the row
                                  children: [
                                    Icon(Icons.home), // Icon for Home tab
                                    SizedBox(
                                        width:
                                            4), // Spacing between icon and text
                                    Text(
                                      'Home', // Tab text
                                      style: TextStyle(
                                          fontSize: 16), // Increase text size
                                    ),
                                  ],
                                ),
                              ),
                              Tab(
                                child: Row(
                                  mainAxisSize: MainAxisSize
                                      .min, // Minimize the width of the row
                                  children: [
                                    Icon(Icons
                                        .videogame_asset), // Icon for Compete tab
                                    SizedBox(
                                        width:
                                            4), // Spacing between icon and text
                                    Text(
                                      'Compete', // Tab text
                                      style: TextStyle(
                                          fontSize: 16), // Increase text size
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Spacer(), // Push the following widgets to the right
                        // Dynamically show search bar if screen width is more than 765px
                        if (constraints.maxWidth > 765)
                          Padding(
                            padding: const EdgeInsets.only(
                                right:
                                    180), // Increase padding to shift search bar more left
                            child: Container(
                              width: constraints.maxWidth *
                                  0.3, // Responsive width for the search bar
                              child: TextField(
                                decoration: InputDecoration(
                                  filled: true, // Fill the background
                                  fillColor:
                                      Colors.grey[300], // Gray background color
                                  prefixIcon: Icon(Icons.search), // Search icon
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide:
                                        BorderSide.none, // Remove the border
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
                                color: Colors.yellow,
                                size: 24), // Increased icon size
                            SizedBox(
                                width: 4), // Spacing between icon and count
                            Text(
                              '5', // Streak count
                              style: TextStyle(
                                fontSize: 20, // Increased font size for count
                                fontWeight:
                                    FontWeight.w600, // Increased font weight
                              ),
                            ),
                            SizedBox(
                                width:
                                    36), // Increased spacing between streak and profile icon
                            // Circular Avatar for profile icon
                            PopupMenuButton<String>(
                              icon: CircleAvatar(
                                radius: 16, // Size of the avatar
                                backgroundColor:
                                    Colors.grey[300], // Avatar background
                                child: Icon(Icons.person,
                                    color: Colors.black), // Avatar icon
                              ),
                              offset: Offset(
                                  0, 40), // Adjust position of popup menu
                              onSelected: (value) {
                                // Handle the selected option
                                if (value == 'my_account') {
                                  // Handle My Account
                                } else if (value == 'progress') {
                                  // Handle Progress
                                } else if (value == 'logout') {
                                  // Handle Logout
                                }
                              },
                              itemBuilder: (BuildContext context) {
                                return [
                                  PopupMenuItem<String>(
                                    value: 'my_account',
                                    padding: EdgeInsets.symmetric(
                                        vertical: 0, horizontal: 0),
                                    child: Center(child: Text('My Account')),
                                  ),
                                  PopupMenuItem<String>(
                                    value: 'progress',
                                    padding: EdgeInsets.symmetric(
                                        vertical: 0, horizontal: 0),
                                    child: Center(child: Text('Progress')),
                                  ),
                                  PopupMenuDivider(), // Divider for separation
                                  PopupMenuItem<String>(
                                    value: 'logout',
                                    padding: EdgeInsets.symmetric(
                                        vertical: 0, horizontal: 0),
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
