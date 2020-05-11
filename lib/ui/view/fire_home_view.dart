import 'package:flutter/material.dart';
import 'package:flutter_firebase/core/model/student.dart';
import 'package:flutter_firebase/core/model/user.dart';
import 'package:flutter_firebase/core/services/firebase_service.dart';

class FireHomeView extends StatefulWidget {
  @override
  _FireHomeViewState createState() => _FireHomeViewState();
}

class _FireHomeViewState extends State<FireHomeView> {
  FirebaseService service;

  @override
  void initState() {
    super.initState();
    service = FirebaseService();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Firebase Test"),
        ),
        body: _studentFutureBuilder);
  }

  Widget get _userFutureBuilder => FutureBuilder<List<User>>(
        future: service.getUsers(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              if (snapshot.hasData)
                return _listUser(snapshot.data);
              else
                return _notFoundWidget;
              break;
            default:
              return _waitingWidget;
          }
        },
      );

  Widget get _studentFutureBuilder => FutureBuilder<List<Student>>(
        future: service.getStudents(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              if (snapshot.hasData)
                return _listStudent(snapshot.data);
              else
                return _notFoundWidget;
              break;
            default:
              return _waitingWidget;
          }
        },
      );

  Widget _listStudent(List<Student> students) => ListView.builder(
        itemBuilder: (context, index) => _studentCard(students[index]),
        itemCount: students.length,
      );
  Widget _studentCard(Student student) => Card(
        child: ListTile(
          title: Text(student.name +
              " " +
              student.value.toString() +
              " " +
              student.key),
        ),
      );

  Widget _listUser(List<User> users) => ListView.builder(
        itemBuilder: (context, index) => _userCard(users[index]),
        itemCount: users.length,
      );
  Widget _userCard(User user) => Card(
        child: ListTile(
          title: Text(user.name),
        ),
      );

  Widget get _notFoundWidget => Center(child: Text("Not Found"));
  Widget get _waitingWidget => Center(child: CircularProgressIndicator());
}
