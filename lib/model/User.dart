class Users {
  String? id;
  String? name;
  String? email;
  String? password;
  String? image;
  String? firstName;
  String? lastName;
  String? UserName;
  String? id_post;
  String? content;
  String? date;
  String? comment;
  bool? like;

  Users({
    this.id,
    this.email,
    this.password,
    this.firstName,
    this.lastName,
    this.UserName,
    this.id_post,
    this.content,
    this.image,
    this.date,
    this.like,
  });

  toJson() {
    Map<String, dynamic> data = Map();
    data['id'] = id;
    data['email'] = email;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['UserName'] = UserName;
    data['image'] = image;
    data['id_post'] = id_post;
    data['content'] = content;
    return data;
  }

  static infoToJson(String firstName, lastName, image) {
    Map<String, dynamic> data = Map();
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['image'] = image;

    return data;
  }

   Users.fromJson(Map<String, dynamic> data) {
    id = data['id'];

    email = data['email'];
    firstName = data['firstName'];
    lastName = data['lastName'];
    UserName = data['UserName'];
    image = data['image'];
  }
  Users.postFromJson(Map<String, dynamic> data) {
    id = data['id'];
    content = data['content'];
    date = data['date'];
    id_post = data['id_post'];
    email = data['email'];
    firstName = data['firstName'];
    lastName = data['lastName'];
    UserName = data['UserName'];
    image = data['image'];
  }

  Users.fromJsonInfo(Map<String, dynamic> data) {
    image = data['image'];
  }
}
