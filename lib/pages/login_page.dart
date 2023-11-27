import 'package:flutter/material.dart';
import 'package:adoptme/pages/home.dart'; // Import the home page
import 'package:adoptme/utils/styles.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Stack(
        children: [
          SvgPicture.asset(
            'assets/svg/login_page.svg', // Replace with your actual asset path
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _buildRoundedTextField(
                    labelText: 'Username',
                    controller: _usernameController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a valid username';
                      }
                      if (!RegExp(r'^[a-zA-Z0-9_.+-]+@gmail\.com$').hasMatch(value)) {
                        return 'Please enter a valid Gmail address';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  _buildRoundedTextField(
                    labelText: 'Password',
                    controller: _passwordController,
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a valid password';
                      }
                      if (value.length < 8) {
                        return 'Password must be at least 8 characters';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 24),
                  TweenAnimationBuilder<double>(
                    tween: Tween(begin: 0, end: 1),
                    duration: const Duration(milliseconds: 700),
                    builder: (context, value, _) {
                      return Opacity(
                        opacity: value,
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState?.validate() ?? false) {
                              // If the form is valid, navigate to the home page
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (_) => const Home()),
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            primary: Styles.blackColor,
                            shape: const StadiumBorder(),
                            elevation: 0,
                          ),
                          child: Text(
                            'Login',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                              color: Styles.highlightColor,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget _buildRoundedTextField({
  required String labelText,
  required TextEditingController controller,
  bool obscureText = false,
  required String? Function(String?) validator,
}) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.white.withOpacity(0.8), // Adjust the opacity as needed
      borderRadius: BorderRadius.circular(20), // Adjust the radius as needed
    ),
    padding: const EdgeInsets.symmetric(horizontal: 16),
    child: TextFormField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: labelText,
        border: InputBorder.none,
      ),
      validator: validator,
    ),
  );
}
