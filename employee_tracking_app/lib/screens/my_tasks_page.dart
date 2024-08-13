import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';  // Import for date formatting
import 'package:employee_tracking_app/screens/task_details_page.dart';
import 'package:employee_tracking_app/widgets/bottom_nav_bar.dart';

class MyTaskPage extends StatelessWidget {
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
          'My Tasks',
          style: GoogleFonts.poppins(color: Color(0xFF09648C), fontSize: screenWidth * 0.075, fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Image.asset('assets/images/User.png', height: screenWidth * 0.065, width: screenWidth * 0.065),
          onPressed: () {
            Navigator.pushNamed(context, '/profile');
          },
        ),
        actions: [
          IconButton(
            icon: Image.asset('assets/images/Notification.png', height: screenWidth * 0.087, width: screenWidth * 0.087),
            onPressed: () {
              Navigator.pushNamed(context, '/notifications');
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(screenWidth * 0.02),
        child: ListView(
          children: _generateTaskList(context, screenWidth, screenHeight),
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: 1,
        onTap: (index) {
          if (index == 1) {
            // Already on My Tasks Page
          } else if (index == 0) {
            Navigator.pushReplacementNamed(context, '/task_history');
          } else if (index == 2) {
            Navigator.pushReplacementNamed(context, '/progress');
          }
        },
      ),
    );
  }

  List<Widget> _generateTaskList(BuildContext context, double screenWidth, double screenHeight) {
    List<Widget> tasks = [];

    // Fixed list of dates and times
    List<DateTime> taskDates = [
      DateTime(2024, 7, 18, 10, 30),
      DateTime(2024, 7, 20, 12, 45),
      DateTime(2024, 7, 22, 9, 0),
      DateTime(2024, 7, 24, 14, 15),
      DateTime(2024, 7, 25, 11, 0),
      DateTime(2024, 7, 27, 16, 30),
      DateTime(2024, 7, 29, 13, 45),
      DateTime(2024, 7, 31, 10, 0),
      DateTime(2024, 8, 1, 15, 15),
      DateTime(2024, 8, 2, 9, 30),
    ];

    DateTime now = DateTime.now();
    DateTime tomorrow = DateTime(now.year, now.month, now.day).add(Duration(days: 1));

    // Sort taskDates so that future dates come first, in descending order
    taskDates.sort((a, b) => b.compareTo(a));

    for (int i = 0; i < taskDates.length; i++) { // Number of tasks
      String taskNumber = (i + 1).toString().padLeft(2, '0');  // Convert to two-digit format
      DateTime taskDate = taskDates[i];
      bool isFutureTask = taskDate.isAfter(tomorrow);

      // Add the date label above the card with time
      tasks.add(
        Padding(
          padding: EdgeInsets.symmetric(vertical: screenHeight * 0.01),
          child: _getDateLabel(taskDate, screenWidth),
        ),
      );

      // Add a task card
      tasks.add(
        Card(
          elevation: 0,
          color: isFutureTask ? Color(0xFFE3F2FD) : Colors.white,  // Blue background for future tasks
          margin: EdgeInsets.symmetric(vertical: screenHeight * 0.005),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: ListTile(
            contentPadding: EdgeInsets.all(screenWidth * 0.04),
            title: Text(
              'Task number $taskNumber', // Use formatted task number
              style: GoogleFonts.poppins(
                color: Color(0xFF000000),
                fontSize: screenWidth * 0.04,
                fontWeight: FontWeight.w500,
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: screenHeight * 0.015), // Add space between task number and following rows
                // Time and Project Name in the same row
                Row(
                  children: [
                    Row(
                      children: [
                        Image.asset(
                          'assets/images/clock.png',
                          height: screenWidth * 0.05,
                          width: screenWidth * 0.05,
                        ),
                        SizedBox(width: screenWidth * 0.01),
                        Text(
                          "3h 30m", // Use fixed time
                          style: GoogleFonts.poppins(color: Colors.black, fontSize: screenWidth * 0.03,fontWeight: FontWeight.w400,),
                        ),
                      ],
                    ),
                    SizedBox(width: screenWidth * 0.22), // Adjust this value to change the space
                    Row(
                      children: [
                        Image.asset(
                          'assets/images/project.png',
                          height: screenWidth * 0.045,
                          width: screenWidth * 0.045,
                        ),
                        SizedBox(width: screenWidth * 0.01),
                        Text(
                          'Project Name', // Replace with actual project name
                          style: GoogleFonts.poppins(color: Colors.black, fontSize: screenWidth * 0.03,fontWeight: FontWeight.w400,),
                        ),
                      ],
                    ),
                  ],
                ),
                // Project Location with padding and text wrapping
                SizedBox(height: screenHeight * 0.02),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start, // Aligns text to the top of the row
                  children: [
                    Image.asset(
                      'assets/images/pin.png',
                      height: screenWidth * 0.05,
                      width: screenWidth * 0.05,
                    ),
                    SizedBox(width: screenWidth * 0.01),
                    Expanded(
                      child: Text(
                        '14155 Sullyfield Circle, Suite H, Chantilly, VA 20151', // Replace with actual location
                        style: GoogleFonts.poppins(color: Colors.black, fontSize: screenWidth * 0.03,fontWeight: FontWeight.w400,),
                        overflow: TextOverflow.visible, // Ensure text wraps to the next line
                      ),
                    ),
                    SizedBox(width: screenWidth * 0.2), // Space on the right side
                  ],
                ),
              ],
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TaskDetailsPage(
                    taskName: 'Task Number $taskNumber', // Replace with actual task details
                    status: 'In Progress', // Replace with actual task status
                    startDate: DateFormat('dd-MM-yyyy hh:mm a').format(taskDate), // Use formatted start date
                    projectLocation: 'Location $i', // Replace with actual location
                    projectName: 'Project $i', // Replace with actual project name
                    siteContact: 'Contact $i', // Replace with actual site contact
                  ),
                ),
              );
            },
          ),
        ),
      );
    }

    return tasks;
  }

  Widget _getDateLabel(DateTime date, double screenWidth) {
    DateTime now = DateTime.now();
    DateTime today = DateTime(now.year, now.month, now.day);
    DateTime yesterday = today.subtract(Duration(days: 1));
    DateTime tomorrow = today.add(Duration(days: 1));

    String label;
    if (date.year == today.year &&
        date.month == today.month &&
        date.day == today.day) {
      label = 'Today, ${DateFormat('hh:mm a').format(date)}';
    } else if (date.year == yesterday.year &&
               date.month == yesterday.month &&
               date.day == yesterday.day) {
      label = 'Yesterday, ${DateFormat('hh:mm a').format(date)}';
    } else if (date.year == tomorrow.year &&
               date.month == tomorrow.month &&
               date.day == tomorrow.day) {
      label = 'Tomorrow, ${DateFormat('hh:mm a').format(date)}';
    } else {
      label = '${DateFormat('dd-MM-yyyy').format(date)}, ${DateFormat('hh:mm a').format(date)}';
    }

    return RichText(
      text: TextSpan(
        text: label.split(', ')[0] + ', ', // Date part
        style: GoogleFonts.poppins(fontSize: screenWidth * 0.03,color: Color(0xFF9098B1),fontWeight: FontWeight.w400,),
        children: [
          TextSpan(
            text: label.split(', ')[1], // Time part
            style: GoogleFonts.poppins(fontSize: screenWidth * 0.03,color: Color(0xFF9098B1),fontWeight: FontWeight.w400,),
          ),
        ],
      ),
      textAlign: TextAlign.center,
    );
  }
}
