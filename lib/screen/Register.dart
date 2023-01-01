import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../model/User.dart';
import '../service/firebaseAuthHelp.dart';
import 'Login.dart';
import 'package:fluttertoast/fluttertoast.dart';


class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  GlobalKey<FormState> mKey = GlobalKey<FormState>();
  TextEditingController emailControl = TextEditingController();
  TextEditingController passwordControl = TextEditingController();
  TextEditingController userNameControl = TextEditingController();
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        controller: firstName,
                        obscureText: false,
                        decoration: InputDecoration(
                          labelText: 'First Name',
                          hintText: 'First Name',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          prefixIcon: Icon(Icons.person_outline),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'First Name cant be null';
                          } else {
                            return null;
                          }
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: lastName,
                        obscureText: false,
                        decoration: InputDecoration(
                          labelText: 'Last Name',
                          hintText: 'Last Name',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          prefixIcon: Icon(Icons.person_outline),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Last Name cant be null';
                          }  else {
                            return null;
                          }
                        },
                      ),
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
                        height: 5,
                      ),
                      TextFormField(
                        controller: userNameControl,
                        obscureText: false,
                        decoration: InputDecoration(
                          labelText: 'User Name',
                          hintText: 'User Name',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          prefixIcon: Icon(Icons.supervised_user_circle_outlined),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'User Name cant be null';
                          } else if (value.length < 6) {
                            return 'User Name should be long';
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
                        height: 30,
                      ),




                      Container(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {
                            
                            if (mKey.currentState!.validate()) {
                              FirebaseAuthHelper.firebaseAuthHelper.register(Users(
                                  email: emailControl.text,
                                  password: passwordControl.text,
                                firstName: firstName.text,
                                lastName: lastName.text,
                                UserName: userNameControl.text,



                                  ));

                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Login(),
                                  ));
                            }
                          },
                          child: Text("Sign"),
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)),
                          ),
                        ),
                      )
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
