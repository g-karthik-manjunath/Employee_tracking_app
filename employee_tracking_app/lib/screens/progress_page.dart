import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/bottom_nav_bar.dart';

class ProgressPage extends StatelessWidget {
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
          'Progress',
          style: GoogleFonts.poppins(color: Color(0xFF09648C), fontSize: screenWidth * 0.07, fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
        leading: IconButton(
          icon:  Image.asset('assets/images/back_arrow.png',height: screenHeight*0.07,width: screenWidth*0.07),
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/my_tasks');
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(screenWidth * 0.04),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: screenHeight * 0.02),
            Center(
              child: Container(
                constraints: BoxConstraints(maxWidth: screenWidth * 0.8), // Limit the width of the text
                child: Text(
                  'This section contains only last 7 days progress. Filter dates to review previous history',
                  style: GoogleFonts.poppins(fontSize: screenWidth * 0.028, color: Colors.black),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.025),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: screenWidth * 0.05), // Add padding to move text field from left edge
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'To',
                          style: GoogleFonts.poppins(fontSize: screenWidth * 0.03, color: Color(0xFF9098B1)),
                        ),
                        SizedBox(height: screenHeight * 0.005),
                        SizedBox(
                          height: screenHeight * 0.08,
                          child: TextField(
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(vertical: screenHeight * 0.01, horizontal: screenWidth * 0.03), // Adjust padding to reduce height
                              hintText: 'DD/MM/YYYY',
                              hintStyle: GoogleFonts.poppins(color: Color(0xFF333434), fontSize: screenWidth * 0.035),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(15)),
                                borderSide: BorderSide(
                                  color: Color(0xFF9098B1).withOpacity(0.5),
                                  width: 1.0, // Ensure border thickness is visible
                                ),
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
                            ),
                            keyboardType: TextInputType.datetime,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: screenWidth * 0.02),
                Container(
                  padding: EdgeInsets.only(top: screenHeight * 0.001),
                  child: Align(
                    alignment: Alignment.center,
                    child: Image.asset('assets/images/arrow.png',height: screenHeight*0.07,width: screenWidth*0.07),
                  ),
                ),
                SizedBox(width: screenWidth * 0.02),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(right: screenWidth * 0.05), // Add padding to move text field from right edge
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'From',
                          style: GoogleFonts.poppins(fontSize: screenWidth * 0.03, color: Color(0xFF9098B1)),
                        ),
                        SizedBox(height: screenHeight * 0.005),
                        SizedBox(
                          height: screenHeight * 0.08,
                          child: TextField(
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(vertical: screenHeight * 0.01, horizontal: screenWidth * 0.03), // Adjust padding to reduce height
                              hintText: 'DD/MM/YYYY',
                              hintStyle: GoogleFonts.poppins(color: Color(0xFF333434), fontSize: screenWidth * 0.035),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(15)),
                                borderSide: BorderSide(
                                  color: Color(0xFF9098B1).withOpacity(0.5),
                                  width: 1.0, // Ensure border thickness is visible
                                ),
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
                            ),
                            keyboardType: TextInputType.datetime,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: screenHeight * 0.05), // Add space before text sections
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05), // Add horizontal padding
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Travel Hours',
                    style: GoogleFonts.poppins(fontSize: screenWidth * 0.03, color: Colors.grey,fontWeight: FontWeight.w400),
                  ),
                  SizedBox(height: screenHeight * 0.005),
                  Text(
                    '4h 30m',
                    style: GoogleFonts.poppins(fontSize: screenWidth * 0.035, color: Colors.black,fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
            SizedBox(height: screenHeight * 0.02), // Add space between sections
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05), // Add horizontal padding
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Work Hours',
                    style: GoogleFonts.poppins(fontSize: screenWidth * 0.03, color: Colors.grey,fontWeight: FontWeight.w400),
                  ),
                  SizedBox(height: screenHeight * 0.005),
                  Text(
                    '56h 45m',
                    style: GoogleFonts.poppins(fontSize: screenWidth * 0.035, color: Colors.black,fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
            SizedBox(height: screenHeight * 0.02), // Add space between sections
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05), // Add horizontal padding
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Tasks Completed',
                    style: GoogleFonts.poppins(fontSize: screenWidth * 0.03, color: Colors.grey),
                  ),
                  SizedBox(height: screenHeight * 0.005),
                  Text(
                    '45',
                    style: GoogleFonts.poppins(fontSize: screenWidth * 0.035, color: Colors.black,fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
            SizedBox(height: screenHeight * 0.1),
            ElevatedButton(
              onPressed: () {
                // Share progress
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
                  Image.asset('assets/images/share.png', height: screenHeight * 0.03, width: screenHeight * 0.03),
                  SizedBox(width: screenWidth * 0.02),
                  Text(
                    'Share',
                    style: GoogleFonts.poppins(fontSize: screenWidth * 0.04, color: Colors.white,fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: 2,
        onTap: (index) {
          if (index == 0) {
            Navigator.pushReplacementNamed(context, '/task_history');
          } else if (index == 1) {
            Navigator.pushReplacementNamed(context, '/my_tasks');
          } else if (index == 2) {
            // Already on Progress Page
          }
        },
      ),
    );
  }
}
