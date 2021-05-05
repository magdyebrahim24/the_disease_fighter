class UserDataModel {
  CurrentUser? currentUser;
  bool? success;

  UserDataModel({this.currentUser, this.success});

  UserDataModel.fromJson(Map<String, dynamic> json) {
    currentUser = json['current_user'] != null
        ? new CurrentUser.fromJson(json['current_user'])
        : null;
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.currentUser != null) {
      data['current_user'] = this.currentUser!.toJson();
    }
    data['success'] = this.success;
    return data;
  }
}

class CurrentUser {
  String? about;
  String? avatar;
  String? dob;
  String? email;
  String? gender;
  int? id;
  String? location;
  String? name;
  String? phone;

  CurrentUser(
      {this.about,
      this.avatar,
      this.dob,
      this.email,
      this.gender,
      this.id,
      this.location,
      this.name,
      this.phone});

  CurrentUser.fromJson(Map<String, dynamic> json) {
    about = json['about'];
    avatar = json['avatar'];
    dob = json['dob'];
    email = json['email'];
    gender = json['gender'];
    id = json['id'];
    location = json['location'];
    name = json['name'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['about'] = this.about;
    data['avatar'] = this.avatar;
    data['dob'] = this.dob;
    data['email'] = this.email;
    data['gender'] = this.gender;
    data['id'] = this.id;
    data['location'] = this.location;
    data['name'] = this.name;
    data['phone'] = this.phone;
    return data;
  }
}
