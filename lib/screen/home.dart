import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soprise/main.dart';

import 'package:soprise/screen/Login.dart';
import 'package:soprise/screen/profile.dart';
import 'package:soprise/screen/setting.dart';
import 'package:soprise/service/storage.dart';

import '../Provider/UsersProvider.dart';
import '../model/User.dart';
import '../service/firebaseAuthHelp.dart';
import '../service/firebaseDataHelp.dart';
import 'createPost.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List icon = [
    Icons.home,
    Icons.book,
    Icons.newspaper,
    Icons.shopping_basket_sharp,
    Icons.add_shopping_cart,
    Icons.person_pin,
    Icons.settings,
    Icons.logout
  ];

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;

  String firstName = 'New';
  String lastName = 'User';
  String? ImageUrl = null;
  Storage storage = Storage();

  bool like = false;

  CollectionReference reference =
      FirebaseFirestore.instance.collection('Users');
  var currentUser = FirebaseAuthHelper.auth.currentUser;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<UsersProvider>(context, listen: false)
        .getAllPostsUsersObjects();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<UsersProvider>(
        builder: (context, userProvider, child) => userProvider
                .userPostList.isEmpty
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: userProvider.userPostList.length,
                itemBuilder: (context, index) {
                  return Container(
                    height: 200,
                    child: Card(
                      elevation: 10,
                      color: Colors.grey,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            child: Row(
                              children: [
                                Container(
                                  child: CircleAvatar(
                                    backgroundImage: NetworkImage(
                                        "${userProvider.userPostList[index].image}"),
                                  ),
                                  height: 40,
                                  width: 40,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      child: Text(
                                          "${userProvider.userPostList[index].firstName} ${userProvider.userPostList[index].lastName}"),
                                      padding: EdgeInsets.only(left: 10),
                                    ),
                                    Container(
                                      child: Text(
                                        "${userProvider.userPostList[index].date}",
                                        style: TextStyle(fontSize: 10),
                                      ),
                                      padding: EdgeInsets.only(left: 10,top: 5),
                                    )
                                  ],
                                )
                              ],
                            ),
                            margin: EdgeInsets.symmetric(horizontal: 20),
                          ),
                          Container(
                            alignment: Alignment.topLeft,
                            child: Text("${userProvider.userPostList[index].content}"),
                            margin: EdgeInsets.symmetric(horizontal: 30,vertical: 10),
                          )
                        ],
                      ),
                    ),
                    margin: EdgeInsets.symmetric(vertical: 5,horizontal: 5),
                  );
                },
              ),
      ),
      drawer: Drawer(
        child: DrawerHeader(
            child: Center(
          child: Column(
            children: [
              SizedBox(
                height: 30,
              ),
              Container(
                width: 150,
                height: 150,
                child: myFtureBuilderImageUser(),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                child: myFtureBuilderFullNameUser(),
              ),
              SizedBox(
                height: 40,
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    child: Column(
                      children: [
                        Divider(),
                        ListTile(
                          leading: Icon(
                            icon[0],
                            color: Color(0xffF3B2BD),
                          ),
                          title: Text("Home"),
                          onTap: () {
                            setState(() {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Home(),
                                  ));
                            });
                          },
                        ),
                        Divider(),
                        ListTile(
                          leading: Icon(
                            icon[1],
                            color: Color(0xffF3B2BD),
                          ),
                          title: Text("New Post"),
                          onTap: () {
                            setState(() {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => CreatePost(),
                                  ));
                            });
                          },
                        ),
                        Divider(),
                        ListTile(
                          leading: Icon(
                            icon[6],
                            color: Color(0xffF3B2BD),
                          ),
                          title: Text("Settings"),
                          onTap: () {
                            setState(() {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Setting(),
                                  ));
                            });
                          },
                        ),
                        Divider(),
                        ListTile(
                          leading: Icon(
                            icon[7],
                            color: Color(0xffF3B2BD),
                          ),
                          title: Text("Logout"),
                          onTap: () {
                            setState(() {
                              FirebaseAuthHelper.firebaseAuthHelper
                                  .logout()
                                  .whenComplete(() {
                                storage.deleteSecData('email');
                              }).whenComplete(() {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Login(),
                                  ),
                                );
                              });
                            });
                          },
                        ),
                        Divider(),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        )),
      ),
      appBar: AppBar(
        title: Text('Home'),
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
          return Container(

            child: Text(firstName + " " + lastName,
                style: TextStyle(fontSize: 16)),
            padding: EdgeInsets.only(bottom: 20, right: 10),
          );
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

  FutureBuilder myFtureBuilderDatePost() {
    String date = '';
    return FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
      future: FirebaseFirestore.instance.collection('Posts').doc().get(),
      builder: (_, snapshot) {
        if (snapshot.hasData) {
          var data = snapshot.data!.data();
          date = data!['date'];
          print("$date  + 1241t2421412412412");
          return Container(
            width: 200,
            child: Text(date, style: TextStyle(fontSize: 10)),
            padding: EdgeInsets.only(bottom: 20, right: 10),
          );
        } else {
          Text("User name",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20));
        }
        return Text('date');
      },
    );
  }
}
