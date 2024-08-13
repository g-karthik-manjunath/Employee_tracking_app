import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';  // Import for date formatting
import 'dart:math';

class NotificationPage extends StatelessWidget {
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
          'Notifications',
          style: GoogleFonts.poppins(
            color: Color(0xFF09648C),
            fontSize: screenWidth * 0.075,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.all(screenWidth * 0.04),
        children: _generateNotificationList(screenWidth, screenHeight),
      ),
    );
  }

  List<Widget> _generateNotificationList(double screenWidth, double screenHeight) {
    List<Widget> notifications = [];
    List<String> titles = ['Task Created', 'Reminder'];
    List<String> subtitles = [
      'Mike Hunt created a new task due on 02/08/24 5:06 PM',
      'Your task is due in next 3 hours. Heads up and complete your task',
    ];
    List<String> icons = [
      'assets/images/ntask.png',
      'assets/images/alarm.png',
    ];

    List<DateTime> notificationDates = [
      DateTime(2024, 7, 28, 10, 30),
      DateTime(2024, 7, 29, 14, 45),
      DateTime(2024, 7, 30, 9, 15),
      DateTime(2024, 7, 31, 16, 0),
      DateTime(2024, 7, 30, 11, 0),
      DateTime(2024, 7, 29, 13, 30),
      DateTime(2024, 7, 28, 17, 45),
      DateTime(2024, 7, 31, 12, 30),
      DateTime(2024, 7, 30, 14, 15),
      DateTime(2024, 7, 29, 16, 45),
      DateTime(2024, 7, 28, 10, 0),
      DateTime(2024, 7, 31, 15, 15),
      DateTime(2024, 7, 30, 9, 30),
      DateTime(2024, 7, 29, 11, 15),
      DateTime(2024, 7, 28, 12, 0),
    ];

    // Sort notificationDates to bring today's notifications to the top
    notificationDates.sort((a, b) {
      DateTime today = DateTime.now();
      DateTime aDate = DateTime(a.year, a.month, a.day);
      DateTime bDate = DateTime(b.year, b.month, b.day);

      if (aDate == today && bDate == today) {
        return 0;
      } else if (aDate == today) {
        return -1;
      } else if (bDate == today) {
        return 1;
      } else {
        return b.compareTo(a);
      }
    });

    // Group notifications by date
    Map<String, List<int>> groupedNotifications = {};
    for (int i = 0; i < 15; i++) {
      String label = _getDateLabel(notificationDates[i]);

      if (!groupedNotifications.containsKey(label)) {
        groupedNotifications[label] = [];
      }
      groupedNotifications[label]!.add(i);
    }

    groupedNotifications.forEach((label, indices) {
      String time = indices.isNotEmpty ? _getFixedTime(notificationDates[indices.first]) : '';

      notifications.add(
        Padding(
          padding: EdgeInsets.symmetric(vertical: screenHeight * 0.01),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                label,
                style: GoogleFonts.poppins(
                  fontSize: screenWidth * 0.03,
                  color: Colors.black.withOpacity(0.6),
                  fontWeight: FontWeight.w400,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(width: screenWidth * 0.02),
              Text(
                time,
                style: GoogleFonts.poppins(
                  fontSize: screenWidth * 0.03,
                  color: Colors.black.withOpacity(0.6),
                  fontWeight: FontWeight.w400,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );

      indices.forEach((i) {
        notifications.add(
          Padding(
            padding: EdgeInsets.only(bottom: screenHeight * 0.01), // Increased space between cards
            child: _buildNotificationCard(
              titles[i % titles.length],
              subtitles[i % subtitles.length],
              icons[i % icons.length],
              screenWidth,
              screenHeight,
            ),
          ),
        );
      });
    });

    return notifications;
  }

Widget _buildNotificationCard(String title, String subtitle, String iconPath, double screenWidth, double screenHeight) {
  return Card(
    color: Colors.white,
    elevation: 0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    child: Padding(
      padding: EdgeInsets.all(screenWidth * 0.02),  // Padding around card
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Padding(
                padding: EdgeInsets.only(right: screenWidth * 0.03),  // Space between image and text
                child: Image.asset(
                  iconPath,
                  width: screenWidth * 0.06,  // Adjust image size if needed
                  height: screenHeight * 0.06,
                ),
              ),
              Text(
                title,
                style: GoogleFonts.poppins(
                  fontSize: screenWidth * 0.045,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          SizedBox(height: screenHeight * 0.0001),  // Space between title and subtitle
          Padding(
            padding: EdgeInsets.only(left: screenWidth * 0.09),  // Space on the left of the subtitle
            child: Text(
              subtitle,
              style: GoogleFonts.poppins(
                fontSize: screenWidth * 0.03,  // Adjusted font size
                color: Colors.black.withOpacity(0.6),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

String _getDateLabel(DateTime date) {
  DateTime now = DateTime.now();
  DateTime today = DateTime(now.year, now.month, now.day);
  DateTime yesterday = today.subtract(Duration(days: 1));

  // Define date formats
  DateFormat dayMonthFormat = DateFormat('dd MMMM');  // Format for day and month name

  if (date.year == today.year && date.month == today.month && date.day == today.day) {
    return 'Today';
  } else if (date.year == yesterday.year && date.month == yesterday.month && date.day == yesterday.day) {
    return 'Yesterday';
  } else {
    return dayMonthFormat.format(date);  // Format date as DD Month Name
  }
}

  String _getFixedTime(DateTime date) {
  Random random = Random();
  int hour = random.nextInt(24);
  int minute = random.nextInt(60);
  return DateFormat('HH:mm').format(DateTime(date.year, date.month, date.day, hour, minute));
}
}