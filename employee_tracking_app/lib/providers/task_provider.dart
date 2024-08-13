import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/task.dart';

class TaskProvider with ChangeNotifier {
  List<Task> _tasks = [];

  List<Task> get tasks => _tasks;

  Future<void> fetchTasks() async {
    final response = await http.get(Uri.parse('http://192.168.0.122:5000/api/tasks'));
    final responseData = json.decode(response.body) as List;
    _tasks = responseData.map((taskData) => Task(
      id: taskData['id'],
      name: taskData['name'],
      projectName: taskData['projectName'],
      location: taskData['location'],
      duration: taskData['duration'],
      isCompleted: taskData['isCompleted'],
    )).toList();
    notifyListeners();
  }
}
