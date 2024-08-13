import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';  // Import for date formatting

import '../../widgets/bottom_nav_bar.dart';

class TaskHistoryPage extends StatelessWidget {
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
          'Task History',
          style: GoogleFonts.poppins(
            color: Color(0xFF09648C),
            fontWeight: FontWeight.w700,
            fontSize: screenWidth * 0.065,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Image.asset('assets/images/User.png', height: screenHeight * 0.030, width: screenHeight * 0.030),
          onPressed: () {
            Navigator.pushNamed(context, '/profile');
          },
        ),
        actions: [
          IconButton(
            icon: Image.asset('assets/images/Notification.png', height: screenHeight * 0.040, width: screenHeight * 0.040),
            onPressed: () {
              Navigator.pushNamed(context, '/notifications');
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(screenWidth * 0.02),
        child: ListView.builder(
          itemCount: 10, // Total task cards
          itemBuilder: (context, index) {
            final dateText = _generateDateText(index);

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (index % 2 == 0) // Show date for every new day
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: screenHeight * 0.01),
                    child: Text(
                      dateText,
                      style: GoogleFonts.poppins(
                        fontSize: screenWidth * 0.03, // Reduced font size
                        color: Color(0xFF9098B1),
                      ),
                    ),
                  ),
                Card(
                  elevation: 0,
                  color: Colors.white,
                  margin: EdgeInsets.symmetric(vertical: screenHeight * 0.015,horizontal: screenWidth*0.01),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(screenWidth * 0.02),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        // flex: 2, // Give the first column more space
                        child: Padding(
                          padding: EdgeInsets.all(screenWidth * 0.02),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Task Number Row
                              Text(
                                'Task number ${_formatTaskNumber(index + 1)}', // Format task number with leading zero
                                style: GoogleFonts.poppins(
                                  color: Color(0xFF000000),
                                  fontWeight: FontWeight.w500,
                                  fontSize: screenWidth * 0.045,
                                ),
                              ),
                              SizedBox(height: screenHeight * 0.02),
                              // Header Row
                              Row(
                                children: [
                                  Expanded(child: Text('Travel Time', style: GoogleFonts.poppins(color: Color(0xFF9098B1), fontSize: screenWidth * 0.035,fontWeight: FontWeight.w400))),
                                  SizedBox(width: screenWidth * 0.03), // Adjust spacing
                                  Expanded(child: Text('Work Time', style: GoogleFonts.poppins(color: Color(0xFF9098B1), fontSize: screenWidth * 0.035,fontWeight: FontWeight.w400))),
                                  SizedBox(width: screenWidth * 0.01), // Adjust spacing
                                  Expanded(child: Text('Task Date', style: GoogleFonts.poppins(color: Color(0xFF9098B1), fontSize: screenWidth * 0.035,fontWeight: FontWeight.w400))),
                                ],
                              ),
                              SizedBox(height: screenHeight * 0.005),
                              // Content Row
                              Row(
                                children: [
                                  Expanded(child: Text('3h 30m', style: GoogleFonts.poppins(fontSize: screenWidth * 0.03,fontWeight: FontWeight.w400))),
                                  SizedBox(width: screenWidth * 0.03), // Adjust spacing
                                  Expanded(child: Text('1h 40m', style: GoogleFonts.poppins(fontSize: screenWidth * 0.03,fontWeight: FontWeight.w400))),
                                  SizedBox(width: screenWidth * 0.01), // Adjust spacing
                                  Expanded(child: Text('23/07/24', style: GoogleFonts.poppins(fontSize: screenWidth * 0.03,fontWeight: FontWeight.w400))),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 0, // Adjust this if you want to give more or less space to the second column
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding: EdgeInsets.only(right: screenWidth * 0.02, top: screenHeight * 0.001), // Adjust vertical position
                            child: Text(
                              'Completed', // Fixed status to 'Completed'
                              style: GoogleFonts.poppins(
                                color: Color(0xFF09648C), // Color for Completed
                                fontWeight: FontWeight.w700,
                                fontSize: screenWidth * 0.036,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: 0,
        onTap: (index) {
          if (index == 1) {
            Navigator.pushReplacementNamed(context, '/my_tasks');
          } else if (index == 0) {
            // Already on Task History Page
          } else if (index == 2) {
            Navigator.pushReplacementNamed(context, '/progress');
          }
        },
      ),
    );
  }

  String _generateDateText(int index) {
    final today = DateTime.now();
    final taskDate = today.subtract(Duration(days: index ~/ 2)); // Assuming two tasks per day for simplicity

    if (taskDate.day == today.day) {
      return 'Today';
    } else if (taskDate.day == today.subtract(Duration(days: 1)).day) {
      return 'Yesterday';
    } else {
      return DateFormat('dd MMM yyyy').format(taskDate); // Use "dd - MMM - yyyy" format
    }
  }

  String _formatTaskNumber(int number) {
    return number.toString().padLeft(2, '0');  // Format number with leading zero
  }
}
