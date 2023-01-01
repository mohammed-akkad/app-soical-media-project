import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/cupertino.dart';

import '../model/User.dart';
import '../service/firebaseStoreHelp.dart';



class UsersProvider extends ChangeNotifier {
  List<Users> userPostList = [];

  Future getAllPostsUsersObjects() async {
    final QuerySnapshot<Map<String, dynamic>> snapshot =
        await FirebaseFireStoreHelperPost.fireStoreHelper.getAllPosts();
    userPostList.clear();
    for (var element in snapshot.docs) {
      userPostList.add(Users.postFromJson(element.data()));

    }

    notifyListeners();
  }
}
