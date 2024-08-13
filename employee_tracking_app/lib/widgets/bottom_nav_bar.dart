import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  BottomNavBar({required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      height: screenHeight * 0.08,
      decoration: BoxDecoration(
        color: Color(0xFF09648C),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(screenWidth * 0.06),
          topRight: Radius.circular(screenWidth * 0.06),
          bottomLeft: Radius.circular(screenWidth * 0.0),
          bottomRight: Radius.circular(screenWidth * 0.0),
        ),
      ),
      child: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) {
          // Perform navigation based on the selected index
          if (index == 0) {
            Navigator.pushReplacementNamed(context, '/task_history');
          } else if (index == 1) {
            Navigator.pushReplacementNamed(context, '/my_tasks');
          } else if (index == 2) {
            Navigator.pushReplacementNamed(context, '/progress');
          }

          // Call the external onTap callback after navigation
          onTap(index);
        },
        backgroundColor: Colors.transparent,
        selectedItemColor: Colors.transparent, // Hide the selected item color
        unselectedItemColor: Colors.white,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: currentIndex == 0 ? Colors.white.withOpacity(0.3) : Colors.transparent,
              ),
              padding: EdgeInsets.all(screenWidth * 0.025),
              child: Image.asset('assets/images/history.png', height: screenHeight * 0.030, width: screenHeight * 0.030),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: currentIndex == 1 ? Colors.white.withOpacity(0.3) : Colors.transparent,
              ),
              padding: EdgeInsets.all(screenWidth * 0.025),
              child: Image.asset('assets/images/task.png', height: screenHeight * 0.030, width: screenHeight * 0.030),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: currentIndex == 2 ? Colors.white.withOpacity(0.3) : Colors.transparent,
              ),
              padding: EdgeInsets.all(screenWidth * 0.025),
              child: Image.asset('assets/images/progress.png', height: screenHeight * 0.035, width: screenHeight * 0.035),
            ),
            label: '',
          ),
        ],
        selectedIconTheme: IconThemeData(size: screenWidth * 0.07),
        unselectedIconTheme: IconThemeData(size: screenWidth * 0.07),
        selectedLabelStyle: TextStyle(fontSize: 0),
        unselectedLabelStyle: TextStyle(fontSize: 0),
        elevation: 0,
        enableFeedback: false,
      ),
    );
  }
}
