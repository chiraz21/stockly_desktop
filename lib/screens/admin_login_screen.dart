import 'package:flutter/material.dart';

class AdminLoginScreen extends StatelessWidget {
  final String role;
  const AdminLoginScreen({super.key, required this.role});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("$role Login")),
      body: const Center(child: Text("Admin Login Coming Soon")),
    );
  }
}
