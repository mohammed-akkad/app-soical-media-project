import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:soprise/screen/profile.dart';

class Setting extends StatefulWidget {
  const Setting({Key? key}) : super(key: key);

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  String firstName = '';
  String lastName = '';
  String ImageUrl = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Container(
          height: 100,
          width: double.infinity,
          child: Row(


            children: [
              Container(
                child: myFtureBuilderImageUser(),
                height: 45,
                width: 45,
              ),
              Container(
                child: myFtureBuilderFullNameUser(),
                padding: EdgeInsets.only(left: 20),
              )
            ],
          ),
          margin: EdgeInsets.symmetric(horizontal: 10),

        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Column(
              children: [
                Container(
                  child: Column(
                    children: [
                      Container(
                        child: Text('Account',style: TextStyle(color: Colors.blueAccent,fontWeight: FontWeight.bold),),
                      )
                    ],
                  ),
                ),
              ],
            ),
            margin: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
          ),
          Container(
            height: 10,
            width: double.infinity,
            color: Colors.grey[300],


          ),Container(
            child: Column(
              children: [
                Container(
                  child: Column(
                    children: [
                      Container(
                        child: Text('Setting',style: TextStyle(color: Colors.blueAccent,fontWeight: FontWeight.bold),),
                      ),
                      Container(
                        child: ListTile(
                          leading: Icon(Icons.password),
                          title: Text("Change Passowrd"),

                        ),
                      ),
                      Container(
                        child: ListTile(
                          leading: Icon(Icons.image),
                          title: Text("add image"),
                          onTap: () => setState(() {
                            Navigator.push(context,  MaterialPageRoute(builder: (context) => Profile(),));
                          }),

                        ),
                      ),

                    ],
                  ),
                ),

              ],
            ),
            margin: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
          ),
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
          print("$firstName $lastName + 12412421412412412");
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
          return ImageUrl != null && ImageUrl != ''
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

  void _changePassword(String currentPassword, String newPassword) async {
    final user = await FirebaseAuth.instance.currentUser;
    final cred = EmailAuthProvider.credential(
        email: user!.email.toString(), password: currentPassword);

    user?.reauthenticateWithCredential(cred).then((value) {
      user.updatePassword(newPassword).then((_) {
        //Success, do something
      }).catchError((error) {
        //Error, show something
      });
    }).catchError((err) {

    });}
}
