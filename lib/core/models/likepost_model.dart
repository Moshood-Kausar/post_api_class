import 'dart:convert';

LikePostModel likePostModelFromJson(String str) =>
    LikePostModel.fromJson(json.decode(str));

String likePostModelToJson(LikePostModel data) => json.encode(data.toJson());

class LikePostModel {
  LikePostModel({
    this.success,
    this.message,
    this.status,
  });

  Success? success;
  bool? status;
  String? message;

  factory LikePostModel.fromJson(Map<String, dynamic> json) => LikePostModel(
        success: Success.fromJson(json["success"]),
       message: json["message"],
        status: json["status"]

      );

  Map<String, dynamic> toJson() => {

        "success": success!.toJson(),
        "status": status,
        "message": message,
      };
}

class Success {
  Success({
    this.likeableType,
    this.likeableId,
    this.userId,
    this.updatedAt,
    this.createdAt,
    this.id,
  });

  String? likeableType;
  int? likeableId;
  int? userId;
  DateTime? updatedAt;
  DateTime? createdAt;
  int? id;

  factory Success.fromJson(Map<String, dynamic> json) => Success(
        likeableType: json["likeable_type"],
        likeableId: json["likeable_id"],
        userId: json["user_id"],
        updatedAt: DateTime.parse(json["updated_at"]),
        createdAt: DateTime.parse(json["created_at"]),
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "likeable_type": likeableType,
        "likeable_id": likeableId,
        "user_id": userId,
        "updated_at": updatedAt!.toIso8601String(),
        "created_at": createdAt!.toIso8601String(),
        "id": id,
      };
}
