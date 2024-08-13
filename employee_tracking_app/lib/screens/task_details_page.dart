import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class TaskDetailsPage extends StatelessWidget {
  final String taskName;
  final String status;
  final String startDate;
  final String projectLocation;
  final String projectName;
  final String siteContact;

  TaskDetailsPage({
    required this.taskName,
    required this.status,
    required this.startDate,
    required this.projectLocation,
    required this.projectName,
    required this.siteContact,
  });

  String formatDateTime(String dateTimeString) {
    try {
      final DateFormat inputFormat = DateFormat('dd-MM-yyyy HH:mm');
      final DateFormat outputFormat = DateFormat('dd-MM-yyyy hh:mm a');
      final DateTime dateTime = inputFormat.parse(dateTimeString);
      return outputFormat.format(dateTime);
    } catch (e) {
      return dateTimeString; // Return original string if parsing fails
    }
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
        title: Text(
          'Task Details',
          style: GoogleFonts.poppins(
            color: Color(0xFF09648C),
            fontSize: screenWidth * 0.07,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Image.asset('assets/images/Notification.png', height: screenHeight * 0.04, width: screenHeight * 0.04),
            onPressed: () {
              Navigator.pushNamed(context, '/notifications');
            },
          ),
        ],
      ),
      body: Column(
        children: [
          SizedBox(height: screenHeight * 0.05), // Space between AppBar and content
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(screenWidth * 0.06),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Status',
                    style: GoogleFonts.poppins(
                      color: Color(0xFF9098B1),
                      fontSize: screenWidth * 0.032,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    'Initiated',
                    style: GoogleFonts.poppins(
                      color: Color(0xFF333434),
                      fontSize: screenWidth * 0.035,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  Text(
                    'Start Date and Time',
                    style: GoogleFonts.poppins(
                      color: Color(0xFF9098B1),
                      fontSize: screenWidth * 0.032,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    formatDateTime(startDate),
                    style: GoogleFonts.poppins(
                      color: Color(0xFF333434),
                      fontSize: screenWidth * 0.035,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  Text(
                    'Site Address',
                    style: GoogleFonts.poppins(
                      color: Color(0xFF9098B1),
                      fontSize: screenWidth * 0.032,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    '14155 Sullyfield Circle, Suite H, Chantilly, VA 20151',
                    style: GoogleFonts.poppins(
                      color: Color(0xFF333434),
                      fontSize: screenWidth * 0.035,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  Text(
                    'Project Name',
                    style: GoogleFonts.poppins(
                      color: Color(0xFF9098B1),
                      fontSize: screenWidth * 0.032,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    '14155 Sullyfield Circle, Suite H, Chantilly, VA 20151',
                    style: GoogleFonts.poppins(
                      color: Color(0xFF333434),
                      fontSize: screenWidth * 0.035,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  Text(
                    'Site Contact',
                    style: GoogleFonts.poppins(
                      color: Color(0xFF9098B1),
                      fontSize: screenWidth * 0.032,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        '9632589354',
                        style: GoogleFonts.poppins(
                          color: Color(0xFF333434),
                          fontSize: screenWidth * 0.035,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      // Spacer(),
                      Padding(
                        padding: EdgeInsets.only(left: screenWidth * 0.5), // Move call image slightly to the left
                        child: Image.asset(
                          'assets/images/call.png',
                          height: screenHeight * 0.04,
                          width: screenHeight * 0.04,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: screenHeight * 0.03),
                  Row(
                    children: [
                      Text(
                        'Navigate to map',
                        style: GoogleFonts.poppins(
                          color: Color(0xFF09648C),
                          fontSize: screenWidth * 0.04,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(width: screenWidth * 0.02),
                      Image.asset(
                        'assets/images/map.png',
                        height: screenHeight * 0.02,
                        width: screenHeight * 0.02,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: screenHeight * 0.1), // Adjust bottom padding as needed
            child: ElevatedButton(
              onPressed: () {
                // integrate left for work
              },
              style: ElevatedButton.styleFrom(
                minimumSize: Size(screenWidth * 0.9, screenHeight * 0.07),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                backgroundColor: Color(0xFF09648C),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Left for work',
                    style: GoogleFonts.poppins(fontSize: screenWidth * 0.04, color: Colors.white,fontWeight: FontWeight.w600,),
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
