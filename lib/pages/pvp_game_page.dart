import 'package:flutter/material.dart';

class PvpGamePage extends StatefulWidget {
  const PvpGamePage({super.key});

  @override
  State<PvpGamePage> createState() => _PvpGamePageState();
}

class _PvpGamePageState extends State<PvpGamePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Center(child: Text("PVP Game Page")),
      ),
    );
  }
}
