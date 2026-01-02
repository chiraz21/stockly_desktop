import 'package:flutter/material.dart';
import '../theme.dart';
import '../services/database_service.dart';
import 'farmer_dashboard_screen.dart';

class FarmerRegisterScreen extends StatefulWidget {
  const FarmerRegisterScreen({super.key});

  @override
  State<FarmerRegisterScreen> createState() => _FarmerRegisterScreenState();
}

class _FarmerRegisterScreenState extends State<FarmerRegisterScreen> {
  final name = TextEditingController();
  final email = TextEditingController();
  final phone = TextEditingController();
  final password = TextEditingController();

  void register() async {
    try {
      await DatabaseService.instance.registerFarmer(
        fullName: name.text,
        email: email.text,
        phone: phone.text,
        password: password.text,
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const FarmerDashboardScreen(),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Register failed")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(20, 60, 20, 40),
            decoration: const BoxDecoration(
              color: primaryGreen,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Create Account",
                    style: TextStyle(color: Colors.white, fontSize: 26)),
                SizedBox(height: 5),
                Text("Join Stockly today",
                    style: TextStyle(color: Colors.white70)),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                _input("Full Name", Icons.person, name),
                _input("Email", Icons.email, email),
                _input("Phone", Icons.phone, phone),
                _input("Password", Icons.lock, password, isPassword: true),
                const SizedBox(height: 25),
                ElevatedButton(
                  onPressed: register,
                  child: const Text("Register"),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _input(String label, IconData icon, TextEditingController controller,
      {bool isPassword = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: TextField(
        controller: controller,
        obscureText: isPassword,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
    );
  }
}
