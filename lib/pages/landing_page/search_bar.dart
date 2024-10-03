import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {
  final BoxConstraints constraints;

  const SearchBar({Key? key, required this.constraints}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
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
            contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
          ),
        ),
      ),
    );
  }
}
