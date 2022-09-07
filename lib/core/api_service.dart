import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:post_api_class/core/base_api.dart';
import 'package:post_api_class/core/base_url.dart';
import 'package:post_api_class/core/models/followdetails_model.dart';
import 'package:post_api_class/core/models/likepost_model.dart';
import 'package:post_api_class/core/models/logout_model.dart';
import 'package:post_api_class/core/models/post_model.dart';
import 'package:post_api_class/core/models/register_model.dart';
import 'package:post_api_class/core/models/topic_model.dart';
import 'package:post_api_class/core/models/userinfo_model.dart';
import 'package:post_api_class/core/models/users_model.dart';
import 'package:post_api_class/core/models/userposts_model.dart';
import 'package:post_api_class/data/custom_function.dart';
import 'package:post_api_class/data/data_storage.dart';

import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';

BaseUrl url = BaseUrl();
CustomFunction function = CustomFunction();

class ApiService extends BaseApi {
  @override
  Future<AuthModel> registerApi({name, email, pass}) async {
    Map body = {
      "email": email,
      "name": name,
      "password": pass,
    };

    ///for the body type of Api

    try {
      final response = await http.post(
        Uri.parse(url.register),
        body: body,
        // body: jsonEncode({
        //   "email": email,
        //   "name": name,
        //   "password": pass,
        // }), //for raw type of Api
      );
      final res = jsonDecode(response.body);
      if (response.statusCode == 201 && res['status'] == true) {
        AuthModel register = authModelFromJson(response.body);

        function.storeCredentials(
            token: register.token, userid: register.userId);
        return AuthModel(
          status: true,
          message: "${register.message}",
          token: register.token,
          userId: register.userId,
          email: register.email,
        );
      }

      return AuthModel(status: false, message: res['message']);
    } on SocketException catch (_) {
      return AuthModel(message: 'No internet', status: false);
    } on TimeoutException catch (_) {
      return AuthModel(message: 'Time out', status: false);
    } catch (e) {
      return AuthModel(status: false, message: e.toString());
    }
  }

  @override
  Future<AuthModel> loginApi({email, pass}) async {
    Map body = {
      "email": email,
      "password": pass,
    };

    ///for the body type of Api

    try {
      final response = await http.post(
        Uri.parse(url.login),
        body: body,
        // body: jsonEncode({
        //   "email": email,
        //   "name": name,
        //   "password": pass,
        // }), //for raw type of Api
      );
      final res = jsonDecode(response.body);
      if (response.statusCode == 200 && res['status'] == true) {
        AuthModel register = authModelFromJson(response.body);
        function.storeCredentials(
            token: register.token, userid: register.userId);
        return AuthModel(
          status: true,
          message: "${register.message}",
          token: register.token,
          userId: register.userId,
          email: register.email,
        );
      }

      return AuthModel(status: false, message: res['message']);
    } on SocketException catch (_) {
      return AuthModel(message: 'No internet', status: false);
    } on TimeoutException catch (_) {
      return AuthModel(message: 'Time out', status: false);
    } catch (e) {
      return AuthModel(status: false, message: e.toString());
    }
  }

  @override
  Future<UserInfoModel> userinfoApi() async {
    final prefs = await StreamingSharedPreferences.instance;
    final getInfo = InfoStorage(prefs);
    String token = getInfo.token.getValue();
    try {
      final response = await http.get(Uri.parse(url.userinfo),
          headers: {'Authorization': 'Bearer $token'});
      final res = jsonDecode(response.body);
      if (response.statusCode == 200 && res['status'] == true) {
        UserInfoModel info = userInfoModelFromJson(response.body);
        function.storeInfo(
          bio: info.bio ?? '',
          dob: info.dob ?? '',
          email: info.email ?? '',
          gender: info.gender ?? '',
          img: info.profileImage ?? '',
          name: info.name,
        );
        return UserInfoModel(
          status: true,
          message: info.message,
        );
      }

      return UserInfoModel(status: false, message: res['message']);
    } on SocketException catch (_) {
      return UserInfoModel(message: 'No internet', status: false);
    } on TimeoutException catch (_) {
      return UserInfoModel(message: 'Time out', status: false);
    } catch (e) {
      return UserInfoModel(status: false, message: e.toString());
    }
  }

  @override
  Future<FirstPostModel> firstpostApi() async {
    final prefs = await StreamingSharedPreferences.instance;
    final getInfo = InfoStorage(prefs);
    String token = getInfo.token.getValue();
    try {
      final response = await http.get(Uri.parse(url.firstpost),
          headers: {'Authorization': 'Bearer $token'});

      final res = jsonDecode(response.body);

      if (response.statusCode == 200 && res['status'] == true) {
        FirstPostModel firstpost = firstPostModelFromJson(response.body);

        debugPrint(response.body);

        return FirstPostModel(
            status: true, message: firstpost.message, posts: firstpost.posts);
      }

      return FirstPostModel(status: false, message: res['message']);
    } on SocketException catch (_) {
      return FirstPostModel(message: 'No internet', status: false);
    } on TimeoutException catch (_) {
      return FirstPostModel(message: 'Time out', status: false);
    } catch (e) {
      return FirstPostModel(status: false, message: e.toString());
    }
  }

