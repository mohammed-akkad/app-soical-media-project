import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:soprise/screen/reastPassword.dart';

import '../model/User.dart';
import '../service/firebaseAuthHelp.dart';
import 'Register.dart';
import 'home.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  GlobalKey<FormState> mKey = GlobalKey<FormState>();
  TextEditingController emailControl = TextEditingController();
  TextEditingController passwordControl = TextEditingController();
  TextEditingController nameControl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Column(
        children: [
          Container(
            child: Image.asset("asstst/image/logo.png"),
            alignment: Alignment.topCenter,
            margin: EdgeInsets.only(top: 100),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Form(
                key: mKey,
                child: Container(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 5,
                      ),
                      TextFormField(
                        controller: emailControl,
                        obscureText: false,
                        decoration: InputDecoration(
                          labelText: 'Email Address',
                          hintText: 'Enter Email Address',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          prefixIcon: Icon(Icons.email_outlined),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Emaill Address cant be null';
                          } else if (!(value!.contains("@"))) {
                            return 'Emaill Address should contain @';
                          } else {
                            return null;
                          }
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: passwordControl,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          hintText: 'Enter Password',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          prefixIcon: Icon(Icons.lock_outline),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Password cant be null';
                          } else if (value!.length < 8) {
                            return 'Password should be long ';
                          } else {
                            return null;
                          }
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),

                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        child: Row(
                          children: [
                            InkWell(
                              onTap: () {
                                setState(() {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => Register(),
                                      ));
                                });
                              },
                              child: Text(
                                "Register",
                                style:
                                    TextStyle(color: Colors.cyan, fontSize: 20),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ResetPassword(),
                                      ));
                                });
                              },
                              child: Container(
                                child: Text(
                                  "Reset Password",
                                  style: TextStyle(
                                      color: Colors.cyan, fontSize: 20),
                                ),
                                padding: EdgeInsets.only(left: 130),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () async {

                            if (mKey.currentState!.validate()) {
                              String uid = await FirebaseAuthHelper
                                  .firebaseAuthHelper
                                  .LoginScreen(Users(
                                email: emailControl.text,
                                password: passwordControl.text,
                              ));
                              if (uid != null) {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Home(),
                                    ));
                              } else {
                               
                              }
                            }
                          },
                          child: Text("Login"),
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      // Container(
                      //   width: double.infinity,
                      //   height: 50,
                      //   child: ElevatedButton(
                      //     onPressed: ()  {
                      //
                      //       Navigator.push(
                      //           context,
                      //           MaterialPageRoute(
                      //             builder: (context) => Profile(),
                      //           ));
                      //     }
                      //     ,
                      //     child: Text("Profile"),
                      //     style: ElevatedButton.styleFrom(
                      //       shape: RoundedRectangleBorder(
                      //           borderRadius: BorderRadius.circular(30)),
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                  margin: EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
