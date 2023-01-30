import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:soprise/model/Post.dart';

import '../model/User.dart';



class FirebaseFireStoreHelper {
  FirebaseFireStoreHelper._();
  static FirebaseFireStoreHelper fireStoreHelper = FirebaseFireStoreHelper._();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final String userCollection = "Users";

  Future SaveUserData(Users users, String id) async {
    await firestore.collection(userCollection).doc(id).set({
      "id": id,
      "email": users.email,
      "firstName":users.firstName,
      "lastName":users.lastName,
      "UserName":users.UserName,
      "image":users.image,

    });
  }
}

class FirebaseFireStoreHelperPost {
  FirebaseFireStoreHelperPost._();
  static FirebaseFireStoreHelperPost fireStoreHelper = FirebaseFireStoreHelperPost._();
  FirebaseFirestore firestore = FirebaseFirestore.instance;


  final String postCollection = "Post";

  Future SaveUserPost(Posts posts, String id) async {
    await firestore.collection(postCollection).doc(id).set({
      "id": id,
     "id_post": posts.id_post,
      "UserName":posts.UserName,
      "image":posts.image,
      "content":posts.content,
      "date":posts.date,

    });

  }

  Future<void> deletePosts(String id) {
    return firestore.collection('Posts').doc(id).delete();
  }
  Stream<QuerySnapshot> getBooks() {
    return firestore.collection('Posts').snapshots();
  }


  Future SaveUserLike(Users users) async {
    await firestore.collection(postCollection).doc().update({

      "like":users.like,

    });

  }
   Future<QuerySnapshot<Map<String, dynamic>>> getAllPosts() async {

    final QuerySnapshot<Map<String, dynamic>> allUser =
    await firestore.collection('Posts').orderBy('date').get();
    return allUser;
  }
}
