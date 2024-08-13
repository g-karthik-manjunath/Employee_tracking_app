import 'package:employee_tracking_app/screens/my_tasks_page.dart';
import 'package:flutter/material.dart';
import 'screens/login_page.dart';
// import 'screens/my_task_page.dart';
import 'screens/task_history_page.dart';
import 'screens/progress_page.dart';
import 'screens/task_details_page.dart';
import 'screens/profile_page.dart';
import 'screens/notification_page.dart'; 

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Employee Tracking App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => LoginPage(),
        '/my_tasks': (context) => MyTaskPage(),
        '/task_history': (context) => TaskHistoryPage(),
        '/progress': (context) => ProgressPage(),
        '/task_details': (context) => TaskDetailsPage(
              taskName: '', // Default value, or handle dynamically
              status: '',
              startDate: 'startDate: 15-07-2023 14:30',
              projectLocation: '',
              projectName: '',
              siteContact: '',
            ),
        '/profile': (context) => ProfilePage(),
        '/notifications': (context) => NotificationPage(),
        '/login': (context) => LoginPage(),
      },
    );
  }
}
