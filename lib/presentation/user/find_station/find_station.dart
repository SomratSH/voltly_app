import 'package:flutter/material.dart';

class FindStation extends StatelessWidget {
  const FindStation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF121C24),
        title: const Text(
          'Find Stations',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context); // ✅ go back when pressed
          },
          icon: const Icon(Icons.arrow_back, color: Colors.white),
        ),
      ),
      body: SizedBox.expand(
        child: Image.asset(
          "assets/image/find_station.png",
          fit: BoxFit.cover, // ✅ makes image fill the screen
        ),
      ),
    );
  }
}
