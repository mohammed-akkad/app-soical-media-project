import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:soprise/model/Post.dart';
import 'package:soprise/service/storage.dart';

import '../model/User.dart';
import 'firebaseStoreHelp.dart';

class FirebaseAuthHelper {
 static final String idPost = DateTime.now().toString();
  FirebaseAuthHelper._();

  static FirebaseAuthHelper firebaseAuthHelper = FirebaseAuthHelper._();

  static FirebaseAuth auth = FirebaseAuth.instance;

  final Storage storage = Storage();

  Future register(Users users) async {
    UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: users.email!, password: users.password!);
    String id = userCredential.user!.uid;

    FirebaseFireStoreHelper.fireStoreHelper.SaveUserData(users, id);
  }

  LoginScreen(Users users) async {
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: users!.email!, password: users!.password!);
      // storage.writeSecData("email", users!.email!);
      // storage.writeSecData("username", users!.UserName!);
      final String id = userCredential.user!.uid;

      return id;
    } on FirebaseAuthException catch (e) {
      print("SignAccount : Code : ${e.code}");
      msg("${e.code}");
      // if (e.code == "invalid-email") {
      //   msg("invalid email");
      // } else if (e.code == "user-disabled") {
      //   msg("user disabled");
      // } else if (e.code == "user-not-found") {
      //   msg("user not found");
      // } else if (e.code == "wrong-password") {
      //   msg("wrong password");
      // }
    } catch (e) {
      print("SignAccouunt : Exception $e");
    }
  }

  Future logout() async {
    await auth.signOut();
  }

  static Future resetPassword(Users users, BuildContext context) async {
    showDialog(
        context: context,
        builder: (context) => Center(
              child: CircularProgressIndicator(),
            ),
        barrierDismissible: false);
    try {
      await auth.sendPasswordResetEmail(email: users.email!);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Password Reset, Email Sent to Create now Password")));
      Navigator.of(context).popUntil((route) => route.isFirst);
    } on FirebaseAuthException catch (e) {
      print("$e");
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("${e.message}")));
      Navigator.of(context).pop();
    }
  }

  static createPost(Users users) async {


    FirebaseFirestore firestore = FirebaseFirestore.instance;
    final String idUser = auth.currentUser!.uid.toString();

    try {
      await firestore.collection('Posts').doc(idPost).set({
        "id": idUser,
        "id_post": users.id_post,
        "lastName":users.lastName,
        "firstName":users.firstName,
        "image":users.image,
        "content":users.content,
        "date":users.date,

      });
    } catch (e) {}
  }

  void msg(String msg) {
    Fluttertoast.showToast(
        msg: "$msg",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}
