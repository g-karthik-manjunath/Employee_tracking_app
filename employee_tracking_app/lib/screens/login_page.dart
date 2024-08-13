import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
final TextEditingController emailController = TextEditingController();
final TextEditingController passwordController = TextEditingController();

void _login() async {
  String email = emailController.text;
  String password = passwordController.text;

  // Make a POST request to the back-end server
  var response = await http.post(
    Uri.parse('http://192.168.0.122:5000/api/login'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'email': email,
      'password': password,
    }),
  );

  print(response.body);
  final responseData = json.decode(response.body);

  if (response.statusCode == 200) {
    String token = responseData['token'];
    print("Token: $token");

    // Save the token to SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);

    // Navigate to MyTaskPage
    Navigator.pushReplacementNamed(context, '/my_tasks');
  } else {
    // If the server did not return a 200 OK response, show an error message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Login failed')),
    );
  }
}


  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: screenHeight * 0.15),
                Image.asset(
                  'assets/images/Mask_group.png', // Use the local image asset
                  height: screenHeight * 0.19,
                  width: screenWidth * 0.7,
                ),
                SizedBox(height: screenHeight * 0.02),
                Text(
                  'Log in to continue',
                  style: GoogleFonts.poppins(
                    color: Color(0xFF9098B1),
                    fontSize: screenWidth * 0.028,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    hintText: 'Your Email', // Use hintText instead of labelText
                    hintStyle: TextStyle(color: Color(0xFF9098B1),fontSize: screenWidth * 0.035), // Change hint text color to blue
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(15)),
                                borderSide: BorderSide(
                                  color: Color(0xFF9098B1),
                                  width: 1.0, // Border color when focused
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(15)),
                                borderSide: BorderSide(
                                  color: Color(0xFF9098B1).withOpacity(0.5),
                                  width: 1.0, // Border color when enabled
                                ),
                              ),
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Image.asset(
                        'assets/images/email.png',
                        height: 20,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.03),
                TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'Password', // Use hintText instead of labelText
                    hintStyle: TextStyle(color: Color(0xFF9098B1),fontSize: screenWidth * 0.035), // Change hint text color to blue
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(15)),
                                borderSide: BorderSide(
                                  color: Color(0xFF9098B1),
                                  width: 1.0, // Border color when focused
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(15)),
                                borderSide: BorderSide(
                                  color: Color(0xFF9098B1).withOpacity(0.5),
                                  width: 1.0, // Border color when enabled
                                ),
                              ),
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Image.asset(
                        'assets/images/lock.png',
                        height: 15,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.03),
                ElevatedButton(
                  onPressed: _login,
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 53),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    backgroundColor: Color(0xFF09648C),
                  ),
                  child: Text(
                    'Log In',
                    style: TextStyle(
                      fontSize: screenWidth * 0.05,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.01),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      // Handle forgot password
                    },
                    child: Text(
                      'Forgot Password?',
                      style: TextStyle(
                        color: Color(0xFF09648C),
                        fontSize: screenWidth * 0.04,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
