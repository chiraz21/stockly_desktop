import 'package:flutter/material.dart';

class FarmerDashboardScreen extends StatelessWidget {
  const FarmerDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Farmer Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              Navigator.pop(context); // يرجع لصفحة login
            },
          ),
        ],
      ),
      body: const Center(
        child: Text(
          'Welcome Farmer 👨‍🌾',
          style: TextStyle(fontSize: 26),
        ),
      ),
    );
  }
}
