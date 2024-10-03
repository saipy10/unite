import 'package:flutter/material.dart';

class ProfileMenu extends StatelessWidget {
  const ProfileMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      icon: CircleAvatar(
        radius: 16,
        backgroundColor: Colors.grey[300],
        child: Icon(Icons.person, color: Colors.black),
      ),
      offset: Offset(0, 40),
      onSelected: (value) {
        // Handle the selected option
      },
      itemBuilder: (BuildContext context) {
        return [
          PopupMenuItem<String>(
            value: 'my_account',
            padding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
            child: Center(child: Text('My Account')),
          ),
          PopupMenuItem<String>(
            value: 'progress',
            padding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
            child: Center(child: Text('Progress')),
          ),
          PopupMenuDivider(),
          PopupMenuItem<String>(
            value: 'logout',
            padding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
            child: Center(child: Text('Logout')),
          ),
        ];
      },
    );
  }
}
