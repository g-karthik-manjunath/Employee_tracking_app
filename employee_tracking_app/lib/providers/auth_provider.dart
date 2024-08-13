import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthProvider with ChangeNotifier {
  String _token = '';
  Map<String, dynamic> _userData = {};

  String get token => _token;
  Map<String, dynamic> get userData => _userData;

  // Future<void> login(String email, String password) async {
  //   final url = 'http://192.168.0.122:5000/api/login'; // Your backend API URL

  //   final response = await http.post(
  //     Uri.parse(url),
  //     headers: {'Content-Type': 'application/json'},
  //     body: json.encode({
  //       'email': email,
  //       'password': password,
  //     }),
  //   );

  //   final responseData = json.decode(response.body);

  //   if (response.statusCode == 200) {
  //     _token = responseData['token'];
  //     _userData = responseData['user'];
  //     notifyListeners();
  //   } else {
  //     final errorMessage = responseData['message'] ?? 'Failed to login';
  //     throw Exception(errorMessage);
  //   }
  // }

  Future<void> fetchUserProfile() async {
    final url = 'http://192.168.0.122:5000/api/user-details'; // Updated backend API URL

    final response = await http.get(
      Uri.parse(url),
      headers: {'Authorization': 'Bearer $_token'},
    );

    final responseData = json.decode(response.body);

    if (response.statusCode == 200) {
      _userData = responseData;
      notifyListeners();
    } else {
      final errorMessage = responseData['message'] ?? 'Failed to fetch user profile';
      throw Exception(errorMessage);
    }
  }

  Future<void> updateProfile(String name, String phone, String? password) async {
    final url = 'http://192.168.0.122:5000/api/user'; // Updated backend API URL

    final response = await http.put(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $_token',
      },
      body: json.encode({
        'name': name,
        'phone': phone,
        'password': password ?? '', // Send an empty string if no password is provided
      }),
    );

    final responseData = json.decode(response.body);

    if (response.statusCode == 200) {
      _userData = responseData; // Update with the new user data if returned
      notifyListeners();
    } else {
      final errorMessage = responseData['message'] ?? 'Failed to update profile';
      throw Exception(errorMessage);
    }
  }
}
