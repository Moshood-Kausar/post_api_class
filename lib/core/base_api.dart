import 'package:post_api_class/core/models/followdetails_model.dart';
import 'package:post_api_class/core/models/likepost_model.dart';
import 'package:post_api_class/core/models/logout_model.dart';
import 'package:post_api_class/core/models/post_model.dart';
import 'package:post_api_class/core/models/register_model.dart';
import 'package:post_api_class/core/models/topic_model.dart';
import 'package:post_api_class/core/models/userinfo_model.dart';
import 'package:post_api_class/core/models/userposts_model.dart';
import 'package:post_api_class/core/models/users_model.dart';

abstract class BaseApi {
  Future<AuthModel> registerApi({name, email, pass});
  Future<AuthModel> loginApi({email, pass});
  Future<UserInfoModel> userinfoApi();
  Future<LogoutModel> logoutApi();
  Future<FirstPostModel> firstpostApi();
  Future<TopicsModel> topics();
  Future<UserPostsModel> userpostsApi();
  Future<UsersModel> userApi();
  Future<FollowDetailsModel> followdetailApi();
 Future<LikePostModel> likepostApi({id});
}
