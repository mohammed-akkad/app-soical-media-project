import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../model/User.dart';
import '../service/firebaseAuthHelp.dart';
import 'Login.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({Key? key}) : super(key: key);

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  GlobalKey<FormState> mKey = GlobalKey<FormState>();
  TextEditingController emailControl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Reast Password"),centerTitle: true,),
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
                        height: 30,
                      ),
                      Container(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {
                            if (mKey.currentState!.validate()) {
                              FirebaseAuthHelper.resetPassword(Users(email: emailControl.text),context);
                            }
                          },
                          child: Text("Reset Password"),
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
