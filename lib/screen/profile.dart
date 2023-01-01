import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:soprise/model/User.dart';

import '../service/firebaseAuthHelp.dart';
import '../service/firebaseStoreHelp.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String imageUrl = '';
  GlobalKey<FormState> mKey = GlobalKey<FormState>();
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  var currentUser = FirebaseAuthHelper.auth.currentUser;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  CollectionReference reference =
      FirebaseFirestore.instance.collection('Users');

  Map image = Map();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("profile"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 50,
          ),
          Center(
            child: Container(
              child: Stack(
                children: [
                  Container(
                    child: imageUrl != null && imageUrl != ''
                        ? CircleAvatar(
                            backgroundImage: NetworkImage("${imageUrl}"),
                          )
                        : CircleAvatar(
                            backgroundImage: AssetImage(
                              "asstst/image/img_1.png",
                            ),
                          ),
                    height: 200,
                    width: 200,
                  ),
                  Container(
                    height: 50,
                    width: 50,
                    child: CircleAvatar(
                      child: IconButton(
                        onPressed: () async {
                          imageUser();
                        },
                        icon: Icon(Icons.camera_alt),
                      ),
                    ),
                    margin: EdgeInsets.only(left: 130, top: 170),
                  ),
                ],
              ),
            ),
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
                      // TextFormField(
                      //   controller: firstName,
                      //   obscureText: false,
                      //   decoration: InputDecoration(
                      //     labelText: 'First Name',
                      //     hintText: ' First Name',
                      //     border: OutlineInputBorder(
                      //       borderRadius: BorderRadius.circular(30),
                      //     ),
                      //     prefixIcon: Icon(Icons.person_outline),
                      //   ),
                      //   validator: (value) {
                      //     if (value!.isEmpty) {
                      //       return 'First Name cant be null';
                      //     } else {
                      //       return null;
                      //     }
                      //   },
                      // ),
                      // SizedBox(
                      //   height: 10,
                      // ),
                      // TextFormField(
                      //   controller: lastName,
                      //   obscureText: false,
                      //   decoration: InputDecoration(
                      //     labelText: 'Last Name',
                      //     hintText: ' Last Name',
                      //     border: OutlineInputBorder(
                      //       borderRadius: BorderRadius.circular(30),
                      //     ),
                      //     prefixIcon: Icon(Icons.person_outline),
                      //   ),
                      //   validator: (value) {
                      //     if (value!.isEmpty) {
                      //       return 'Last Name cant be null';
                      //     } else {
                      //       return null;
                      //     }
                      //   },
                      // ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        child: ElevatedButton(
                          onPressed: () async {
                            if (imageUrl.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content:
                                          Text("pleas chose image profile")));
                              return;
                            }
                            if (mKey.currentState!.validate()) {
                              // Users.infoToJson(
                              //     lastName.text, firstName.text, imageUrl);

                              Map<String, dynamic> data = Map();
                              // data['firstName'] = firstName.text;
                              // data['lastName'] = lastName.text;

                              data['image'] = imageUrl;
                              print(
                                  "${currentUser!.uid.toString()} 21e21e21d1sd12d12d12d");

                              reference
                                  .doc(currentUser!.uid.toString())
                                  .update(data);
                            }
                            setState(() {
                              print("${imageUrl.toString()}");
                            });
                          },
                          child: Text("SAVE INFO"),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              print("${imageUrl.toString()}");
                            });
                          },
                          child: Text("DEBUG"),
                        ),
                      ),
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

  void imageUser() async {
    ImagePicker imagePicker = ImagePicker();

    XFile? file = await imagePicker.pickImage(source: ImageSource.gallery);

    print("${file!.path.toString()}");
    if (file == null) return;



    String currentUser = FirebaseAuthHelper.auth.currentUser.toString();

    Reference myReferenceRoot =
        FirebaseStorage.instance.ref().child(currentUser);

    Reference myReferenceDirImage = myReferenceRoot.child('image');

    Reference myReferenceImageUpload = myReferenceDirImage.child(currentUser);

    try {
      await myReferenceImageUpload.putFile(File(file.path));
      imageUrl = await myReferenceImageUpload.getDownloadURL();
    } catch (e) {}
  }
}
