import 'package:flutter/material.dart';
import 'package:flutter_firebase/core/model/user/user_request.dart';
import 'package:flutter_firebase/core/services/firebase_service.dart';
import 'package:flutter_firebase/ui/view/home/fire_home_view.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  String email;
  String password;
  FirebaseService service = FirebaseService();

  GlobalKey<ScaffoldState> scaffold = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffold,
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: "Email"),
              onChanged: (value) {
                setState(() {
                  email = value;
                });
              },
            ),
            SizedBox(height: 15),
            TextField(
                decoration: InputDecoration(labelText: "Password"),
                onChanged: (value) {
                  setState(() {
                    password = value;
                  });
                }),
            SizedBox(height: 25),
            FloatingActionButton.extended(
                onPressed: () async {
                  UserRequest userRequest =
                      UserRequest(email: email, password: password);
                  final response = await service.postUser(userRequest);
                  if (response) {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => FireHomeView()));
                  } else {
                    scaffold.currentState
                        .showSnackBar(SnackBar(content: Text("Hatalı Giriş")));
                  }
                },
                label: Text("Login"))
          ],
        ),
      ),
    );
  }
}
