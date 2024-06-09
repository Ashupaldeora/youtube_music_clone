import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(
                  0xFF1B1E44), // Replace with the start color of your gradient
              Color(0xFF2D3447), // Replace with the end color of your gradient
            ],
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          // Rest of your widgets go here
        ),
      ),
    );
  }
}
