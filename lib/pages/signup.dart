// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:diario/constants.dart';
import 'package:diario/pages/home.dart';
import 'package:diario/pages/login.dart';

import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool _isLoading = false;

  Future fetchStr() async {
    setState(() {
      _isLoading = true;
    });
    await new Future.delayed(const Duration(seconds: 5), () {});
    setState(() {
      _isLoading = false;
    });
    return "success";
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
                      "Sign Up",
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
                          Text("Sign up with Google")
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
                  "Name",
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
                    hintText: "Name",
                    border: OutlineInputBorder()),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8, top: 20),
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
                padding: const EdgeInsets.only(bottom: 8, top: 20),
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
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: GestureDetector(
                  child: Material(
                    color: kBlue,
                    elevation: 5,
                    child: InkWell(
                      onTap: () async {
                        var data = await fetchStr();
                        data == "success"
                            ? Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Mobile()))
                            : null;
                      },
                      child: Container(
                          color: Colors.transparent,
                          alignment: Alignment.center,
                          padding: EdgeInsets.all(10),
                          child: !_isLoading
                              ? Text(
                                  "Sign Up",
                                  style: TextStyle(color: Colors.white),
                                )
                              : Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: 18,
                                      height: 18,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 3,
                                        // value: 20,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(left: 20),
                                      child: Text(
                                        "Loading",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 15),
                                      ),
                                    )
                                  ],
                                )),
                    ),
                  ),
                ),
              ),
              Spacer(),
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
                      "Already have an account ?",
                      style: TextStyle(fontSize: 14),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => Login()));
                        },
                        child: Text(
                          "Log in",
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
