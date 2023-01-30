import 'package:soprise/model/User.dart';

class Posts extends Users {
  String? id_post;
  String? content;
  String? date;
  String? image;
  String? UserName;
  bool? isLike;




  Posts({
    this.id_post,
    this.content,
    this.image,
    this.UserName,
    this.isLike,

    // this.date,

  });

  PostsToJson() {
    Map<String, dynamic> data = Map();
    data['id'] = id;
    data['id_post'] = id_post;
    data['firstName'] = firstName;
    data['UserName'] = UserName;
    data['content'] = content;
    data['image'] = image;
    // data['date'] = date;

    return data;
  }



  Posts.fromJson(Map<String, dynamic> data) {
    id = data['id'];
    id_post = data['id_post'];
    UserName = data['UserName'];
    image = data['image'];
    content = data['content'];
    // date = data['date'];
  }


}
