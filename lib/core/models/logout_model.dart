import 'dart:convert';

LogoutModel logoutModelFromJson(String str) => LogoutModel.fromJson(json.decode(str));

String logoutModelToJson(LogoutModel data) => json.encode(data.toJson());

class LogoutModel {
    LogoutModel({
        this.status,
        this.message,
    });

    bool? status;
    String? message;

    factory LogoutModel.fromJson(Map<String, dynamic> json) => LogoutModel(
        status: json["status"],
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
    };
}
