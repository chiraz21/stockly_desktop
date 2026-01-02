import 'package:flutter/material.dart';
import '../theme.dart';
import '../services/database_service.dart';
import 'farmer_dashboard_screen.dart';
import 'farmer_register_screen.dart';

class FarmerLoginScreen extends StatefulWidget {
  const FarmerLoginScreen({super.key});

  @override
  State<FarmerLoginScreen> createState() => _FarmerLoginScreenState();
}

class _FarmerLoginScreenState extends State<FarmerLoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void login() async {
    try {
      await DatabaseService.instance.loginFarmer(
        emailController.text,
        passwordController.text,
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (_) => const FarmerDashboardScreen()),
      );
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Login failed")));
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
                Text("Welcome Back",
                    style: TextStyle(color: Colors.white, fontSize: 26)),
                SizedBox(height: 5),
                Text("Login to your account",
                    style: TextStyle(color: Colors.white70)),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                _input("Email", Icons.email, emailController),
                _input("Password", Icons.lock, passwordController,
                    isPassword: true),
                const SizedBox(height: 25),
                ElevatedButton(onPressed: login, child: const Text("Login")),
                const SizedBox(height: 20),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const FarmerRegisterScreen()),
                    );
                  },
                  child: const Text("Don't have an account? Register"),
                )
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
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
        ),
      ),
    );
  }
}
