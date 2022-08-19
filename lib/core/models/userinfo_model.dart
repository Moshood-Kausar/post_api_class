// To parse this JSON data, do
//
//     final userInfoModel = userInfoModelFromJson(jsonString);

import 'dart:convert';

UserInfoModel userInfoModelFromJson(String str) => UserInfoModel.fromJson(json.decode(str));

String userInfoModelToJson(UserInfoModel data) => json.encode(data.toJson());

class UserInfoModel {
    UserInfoModel({
        this.status,
        this.message,
        this.userId,
        this.name,
        this.email,
        this.dob,
        this.profileImage,
        this.bio,
        this.gender,
    });

    bool? status;
    String? message;
    int? userId;
    String? name;
    String? email;
    dynamic dob;
    dynamic profileImage;
    dynamic bio;
    dynamic gender;

    factory UserInfoModel.fromJson(Map<String, dynamic> json) => UserInfoModel(
        status: json["status"],
        message: json["message"],
        userId: json["user_id"],
        name: json["name"],
        email: json["email"],
        dob: json["dob"],
        profileImage: json["profile_image"],
        bio: json["bio"],
        gender: json["gender"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "user_id": userId,
        "name": name,
        "email": email,
        "dob": dob,
        "profile_image": profileImage,
        "bio": bio,
        "gender": gender,
    };
}
