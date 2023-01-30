import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:soprise/model/Post.dart';
import 'package:soprise/model/User.dart';

import '../service/firebaseAuthHelp.dart';

class CreatePost extends StatefulWidget {
  const CreatePost({Key? key}) : super(key: key);

  @override
  State<CreatePost> createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  String firstName = '';
  String lastName = '';
  String userName = '';
  String ImageUrl = '';

  Color color = Colors.grey;
  TextEditingController postControler = TextEditingController();
  var isDisable = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back,
            size: 40,
            color: Colors.black,
          ),
        ),
        title: Text(
          'Create post',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        actions: [
          Container(
            child: MaterialButton(
              onPressed: _button,
              child: Text("Post"),
              color: color,
            ),
            margin: EdgeInsets.only(right: 10),
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            height: 60,
            width: double.infinity,
            child: Row(
              children: [
                Container(
                  child:  myFtureBuilderImageUser(),
                  height: 40,
                  width: 40,
                ),
                Container(
                  child: myFtureBuilderFullNameUser(),
                  padding: EdgeInsets.only(left: 20),
                )
              ],
            ),
            margin: EdgeInsets.symmetric(horizontal: 10),
          ),
          Container(
            height: 10,
            width: double.infinity,
            color: Colors.grey[300],
          ),
          Expanded(
            child: Container(
              child: TextField(
                controller: postControler,
                keyboardType: TextInputType.multiline,
                maxLength: null,
                maxLines: null,
                style: TextStyle(fontSize: 18),
                decoration: InputDecoration(
                  hintText: 'What on your mind?',
                  border: InputBorder.none,
                ),
              ),
              padding: EdgeInsets.symmetric(horizontal: 10),
            ),
          ),
          Container(
            height: 10,
            width: double.infinity,
            color: Colors.grey[300],
          ),
          SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }

  FutureBuilder myFtureBuilderFullNameUser() {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    return FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
      future: FirebaseFirestore.instance.collection('Users').doc(uid).get(),
      builder: (_, snapshot) {
        if (snapshot.hasData) {
          var data = snapshot.data!.data();
          firstName = data!['firstName'];
          lastName = data!['lastName'];
          print("$firstName $lastName + $userName 12412421412412412");
          return Text(firstName + " " + lastName,
              style: TextStyle(fontSize: 20));
        } else {
          Text("User name",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20));
        }
        return Text('User');
      },
    );
  }

  FutureBuilder myFtureBuilderImageUser() {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    return FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
      future: FirebaseFirestore.instance.collection('Users').doc(uid).get(),
      builder: (_, snapshot) {
        if (snapshot.hasData) {
          var data = snapshot.data!.data();
          ImageUrl = data!['image'];

          print(
              "$ImageUrl + 124124214124124121241242141241241212412421412412412");
          return ImageUrl != '' && ImageUrl != null
              ? CircleAvatar(
                  backgroundImage: NetworkImage("${ImageUrl}"),
                )
              : CircleAvatar(
                  backgroundImage: AssetImage(
                    "asstst/image/img_1.png",
                  ),
                );
        }
        return CircleAvatar(
          backgroundImage: AssetImage(
            "asstst/image/img_1.png",
          ),
        );
      },
    );
  }

  _button() {
    setState(() {
      if (postControler.text.isEmpty) {
        msg("Plesa enter what your mind?");
      } else if (postControler.text.isNotEmpty) {
        dynamic image = ImageUrl;

        color = Colors.green;
        String idPost = DateTime.now().toString();

        // String dateHour = DateTime.now().hour.toString();
        // String dateMinu = DateTime.now().minute.toString();
        // String date = "$dateHour:$dateMinu";
        var date = DateTime.now();
        var formateDate = "${date.year}-${date.month}-${date.day} ${date.hour}:${date.minute}:${date.second}";

        FirebaseAuthHelper.createPost(Users(
            content: postControler.text,
            id_post: idPost,
            image: image,
            firstName: firstName,
        lastName: lastName,
          date: formateDate,
          like: false

        ));
      }
    });
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