  @override
  Future<LogoutModel> logoutApi() async {
    final prefs = await StreamingSharedPreferences.instance;
    final getInfo = InfoStorage(prefs);
    String token = getInfo.token.getValue();
    try {
      final response = await http.get(Uri.parse(url.logout),
          headers: {'Authorization': 'Bearer $token'});
      final res = jsonDecode(response.body);
      if (response.statusCode == 200 && res['status'] == true) {
        LogoutModel topic = logoutModelFromJson(response.body);

        return LogoutModel(
          status: true,
          message: topic.message,
        );
      }

      return LogoutModel(status: false, message: res['message']);
    } on SocketException catch (_) {
      return LogoutModel(message: 'No internet', status: false);
    } on TimeoutException catch (_) {
      return LogoutModel(message: 'Time out', status: false);
    } catch (e) {
      return LogoutModel(status: false, message: e.toString());
    }
  }

  @override
  Future<TopicsModel> topics() async {
    final prefs = await StreamingSharedPreferences.instance;
    final getInfo = InfoStorage(prefs);
    String token = getInfo.token.getValue();
    try {
      final response = await http.get(Uri.parse(url.topics),
          headers: {'Authorization': 'Bearer $token'});
      final res = jsonDecode(response.body);
      if (response.statusCode == 200 && res['status'] == true) {
        TopicsModel topic = topicsModelFromJson(response.body);

        return TopicsModel(
          status: true,
          message: topic.message,
          topics: topic.topics,
        );
      }

      return TopicsModel(status: false, message: res['message']);
    } on SocketException catch (_) {
      return TopicsModel(message: 'No internet', status: false);
    } on TimeoutException catch (_) {
      return TopicsModel(message: 'Time out', status: false);
    } catch (e) {
      return TopicsModel(status: false, message: e.toString());
    }
  }

  @override
  Future<FollowDetailsModel> followdetailApi() async {

   final prefs = await StreamingSharedPreferences.instance;
    final getInfo = InfoStorage(prefs);
    String token = getInfo.token.getValue();
    try {
      final response = await http.get(Uri.parse(url.followdetails),
          headers: {'Authorization': 'Bearer $token'});

      final res = jsonDecode(response.body);

      if (response.statusCode == 200 && res['status'] == true) {
        FollowDetailsModel followdetails =  followDetailsModelFromJson(response.body);

        debugPrint(response.body);

        return FollowDetailsModel(
            success: true,  
     followersCount:followdetails.followersCount,
   followingCount:followdetails.followingCount,
     followerList:followdetails.followerList,
   followingList:followdetails.followingList);
      }

      return FollowDetailsModel(success: false,);
    } on SocketException catch (_) {
      return FollowDetailsModel( success: false);
    } on TimeoutException catch (_) {
      return FollowDetailsModel( success: false);
    } catch (e) {
      return FollowDetailsModel(success: false,);
    }
  }

  @override
  Future<UsersModel> userApi() async {
    final prefs = await StreamingSharedPreferences.instance;
    final getInfo = InfoStorage(prefs);
    String token = getInfo.token.getValue();
    try {
      final response = await http.get(Uri.parse(url.users),
          headers: {'Authorization': 'Bearer $token'});

      final res = jsonDecode(response.body);

      if (response.statusCode == 200 && res['success'] == true) {
        UsersModel users = usersModelFromJson(response.body);

        debugPrint(response.body);

        return UsersModel(
            success: true, message: users.message, user: users.user);
      }

      return UsersModel(success: false, message: res['message']);
    } on SocketException catch (_) {
      return UsersModel(message: 'No internet', success: false);
    } on TimeoutException catch (_) {
      return UsersModel(message: 'Time out', success: false);
    } catch (e) {
      return UsersModel(success: false, message: e.toString());
    }
  }

  @override
  Future<UserPostsModel> userpostsApi() async {
    final prefs = await StreamingSharedPreferences.instance;
    final getInfo = InfoStorage(prefs);
    String token = getInfo.token.getValue();
    try {
      final response = await http.get(Uri.parse(url.userposts),
          headers: {'Authorization': 'Bearer $token'});

      final res = jsonDecode(response.body);

      if (response.statusCode == 200 && res['status'] == true) {
        UserPostsModel userposts = userPostsModelFromJson(response.body);

        debugPrint(response.body);

        return UserPostsModel(
            status: true, message: userposts.message, posts: userposts.posts);
      }

      return UserPostsModel(status: false, message: res['message']);
    } on SocketException catch (_) {
      return UserPostsModel(message: 'No internet', status: false);
    } on TimeoutException catch (_) {
      return UserPostsModel(message: 'Time out', status: false);
    } catch (e) {
      return UserPostsModel(status: false, message: e.toString());
    }
  }

  @override
  Future<LikePostModel> likepostApi({id})async{
    // TODO: implement likepostApi
     Map body = {
      "id":id.toString(),
      
    };
    final prefs = await StreamingSharedPreferences.instance;
    final getInfo = InfoStorage(prefs);
    String token = getInfo.token.getValue();

   

    try {
      final response = await http.post(
        Uri.parse(url.likepost),
        body: body,
        headers: {'Authorization': 'Bearer $token'}
       
      );
      final res = jsonDecode(response.body);
      if (response.statusCode == 200) {
       LikePostModel like = likePostModelFromJson(response.body);

        
        return LikePostModel(
          status: true,
          message: 'liked',
          success: Success(id:like.success!.id, likeableId: like.success!.likeableId )
        
        );
      }

      return LikePostModel(status: false, message:'Error Occured');
    } on SocketException catch (_) {
      return LikePostModel(message: 'No internet',status: false);
    } on TimeoutException catch (_) {
      return LikePostModel(message: 'Time out', status: false);
    } catch (e) {
      return LikePostModel(status: false, message: e.toString());
    }
  }
}
