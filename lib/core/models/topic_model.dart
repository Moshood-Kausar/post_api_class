

import 'dart:convert';

TopicsModel topicsModelFromJson(String str) => TopicsModel.fromJson(json.decode(str));

String topicsModelToJson(TopicsModel data) => json.encode(data.toJson());

class TopicsModel {
    TopicsModel({
        this.status,
        this.message,
        this.topics,
    });

    bool? status;
    String? message;
    List<Topic>? topics;

    factory TopicsModel.fromJson(Map<String, dynamic> json) => TopicsModel(
        status: json["status"],
        message: json["message"],
        topics: List<Topic>.from(json["topics"].map((x) => Topic.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "topics": List<dynamic>.from(topics!.map((x) => x.toJson())),
    };
}

class Topic {
    Topic({
        this.id,
        this.title,
        this.description,
        this.createdAt,
        this.updatedAt,
    });

    int? id;
    String? title;
    dynamic description;
    DateTime? createdAt;
    DateTime? updatedAt;

    factory Topic.fromJson(Map<String, dynamic> json) => Topic(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
    };
}
