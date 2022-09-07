// ignore_for_file: constant_identifier_names, prefer_if_null_operators, prefer_conditional_assignment, recursive_getters

import 'dart:convert';

FirstPostModel firstPostModelFromJson(String str) => FirstPostModel.fromJson(json.decode(str));

String firstPostModelToJson(FirstPostModel data) => json.encode(data.toJson());

class FirstPostModel {
    FirstPostModel({
        this.status,
        this.message,
        this.posts,
    });

    bool? status;
    String? message;
    Posts? posts;

    factory FirstPostModel.fromJson(Map<String, dynamic> json) => FirstPostModel(
        status: json["status"],
        message: json["message"],
        posts: Posts.fromJson(json["posts"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "posts": posts!.toJson(),
    };
}

class Posts {
    Posts({
        this.data,
        this.total,
        this.itemCount,
        this.perPage,
        this.currentPage,
        this.totalPages,
        this.previousPage,
        this.nextPage,
    });

    List<Datum>? data;
    int? total;
    int? itemCount;
    String? perPage;
    int? currentPage;
    int? totalPages;
    dynamic previousPage;
    String? nextPage;

    factory Posts.fromJson(Map<String, dynamic> json) => Posts(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        total: json["total"],
        itemCount: json["item_count"],
        perPage: json["per_page"],
        currentPage: json["current_page"],
        totalPages: json["total_pages"],
        previousPage: json["previous_page"],
        nextPage: json["next_page"],
    );

    Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
        "total": total,
        "item_count": itemCount,
        "per_page": perPage,
        "current_page": currentPage,
        "total_pages": totalPages,
        "previous_page": previousPage,
        "next_page": nextPage,
    };
}

class Datum {
    Datum({
        this.id,
        this.topic,
        this.title,
        this.body,
        this.imageUrl,
        this.tags,
        this.readTime,
        this.status,
        this.likes,
        this.author,
        this.createdAt,
        this.updatedAt,
    });

    int? id;
    String? topic;
    String? title;
    String? body;
    String? imageUrl;
    String? tags;
    int? readTime;
    int? status;
    int? likes;
    Author? author;
    DateTime? createdAt;
    DateTime? updatedAt;

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        topic: json["topic"],
        title: json["title"],
        body: json["body"],
        imageUrl: json["image_url"],
        tags: json["tags"] == null ? null : json["tags"],
        readTime: json["read_time"],
        status: json["status"],
        likes: json["likes"],
        author: Author.fromJson(json["author"]),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "topic": topic,
        "title": title,
        "body": body,
        "image_url": imageUrl,
        "tags": tags == null ? null : tags,
        "read_time": readTime,
        "status": status,
        "likes": likes,
        "author": author!.toJson(),
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
    };
}

class Author {
    Author({
        this.id,
        this.name,
        this.email,
    });

    int? id;
    Name? name;
    Email? email;

    factory Author.fromJson(Map<String, dynamic> json) => Author(
        id: json["id"],
        name: nameValues.map[json["name"]],
        email: emailValues.map[json["email"]],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": nameValues.reverse[name],
        "email": emailValues.reverse[email],
    };
}

enum Email { SAMUELBEEBEST_GMAIL_COM, GUSANUM5_GMAIL_COM, PAULJOKOTAGBA_GMAIL_COM }

final emailValues = EnumValues({
    "gusanum5@gmail.com": Email.GUSANUM5_GMAIL_COM,
    "pauljokotagba@gmail.com": Email.PAULJOKOTAGBA_GMAIL_COM,
    "samuelbeebest@gmail.com": Email.SAMUELBEEBEST_GMAIL_COM
});

enum Name { SAMUEL_ADEKUNLE, MATTHEW_GUSANU, PAUL_JOKOTAGBA }

final nameValues = EnumValues({
    "Matthew Gusanu": Name.MATTHEW_GUSANU,
    "Paul Jokotagba": Name.PAUL_JOKOTAGBA,
    "Samuel Adekunle": Name.SAMUEL_ADEKUNLE
});
class  EnumValues<T> {
    Map<String, T> map;
    Map<T, String>? reverseMap;

     EnumValues(this.map);

    Map<T, String> get reverse {
        if (reverseMap == null) {
            reverseMap = map.map((k, v) => MapEntry(v, k));
        }
        return reverse;
    }
}
