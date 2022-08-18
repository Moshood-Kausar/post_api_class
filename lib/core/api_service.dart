import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:post_api_class/core/base_api.dart';
import 'package:post_api_class/core/base_url.dart';
import 'package:post_api_class/core/models/register_model.dart';

BaseUrl url = BaseUrl();

class ApiService extends BaseApi {
  @override
  Future<AuthModel> registerApi({name, email, pass}) async {
    Map body = {
      "email": email,
      "name": name,
      "password": pass,
    };  ///for the body type of Api

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
    };  ///for the body type of Api

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
      if (response.statusCode == 201 && res['status'] == true) {
        AuthModel register = authModelFromJson(response.body);
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
}
