import 'dart:convert';

UserPostsModel userPostsModelFromJson(String str) => UserPostsModel.fromJson(json.decode(str));

String userPostsModelToJson(UserPostsModel data) => json.encode(data.toJson());

class UserPostsModel {
    UserPostsModel({
        this.status,
        this.message,
        this.posts,
    });

    bool? status;
    String? message;
    Posts? posts;

    factory UserPostsModel.fromJson(Map<String, dynamic> json) => UserPostsModel(
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

    List<dynamic>? data;
    int? total;
    int? itemCount;
    int? perPage;
    int?currentPage;
    int? totalPages;
    dynamic previousPage;
    dynamic nextPage;

    factory Posts.fromJson(Map<String, dynamic> json) => Posts(
        data: List<dynamic>.from(json["data"].map((x) => x)),
        total: json["total"],
        itemCount: json["item_count"],
        perPage: json["per_page"],
        currentPage: json["current_page"],
        totalPages: json["total_pages"],
        previousPage: json["previous_page"],
        nextPage: json["next_page"],
    );

    Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data!.map((x) => x)),
        "total": total,
        "item_count": itemCount,
        "per_page": perPage,
        "current_page": currentPage,
        "total_pages": totalPages,
        "previous_page": previousPage,
        "next_page": nextPage,
    };
}
