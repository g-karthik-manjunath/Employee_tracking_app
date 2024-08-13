import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:convert';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool isEditing = false;
  XFile? _profileImage;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _fetchUserDetails();
  }

  Future<void> _fetchUserDetails() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? ''; // Ensure key matches for token

    if (token.isEmpty) {
      print('No token found');
      return;
    }

    final response = await http.get(
      Uri.parse('http://192.168.0.122:5000/api/user-details'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      nameController.text = data['name'] ?? '';
      phoneController.text = data['phone'] ?? '';
      setState(() {});
    } else {
      print('Failed to fetch user details: ${response.statusCode}');
    }
  }

  Future<void> _saveProfileData() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? ''; // Ensure key matches for token

    try {
      final response = await http.put(
        Uri.parse('http://192.168.0.122:5000/api/profile'), // Ensure this endpoint matches the one in your routes
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'name': nameController.text,
          'phone': phoneController.text,
          'password': passwordController.text.isNotEmpty
              ? passwordController.text
              : null,
        }),
      );

      if (response.statusCode == 200) {
        // Optionally update shared preferences with new data if needed
        await prefs.setString('name', nameController.text);
        await prefs.setString('phone', phoneController.text);
        // Note: Do not store password in shared preferences for security reasons
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Profile updated successfully')));
      } else {
        final errorResponse = jsonDecode(response.body);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
                'Error: ${errorResponse['message'] ?? 'Updating profile failed'}')));
      }
    } catch (e) {
      print('Error: $e');
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Error updating profile')));
    }
  }

  Future<void> _uploadImage() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? '';

    if (_profileImage == null) return;

    try {
      final request = http.MultipartRequest(
        'POST',
        Uri.parse('http://192.168.0.122:5000/api/upload-profile-image'), // Ensure this endpoint matches your server setup
      )
        ..headers['Authorization'] = 'Bearer $token'
        ..files.add(await http.MultipartFile.fromPath(
          'profileImage',
          _profileImage!.path,
        ));

      final response = await request.send();

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Profile image updated successfully')),
        );
        _fetchUserDetails(); // Refresh user details to show updated image
      } else {
        final errorResponse = await response.stream.bytesToString();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $errorResponse')),
        );
      }
    } catch (e) {
      print('Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error updating profile image')),
      );
    }
  }

  Future<void> _removeImage() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? '';

    try {
      final response = await http.delete(
        Uri.parse('http://192.168.0.122:5000/api/remove-profile-image'), // Ensure this endpoint matches your server setup
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        setState(() {
          _profileImage = null;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Profile image removed successfully')),
        );
      } else {
        final errorResponse = jsonDecode(response.body);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${errorResponse['message']}')),
        );
      }
    } catch (e) {
      print('Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error removing profile image')),
      );
    }
  }

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _profileImage = image;
      });
      await _uploadImage(); // Upload the image to the server
    }
  }

  void _showImageOptions() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        color: Color(0xFF09648C),
        height: 120,
        child: Column(
          children: [
            ListTile(
              leading: Icon(Icons.photo, color: Colors.white),
              title: Text(
                'Select from Gallery',
                style: GoogleFonts.poppins(fontSize: 15, color: Colors.white),
              ),
              onTap: () {
                Navigator.pop(context);
                _pickImage();
              },
            ),
            ListTile(
              leading: Icon(Icons.delete, color: Colors.white),
              title: Text(
                'Remove Profile Photo',
                style: GoogleFonts.poppins(fontSize: 15, color: Colors.white),
              ),
              onTap: () {
                Navigator.pop(context);
                _removeImage();
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Logout'),
          content: Text('Are you sure you want to log out?'),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
            TextButton(
              child: Text('Logout'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                Navigator.pushReplacementNamed(context, '/login');
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        leading: IconButton(
          icon: Image.asset('assets/images/back_arrow.png',
              height: screenWidth * 0.07, width: screenWidth * 0.07),
          onPressed: () {
            Navigator.of(context).pop(); // Go back to the previous screen
          },
        ),
        title: Text(
          'My Profile',
          style: GoogleFonts.poppins(
              fontSize: screenWidth * 0.08,
              color: Color(0xFF09648C),
              fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Image.asset('assets/images/edit.png',
                height: screenWidth * 0.08, width: screenWidth * 0.08),
            onPressed: () {
              setState(() {
                if (isEditing) {
                  _saveProfileData(); // Save data when switching from edit mode
                }
                isEditing = !isEditing;
              });
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(screenWidth * 0.04),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: screenHeight * 0.015),
              Center(
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: screenWidth * 0.110,
                      backgroundImage: _profileImage != null
                          ? FileImage(File(_profileImage!.path))
                          : AssetImage('assets/images/profile.png')
                              as ImageProvider,
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: _showImageOptions,
                        child: CircleAvatar(
                          radius: screenWidth * 0.04,
                          backgroundColor: Colors.white,
                          child: Image.asset('assets/images/plus.png',
                              height: screenWidth * 0.05,
                              width: screenWidth * 0.05),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: screenHeight * 0.065),
              Text(
                'Name',
                style: GoogleFonts.poppins(
                    fontSize: screenWidth * 0.03,
                    color: Color(0xFF9098B1),
                    fontWeight: FontWeight.w400),
              ),
              SizedBox(height: screenHeight * 0.01),
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: Colors.grey, width: 1),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: Colors.grey, width: 1),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: Color(0xFF09648C), width: 1),
                  ),
                ),
                enabled: isEditing,
              ),
              SizedBox(height: screenHeight * 0.02),
              Text(
                'Contact',
                style: GoogleFonts.poppins(
                    fontSize: screenWidth * 0.03,
                    color: Color(0xFF9098B1),
                    fontWeight: FontWeight.w400),
              ),
              SizedBox(height: screenHeight * 0.01),
              TextField(
                controller: phoneController,
                enabled: isEditing,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: Colors.grey, width: 1),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: Colors.grey, width: 1),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: Color(0xFF09648C), width: 1),
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.02),
              Text(
                'Password',
                style: GoogleFonts.poppins(
                    fontSize: screenWidth * 0.03,
                    color: Color(0xFF9098B1),
                    fontWeight: FontWeight.w400
                ),
              ),
              SizedBox(height: screenHeight * 0.01),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: Colors.grey, width: 1),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: Colors.grey, width: 1),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: Color(0xFF09648C), width: 1),
                ),
              ),
                enabled: isEditing,
              ),
              SizedBox(height: screenHeight * 0.16),
              Center(
                child: GestureDetector(
                  onTap: _showLogoutDialog,
                  child: Image.asset(
                    'assets/images/Logout.png',
                    height: screenHeight * 0.05,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
