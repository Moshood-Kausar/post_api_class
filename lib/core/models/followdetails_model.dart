import 'dart:convert';

FollowDetailsModel followDetailsModelFromJson(String str) => FollowDetailsModel.fromJson(json.decode(str));

String followDetailsModelToJson(FollowDetailsModel data) => json.encode(data.toJson());

class FollowDetailsModel {
    FollowDetailsModel({
        this.success,
        this.followersCount,
        this.followingCount,
        this.followerList,
        this.followingList,
    });

    bool? success;
    int? followersCount;
    int? followingCount;
    List<dynamic>? followerList;
    List<dynamic>? followingList;

    factory FollowDetailsModel.fromJson(Map<String, dynamic> json) => FollowDetailsModel(
        success: json["success"],
        followersCount: json["followers_count"],
        followingCount: json["following_count"],
        followerList: List<dynamic>.from(json["follower_list"].map((x) => x)),
        followingList: List<dynamic>.from(json["following_list"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "followers_count": followersCount,
        "following_count": followingCount,
        "follower_list": List<dynamic>.from(followerList!.map((x) => x)),
        "following_list": List<dynamic>.from(followingList!.map((x) => x)),
    };
}
