import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:post_api_class/core/base_api.dart';
import 'package:post_api_class/core/base_url.dart';
import 'package:post_api_class/core/models/register_model.dart';
import 'package:post_api_class/core/models/userinfo_model.dart';
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
        function.storeInfo(bio: info.bio ?? '',
        dob: info.dob ?? '',
        email: info.email ?? '',
       gender: info.gender?? '',
       img: info.profileImage ?? '',
       name:info.name,
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
}
