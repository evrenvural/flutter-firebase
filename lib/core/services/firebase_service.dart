import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:flutter_firebase/core/model/student.dart';
import 'package:flutter_firebase/core/model/user/user_request.dart';

import 'package:flutter_firebase/core/model/user.dart';

class FirebaseService {
  static const String FIREBASE_URL =
      "https://flutter-example-45a73.firebaseio.com/";

  static const String FIREBASE_AUTH_URL =
      "https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyDBp405xKlG6iuzC20YhufiW4Skadgc7-c";

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

  Future<bool> postUser(UserRequest user) async {
    final userJson = json.encode(user.toJson());
    final response = await http.post(FIREBASE_AUTH_URL, body: userJson);

    switch (response.statusCode) {
      case HttpStatus.ok:
        return true;
        break;
      default:
        return false;
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
