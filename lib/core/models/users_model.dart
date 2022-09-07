


import 'dart:convert';

UsersModel usersModelFromJson(String str) => UsersModel.fromJson(json.decode(str));

String usersModelToJson(UsersModel data) => json.encode(data.toJson());

class UsersModel {
    UsersModel({
        this.success,
        this.message,
        this.user,
    });

    bool? success;
    String? message;
    List<User>? user;

    factory UsersModel.fromJson(Map<String, dynamic> json) => UsersModel(
        success: json["success"],
        message: json["message"],
        user: List<User>.from(json["user"].map((x) => User.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "user": List<dynamic>.from(user!.map((x) => x.toJson())),
    };
}

class User {
    User({
        this.id,
        this.name,
        this.profileImage,
    });

    int? id;
    String? name;
    String? profileImage;

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        profileImage: json["profile_image"] == null ? null : json["profile_image"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "profile_image": profileImage == null ? null : profileImage,
    };
}
