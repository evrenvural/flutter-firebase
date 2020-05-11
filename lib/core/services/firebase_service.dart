import 'dart:convert';
import 'dart:io';
import 'package:flutter_firebase/core/model/student.dart';
import 'package:http/http.dart' as http;

import 'package:flutter_firebase/core/model/user.dart';

class FirebaseService {
  static const String FIREBASE_URL =
      "https://flutter-example-45a73.firebaseio.com/";

  Future<List<User>> getUsers() async {
    final response = await http.get("$FIREBASE_URL/users.json");

    switch (response.statusCode) {
      case HttpStatus.ok:
        final jsonModel = json.decode(response.body);
        final userList = jsonModel
            .map((e) => User.fromJson(e as Map<String, dynamic>))
            .toList()
            .cast<User>();
        return userList;
        break;
      default:
        return Future.error(response.statusCode);
    }
  }

  Future<List<Student>> getStudents() async {
    final response = await http.get("$FIREBASE_URL/students.json");

    switch (response.statusCode) {
      case HttpStatus.ok:
        final jsonModel = json.decode(response.body) as Map;
        List<Student> studentList = List<Student>();
        jsonModel.forEach((key, value) {
          Student student = Student.fromJson(value);
          student.key = key;
          studentList.add(student);
        });


        return studentList;
        break;
      default:
        return Future.error(response.statusCode);
    }
  }
}
