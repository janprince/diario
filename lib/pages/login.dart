// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:diario/constants.dart';
import 'package:diario/pages/signup.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _rememberMe = false;

  void _onRemeberMeChanged(bool value) {
    setState(() {
      _rememberMe = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.symmetric(vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Login",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    // Container(
                    //   decoration: BoxDecoration(
                    //       image: DecorationImage(
                    //           image: AssetImage("assets/diary.png"))),
                    //   padding: EdgeInsets.all(10),
                    // )
                  ],
                ),
              ),
              GestureDetector(
                child: Material(
                  color: kSecondary,
                  elevation: 5,
                  child: InkWell(
                    onTap: () {},
                    child: Container(
                      color: Colors.transparent,
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.g_mobiledata),
                          Text("Sign in with Google")
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 30),
                child: Divider(
                  height: 10,
                  color: Colors.grey,
                  thickness: 1,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Text(
                  "Email",
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              TextField(
                decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                    hintText: "Email",
                    border: OutlineInputBorder()),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8, top: 30),
                child: Text(
                  "Password",
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              TextField(
                decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                    hintText: "xxxxxxxxxx",
                    border: OutlineInputBorder()),
              ),
              Row(
                children: [
                  Checkbox(
                    value: _rememberMe,
                    onChanged: (value) => _onRemeberMeChanged(value!),
                  ),
                  Text(
                    "Remember me",
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: GestureDetector(
                  child: Material(
                    color: kBlue,
                    elevation: 5,
                    child: InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, "/");
                      },
                      child: Container(
                        color: Colors.transparent,
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(10),
                        child: Text(
                          "Log in",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Spacer(),
              Center(
                child: TextButton(
                  onPressed: () {},
                  child: Text(
                    "Forgot Password ?",
                    style: TextStyle(fontSize: 14.5),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Divider(
                  height: 10,
                  color: Colors.grey,
                  thickness: 1,
                ),
              ),
              Center(
                child: Column(
                  children: [
                    Text(
                      "Don't have an account ?",
                      style: TextStyle(fontSize: 14),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SignUp(),
                              ));
                        },
                        child: Text(
                          "Sign up",
                          style: TextStyle(fontSize: 14),
                        ))
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
