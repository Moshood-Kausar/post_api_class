// To parse this JSON data, do
//
//     final registerModel = registerModelFromJson(jsonString);

import 'dart:convert';


AuthModel authModelFromJson(String str) => AuthModel.fromJson(json.decode(str));

String authModelToJson(AuthModel data) => json.encode(data.toJson());

class AuthModel {
    AuthModel({
        this.status,
        this.message,
        this.token,
        this.userId,
        this.email,
    });

    bool? status;
    String? message;
    String? token;
    int? userId;
    String? email;

    factory AuthModel.fromJson(Map<String, dynamic> json) => AuthModel(
        status: json["status"],
        message: json["message"],
        token: json["token"],
        userId: json["user_id"],
        email: json["email"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "token": token,
        "user_id": userId,
        "email": email,
    };
}
