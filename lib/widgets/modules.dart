import 'package:flutter/material.dart';

class ResponsiveCardPage extends StatelessWidget {
  final List<String> cardNames = List.generate(10, (index) => 'Card ${index + 1}');

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // If width is greater than 765, display in row, else in column
        if (constraints.maxWidth > 765) {
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: cardNames.map((name) => buildCard(name)).toList(),
            ),
          );
        } else {
          return Column(
            children: cardNames.map((name) => buildCard(name)).toList(),
          );
        }
      },
    );
  }

  // Card Widget
  Widget buildCard(String name) {
    return GestureDetector(
      onTap: () {
        print('$name clicked');
      },
      child: Card(
        elevation: 4,
        margin: EdgeInsets.all(10),
        child: Container(
          padding: EdgeInsets.all(20),
          child: Text(
            name,
            style: TextStyle(fontSize: 18),
          ),
        ),
      ),
    );
  }
}
